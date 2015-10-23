From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 15:12:16 +0200
Subject: [PATCH v3 6/7] vfio: platform: use list of registered reset
 function
In-Reply-To: <1445603835-14506-7-git-send-email-eric.auger@linaro.org>
References: <1445603835-14506-1-git-send-email-eric.auger@linaro.org>
 <1445603835-14506-7-git-send-email-eric.auger@linaro.org>
Message-ID: <4934120.DeNtNjTIFs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 14:37:14 Eric Auger wrote:
> Remove the static lookup table and use the dynamic list of registered
> reset functions instead. Also load the reset module through its alias.
> The reset struct module pointer is stored in vfio_platform_device.
> 
> We also remove the useless struct device pointer parameter in
> vfio_platform_get_reset.
> 
> This patch fixes the issue related to the usage of __symbol_get, which
> besides from being moot, prevented compilation with CONFIG_MODULES
> disabled.
> 
> Also usage of MODULE_ALIAS makes possible to add a new reset module
> without needing to update the framework. This was suggested by Arnd.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> 
> 
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

but doesn't this need to come before patch 4/7?

	Arnd
