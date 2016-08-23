From: robh@kernel.org (Rob Herring)
Date: Tue, 23 Aug 2016 15:10:44 -0500
Subject: [PATCH 2/4] ARM: dts: exynos: Use 'hpd-gpios' instead of
 'hpd-gpio'
In-Reply-To: <1471943619-6102-3-git-send-email-woogyom.kim@gmail.com>
References: <1471943619-6102-1-git-send-email-woogyom.kim@gmail.com>
 <1471943619-6102-3-git-send-email-woogyom.kim@gmail.com>
Message-ID: <20160823201044.GA1734@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 06:13:37PM +0900, Milo Kim wrote:
> This patch enables getting a HPD GPIO descriptor quickly.
> The exynos-hdmi driver uses "hpd" for HDMI hot plug detection.
> 
> 	static int hdmi_resources_init(struct hdmi_context *hdata)
> 	{
> 		...
> 		hdata->hpd_gpio = devm_gpiod_get(dev, "hpd", GPIOD_IN);
> 		...
> 	}
> 
> This calls 'of_find_gpio()' and it generates the GPIO consumer ID by referring
> GPIO suffix. So 'hpd-gpios' is preferred on getting a GPIO descriptor.
> 
> However, if the device tree uses 'hpd-gpio', then the exynos-hdmi driver
> always retries to get a GPIO descriptor because the first GPIO suffix is not
> 'gpio' but 'gpios'. So you always see the debug message below.
> 
> 	of_get_named_gpiod_flags: can't parse 'hpd-gpios' property of node '/soc/hdmi at 14530000[0]'
> 
> Use the preferred property, 'hpd-gpios' instead of 'hpd-gpio'.
> 
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: dri-devel at lists.freedesktop.org
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt | 4 ++--
>  arch/arm/boot/dts/exynos4210-universal_c210.dts                  | 2 +-
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi                  | 2 +-
>  arch/arm/boot/dts/exynos5250-arndale.dts                         | 2 +-
>  arch/arm/boot/dts/exynos5250-smdk5250.dts                        | 2 +-
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi                    | 2 +-
>  arch/arm/boot/dts/exynos5250-spring.dts                          | 2 +-
>  arch/arm/boot/dts/exynos5420-peach-pit.dts                       | 2 +-
>  arch/arm/boot/dts/exynos5420-smdk5420.dts                        | 2 +-
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi               | 2 +-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts                        | 2 +-
>  11 files changed, 12 insertions(+), 12 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
