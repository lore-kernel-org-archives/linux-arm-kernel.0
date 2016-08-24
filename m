From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 24 Aug 2016 21:13:00 +0200
Subject: [PATCH v3 2/5] ARM: dts: exynos: Use 'hpd-gpios' instead of
 'hpd-gpio'
In-Reply-To: <1472044039-16536-3-git-send-email-woogyom.kim@gmail.com>
References: <1472044039-16536-1-git-send-email-woogyom.kim@gmail.com>
 <1472044039-16536-3-git-send-email-woogyom.kim@gmail.com>
Message-ID: <20160824191300.GA31869@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 10:07:16PM +0900, Milo Kim wrote:
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

Thanks for fixing this, applied!

BR,
Krzysztof
