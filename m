From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 6 Dec 2011 15:39:09 +0800
Subject: [RFC PATCH 1/3] pinctrl: imx: add pinmux imx core driver
In-Reply-To: <1322999384-7886-1-git-send-email-b29396@freescale.com>
References: <1322999384-7886-1-git-send-email-b29396@freescale.com>
Message-ID: <20111206073908.GC3712@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 04, 2011 at 07:49:42PM +0800, Dong Aisheng wrote:
> +static struct platform_device_id imx_pinctrl_devtype[] = {
> +	{
> +		.name = "sdhci-pinctrl-imx53",
> +		.driver_data = (kernel_ulong_t)&mx53_pinctrl_info,
> +	}, {
> +		.name = "sdhci-pinctrl-imx6q",
> +		.driver_data = (kernel_ulong_t)&mx6q_pinctrl_info,
> +	},
> +};

The platform_device_id table needs an empty entry to be the sentinel.

-- 
Regards,
Shawn
