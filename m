From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 24 Aug 2016 07:30:33 +0200
Subject: [PATCH v2 2/4] ARM: dts: exynos: Use 'hpd-gpios' instead of
 'hpd-gpio'
In-Reply-To: <1472005524-3489-3-git-send-email-woogyom.kim@gmail.com>
References: <1472005524-3489-1-git-send-email-woogyom.kim@gmail.com>
 <1472005524-3489-3-git-send-email-woogyom.kim@gmail.com>
Message-ID: <58f9145c-9c01-33a8-f5cb-82955fa0e79c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2016 04:25 AM, Milo Kim wrote:
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
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: dri-devel at lists.freedesktop.org
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
I am not sure if this long Cc list is necessary.
Anyway:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
--
Regards
Andrzej
