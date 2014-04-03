From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Apr 2014 10:01:02 +0200
Subject: [PATCH] pinctrl: capri: make Kconfig dependency more strict
In-Reply-To: <533C9B1E.6020905@broadcom.com>
References: <1396383021-2295-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <533C9B1E.6020905@broadcom.com>
Message-ID: <20140403080102.GE29751@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Apr 02, 2014 at 04:19:58PM -0700, Sherman Yin wrote:
> On 14-04-01 01:10 PM, Uwe Kleine-K?nig wrote:
> >This driver is only useful on BCM281xx, so let the driver depend on
> >ARCH_BCM_MOBILE but allow compile coverage testing.
> >The main benefit is that the driver isn't available to be selected for
> >machines that don't have the matching hardware.
> >
> >Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >---
> >  drivers/pinctrl/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> >index e49324032611..072749816cb4 100644
> >--- a/drivers/pinctrl/Kconfig
> >+++ b/drivers/pinctrl/Kconfig
> >@@ -106,7 +106,7 @@ config PINCTRL_BCM2835
> >
> >  config PINCTRL_CAPRI
> >  	bool "Broadcom Capri pinctrl driver"
> >-	depends on OF
> >+	depends on OF && (ARCH_BCM_MOBILE || COMPILE_TEST)
> >  	select PINMUX
> >  	select PINCONF
> >  	select GENERIC_PINCONF
> >
> 
> Looks good. Just wondering how you've come across this driver (and
> PINCTRL_MSM8X74)?
Well, I was annoyed by being asked if I want to enable them for my efm32
machine during make oldconfig after updating the kernel. :-)

> Reviewed-by: Sherman Yin <syin@broadcom.com>
Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
