From: cjb@laptop.org (Chris Ball)
Date: Tue, 25 Sep 2012 03:52:09 -0400
Subject: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
In-Reply-To: <20120925073808.GZ1322@pengutronix.de> (Sascha Hauer's message of
 "Tue, 25 Sep 2012 09:38:08 +0200")
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
 <20120925071505.GG27291@S2101-09.ap.freescale.net>
 <20120925072714.GY1322@pengutronix.de>
 <20120925073317.GI27291@S2101-09.ap.freescale.net>
 <20120925073808.GZ1322@pengutronix.de>
Message-ID: <m3k3vilety.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 25 2012, Sascha Hauer wrote:
>> > > > +- bus-width : Maximum supported bus width. Defaults to 4 if omitted
>> > > >
>> > > This is a common mmc property documented in bindings/mmc/mmc.txt.
>> > > Instead of duplicating the documentation, we should try to make our
>> > > implementation conform to the common definition of the property.
>> > 
>> > It is conform to the common definition, so all I have to do is drop the
>> > line duplicating the docs. That's easy ;)
>> > 
>> Maybe not.  The common binding defines it as a required property while
>> the patch implements it as an optional one.
>
> So you want to make the code conform to the common spec which has
> bus-width as a required property. Is this really worth it to add an
> incompatible change to our devicetrees?

We could also break the stalemate by just changing the common spec to
have bus-width become optional, default 4.  It's not going to break the
code of anyone who's been treating it as required.  I don't think there
there was a principled reason behind making it required.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
