From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jun 2012 09:16:58 +0100
Subject: [PATCH 7/7] ARM: nomadik: register the MMC/SD device
In-Reply-To: <1339018526-29223-1-git-send-email-linus.walleij@linaro.org>
References: <1339018526-29223-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120607081658.GP8262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2012 at 11:35:26PM +0200, Linus Walleij wrote:
> +static int __init nhk8815_mmcsd_init(void)
> +{
> +	int ret;
> +
> +	ret = gpio_request(112, "card detect bias");
> +	if (ret)
> +		return ret;
> +	gpio_direction_output(112, 0);
> +	amba_ahb_device_add(NULL, "mmci", NOMADIK_SDI_BASE, SZ_4K, IRQ_SDMMC, 0, &mmcsd_plat_data, 0x10180180);

MMCI is not an AHB device.  It's definitely APB.
