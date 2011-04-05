From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Apr 2011 09:36:24 +0200
Subject: [PATCH] video: mxsfb: correct typo 'FAILING' to 'FALLING'
In-Reply-To: <1301986075-3168-1-git-send-email-shawn.guo@freescale.com>
References: <20110404150430.GB13963@pengutronix.de>
	<1301986075-3168-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110405073624.GK13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 02:47:55PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> The patch should probably be split into two to separate machine code
> changes from driver ones, but that will result in build failure,
> which could be a problem for bisect, so I keep them as one patch.  
to prevent that (and if you really care) you need to add a 

#define FB_SYNC_DOTCLK_FAILING_ACT FB_SYNC_DOTCLK_FALLING_ACT

in the first patch, then fix all users and then remove the #define
again. But IMHO it's totally OK to do it in one step since all files
touched are in a single maintainer's responsibility.
(At least drivers/video/mxsfb.c went in via Sascha's tree, too.)

Reported-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

>  arch/arm/mach-mxs/include/mach/mxsfb.h |    2 +-
>  arch/arm/mach-mxs/mach-mx23evk.c       |    2 +-
>  arch/arm/mach-mxs/mach-mx28evk.c       |    2 +-
>  drivers/video/mxsfb.c                  |    6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
