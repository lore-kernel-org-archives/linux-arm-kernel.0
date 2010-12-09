From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Dec 2010 10:37:46 +0100
Subject: [PATCH v2 14/15] ARM: mxs: Add initial mx28evk support
In-Reply-To: <AANLkTin3-f7x2BXS=zTYYw+uWiu9UYG8sPWdQXWcxpxn@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-11-git-send-email-shawn.guo@freescale.com>
	<20101208202822.GD17441@pengutronix.de>
	<AANLkTiny2P3RobZfq_G_OPHu_SLjZ2w9CFhU7HgL3VPx@mail.gmail.com>
	<20101209083237.GO17441@pengutronix.de>
	<AANLkTin3-f7x2BXS=zTYYw+uWiu9UYG8sPWdQXWcxpxn@mail.gmail.com>
Message-ID: <20101209093746.GU17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn
On Thu, Dec 09, 2010 at 05:03:54PM +0800, Shawn Guo wrote:
> 2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello Shwan,
ups, sorry for mistyping your name.

> > On Thu, Dec 09, 2010 at 03:04:37PM +0800, Shawn Guo wrote:
> >> 2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >> > On Wed, Dec 08, 2010 at 12:32:02AM +0800, Shawn Guo wrote:
> >> >> +static iomux_cfg_t mx28evk_pads[] = {
> >> > This can be const and __initconst, ditto for mx23evk
> >> >
> >> With u64 iomux_cfg_t changes, I'm afraid the suggestion becomes invalid.
> > Really? Why?
> >
> I'm confused by the compiling error below when adding __initconst for
> mx28evk_pads[], and mistakenly blaming u64 iomux_cfg_t changes.
> 
> arch/arm/mach-mxs/mach-mx28evk.c: In function ?mx28evk_init?:
> arch/arm/mach-mxs/mach-mx28evk.c:34: error: mx28_fec_pdata causes a
> section type conflict
> make[1]: *** [arch/arm/mach-mxs/mach-mx28evk.o] Error 1
> make: *** [arch/arm/mach-mxs] Error 2
> 
> Actually it can be fixed by the following change.
> 
> -static const struct fec_platform_data mx28_fec_pdata __initconst = {
> +static struct fec_platform_data mx28_fec_pdata __initconst = {
>          .phy = PHY_INTERFACE_MODE_RMII,
>  };
this change is wrong.  You need to assert that all data being marked
with __initconst is const, too.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
