From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 18 Feb 2015 20:54:46 +0100
Subject: drm: bridge: ps8622 and ptn3460 depend on gpiolib
In-Reply-To: <19803561.otRxsE7o5u@wuerfel>
References: <19803561.otRxsE7o5u@wuerfel>
Message-ID: <54E4EE06.8050101@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On 02/18/2015 05:09 PM, Arnd Bergmann wrote:
> The ptn3460 driver recently started usign the gpiod interface
> which is only available on platforms that come with GPIOLIB
> support, resulting in a compile-time error:
> 
> drivers/gpu/drm/bridge/ps8622.c: In function 'ps8622_pre_enable':
> drivers/gpu/drm/bridge/ps8622.c:368:2: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]
>   gpiod_set_value(ps8622->gpio_rst, 0);
>   ^
> drivers/gpu/drm/bridge/ps8622.c: In function 'ps8622_probe':
> drivers/gpu/drm/bridge/ps8622.c:584:2: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]
>   ps8622->gpio_slp = devm_gpiod_get(dev, "sleep");
>   ^
> 
> Similarly, the newly added ps8622 driver started out with the same
> problem.
> 
> This patch adds explicit Kconfig dependencies to avoid trying to
> build invalid configurations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: f1336e6afb ("drm/bridge: Add I2C based driver for ps8622/ps8625 bridge")
> Fixes: af478d8823 ("drm/bridge: ptn3460: use gpiod interface")
>

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
