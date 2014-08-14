From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Aug 2014 20:09:31 +0100
Subject: [alsa-devel] [PATCH] ASoC: rt286: Add API to set supported jack
 type
In-Reply-To: <1408004988.2506.13.camel@loki>
References: <1407217970-20126-1-git-send-email-bardliao@realtek.com>
 <20140806205421.GZ17528@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7608E00@RTITMBSV03.realtek.com.tw>
 <20140807173136.GN17528@sirena.org.uk>
 <1407751185.2487.150.camel@loki>
 <20140811122415.GZ17528@sirena.org.uk>
 <1408004988.2506.13.camel@loki>
Message-ID: <20140814190931.GD17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 09:29:48AM +0100, Liam Girdwood wrote:
> On Mon, 2014-08-11 at 13:24 +0100, Mark Brown wrote:

> > Sounds like DMI is going to be needed then - whatever ends up being done
> > I'd expect it should just be a case of putting the checks done to work
> > out the machine configuration into the CODEC driver instead of the
> > machine driver.  If it looks ugly this can be used to explain to people
> > why we need something more sensible!

> It sure will be ugly ;) This would involve the codec driver checking for
> the existence of the Broadwell ADSP ACPI ID and then configuring jack
> mode depending on whether it finds this ID or not.

> We have the opposite implementation atm where the Broadwell machine
> driver sets the jack mode at machine driver init time.

> I'm not sure that showing ugly code here would help justify anything
> either as we will kind of be at the mercy of whether the Windows driver
> needs this information or not.

It's going to be ugly either way, it's just a question of how the code
get partitioned - I'd expect that whatever does this is going to end up
having to cope with working out which configuration to apply anyway.

What it does buy us is consistency in where these things get handled -
it's easier to have a consistent rule that the device is responsible for
platform data (wherever that actually comes from) than to have different
rules for different firmware styles and it'll help with back pressure on
other people who do care more about Linux even if it doesn't help with
the immediate use cases.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140814/939d3f31/attachment.sig>
