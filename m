From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 09 Sep 2016 10:29:17 +0200
Subject: [PATCH] gpu: Remove depends on RESET_CONTROLLER when not a
 provider
In-Reply-To: <20160909013650.25166-1-stephen.boyd@linaro.org>
References: <20160909013650.25166-1-stephen.boyd@linaro.org>
Message-ID: <1473409757.3023.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 08.09.2016, 18:36 -0700 schrieb Stephen Boyd:
> These GPU drivers only depend on the RESET_CONTROLLER config
> option to fix build issues that existed when there weren't stub
> reset APIs for reset controller consumers. Given that these
> drivers aren't providing any reset controllers themselves, they
> don't actually depend on the API to build (just to function) so
> they don't need to depend on it. Remove the dependency to fix
> recursive build errors like the following:
> 
> drivers/usb/Kconfig:39:error: recursive dependency detected!
> drivers/usb/Kconfig:39: symbol USB is selected by MOUSE_APPLETOUCH
> drivers/input/mouse/Kconfig:187:        symbol MOUSE_APPLETOUCH depends on INPUT
> drivers/input/Kconfig:8:        symbol INPUT is selected by VT
> drivers/tty/Kconfig:12: symbol VT is selected by FB_STI
> drivers/video/fbdev/Kconfig:674:        symbol FB_STI depends on FB
> drivers/video/fbdev/Kconfig:5:  symbol FB is selected by DRM_KMS_FB_HELPER
> drivers/gpu/drm/Kconfig:42:     symbol DRM_KMS_FB_HELPER is selected by DRM_KMS_CMA_HELPER
> drivers/gpu/drm/Kconfig:98:     symbol DRM_KMS_CMA_HELPER is selected by DRM_IMX
> drivers/gpu/drm/imx/Kconfig:1:  symbol DRM_IMX depends on IMX_IPUV3_CORE
> drivers/gpu/ipu-v3/Kconfig:1:   symbol IMX_IPUV3_CORE depends on RESET_CONTROLLER
> drivers/reset/Kconfig:4:        symbol RESET_CONTROLLER is selected by USB_CHIPIDEA
> drivers/usb/chipidea/Kconfig:1: symbol USB_CHIPIDEA depends on USB_EHCI_HCD
> drivers/usb/host/Kconfig:84:    symbol USB_EHCI_HCD depends on USB
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Mark Yao <mark.yao@rock-chips.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

thanks
Philipp
