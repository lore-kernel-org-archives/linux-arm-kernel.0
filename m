From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Jul 2011 18:25:12 +0900
Subject: [PATCH 4/4] arm: mach-s3c2440: mini2440: fix section mismatch
In-Reply-To: <20110708091218.GD2414@n2100.arm.linux.org.uk>
References: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
	<1310033919-4245-5-git-send-email-w.sang@pengutronix.de>
	<001c01cc3d35$2aa7e8f0$7ff7bad0$%kim@samsung.com>
	<20110708091218.GD2414@n2100.arm.linux.org.uk>
Message-ID: <001001cc3d50$f3b47630$db1d6290$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Fri, Jul 08, 2011 at 03:06:17PM +0900, Kukjin Kim wrote:
> > Wolfram Sang wrote:
> > >
> > > If mini2440_init() is in __init, mini2440_parse_features() should also
> > > be in __init. Fixes:
> > >
> > > (.text+0x9adc): Section mismatch in reference from the function
> > > mini2440_parse_features.clone.0() to the (unknown reference)
> > .init.data:(unknown)
> > > The function mini2440_parse_features.clone.0() references the (unknown
> > reference)
> > > __initdata (unknown).
> >
> > But I couldn't find above "Section mismatch" in my building with
> > CONFIG_DEBUG_SECTION_MISMATCH=y.
> 
> Your compiler may have inlined the function, so defeating the check.
> 
> static struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
> 
> and mini2440_parse_features() references this variable.  Therefore
> either mini2440_parse_features() needs to be marked __init (it's
> only caller is from __init, so that seems sensible) or the
> __initdata markers on the referenced data need to be removed.
> 
> Adding __init looks like the right thing.

OK, applied this into -fix.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
