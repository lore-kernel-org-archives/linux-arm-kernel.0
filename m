From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 20 May 2015 10:14:21 +0900
Subject: [PATCH] video: exynos: fix modular build
In-Reply-To: <2708563.ADEZz3igC5@wuerfel>
References: <2708563.ADEZz3igC5@wuerfel>
Message-ID: <555BDFED.7060607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.05.2015 21:17, Arnd Bergmann wrote:
> The s6e8ax0 driver has a dependency on BACKLIGHT_CLASS_DEVICE,
> which can be configured as a loadable module, so we have to
> make the driver a tristate symbol as well, to avoid this error:
> 
> drivers/built-in.o: In function `s6e8ax0_probe':
> :(.text+0x23a48): undefined reference to `devm_backlight_device_register'
> 
> This also means we get another error from a missing export, which
> this fixes as well:
> 
> ERROR: "exynos_mipi_dsi_register_lcd_driver" [drivers/video/fbdev/exynos/s6e8ax0.ko] undefined!
> 
> Finally, the EXYNOS_VIDEO option is turned into tristate as well
> for good measure, as all framebuffer drivers should be configurable
> as modules.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Looks good:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
