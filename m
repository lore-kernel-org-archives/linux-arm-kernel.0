From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Dec 2015 12:22:52 +0100
Subject: [PATCH v2] soc: mediatek: SCPSYS: use module_platform_driver
In-Reply-To: <1450263656-12513-1-git-send-email-s.hauer@pengutronix.de>
References: <1450263656-12513-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1562792.sV6cmsyeOM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 December 2015 12:00:56 Sascha Hauer wrote:
> With regulator support to the scpsys driver needs to be able to defer
> probe. Probe deferral is incompatible with module_platform_driver_probe,
> so use module_platform_driver. module_platform_driver_probe sets the
> suppress_bind_attrs. To prevent unbinding the device with
> module_platform_driver we have to set the flag explicitly in the driver
> now.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 

Looks good now,

Acked-by: Arnd Bergmann <arnd@arndb.de>
