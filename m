From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Sep 2012 09:38:08 +0200
Subject: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
In-Reply-To: <20120925073317.GI27291@S2101-09.ap.freescale.net>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
 <20120925071505.GG27291@S2101-09.ap.freescale.net>
 <20120925072714.GY1322@pengutronix.de>
 <20120925073317.GI27291@S2101-09.ap.freescale.net>
Message-ID: <20120925073808.GZ1322@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 03:33:19PM +0800, Shawn Guo wrote:
> On Tue, Sep 25, 2012 at 09:27:15AM +0200, Sascha Hauer wrote:
> > > >  Optional properties:
> > > >  - fsl,cd-controller : Indicate to use controller internal card detection
> > > >  - fsl,wp-controller : Indicate to use controller internal write protection
> > > > +- bus-width : Maximum supported bus width. Defaults to 4 if omitted
> > > >
> > > This is a common mmc property documented in bindings/mmc/mmc.txt.
> > > Instead of duplicating the documentation, we should try to make our
> > > implementation conform to the common definition of the property.
> > 
> > It is conform to the common definition, so all I have to do is drop the
> > line duplicating the docs. That's easy ;)
> > 
> Maybe not.  The common binding defines it as a required property while
> the patch implements it as an optional one.

So you want to make the code conform to the common spec which has
bus-width as a required property. Is this really worth it to add an
incompatible change to our devicetrees?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
