From: shawn.gsc@gmail.com (Shawn Guo)
Date: Thu, 9 Dec 2010 17:03:54 +0800
Subject: [PATCH v2 14/15] ARM: mxs: Add initial mx28evk support
In-Reply-To: <20101209083237.GO17441@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-11-git-send-email-shawn.guo@freescale.com>
	<20101208202822.GD17441@pengutronix.de>
	<AANLkTiny2P3RobZfq_G_OPHu_SLjZ2w9CFhU7HgL3VPx@mail.gmail.com>
	<20101209083237.GO17441@pengutronix.de>
Message-ID: <AANLkTin3-f7x2BXS=zTYYw+uWiu9UYG8sPWdQXWcxpxn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Shwan,
>
> On Thu, Dec 09, 2010 at 03:04:37PM +0800, Shawn Guo wrote:
>> 2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> > On Wed, Dec 08, 2010 at 12:32:02AM +0800, Shawn Guo wrote:
>> >> +static iomux_cfg_t mx28evk_pads[] = {
>> > This can be const and __initconst, ditto for mx23evk
>> >
>> With u64 iomux_cfg_t changes, I'm afraid the suggestion becomes invalid.
> Really? Why?
>
I'm confused by the compiling error below when adding __initconst for
mx28evk_pads[], and mistakenly blaming u64 iomux_cfg_t changes.

arch/arm/mach-mxs/mach-mx28evk.c: In function ?mx28evk_init?:
arch/arm/mach-mxs/mach-mx28evk.c:34: error: mx28_fec_pdata causes a
section type conflict
make[1]: *** [arch/arm/mach-mxs/mach-mx28evk.o] Error 1
make: *** [arch/arm/mach-mxs] Error 2

Actually it can be fixed by the following change.

-static const struct fec_platform_data mx28_fec_pdata __initconst = {
+static struct fec_platform_data mx28_fec_pdata __initconst = {
         .phy = PHY_INTERFACE_MODE_RMII,
 };

-- 
Regards,
Shawn
