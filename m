From: balbi@ti.com (Felipe Balbi)
Date: Thu, 31 Mar 2011 17:26:36 +0300
Subject: [PATCHv2] omap: rx51: Platform support for lp5523 led chip
In-Reply-To: <1301578692-29286-1-git-send-email-ameya.palande@nokia.com>
References: <alpine.DEB.1.10.1103311524420.2634@esdhcp041196.research.nokia.com>
	<1301578692-29286-1-git-send-email-ameya.palande@nokia.com>
Message-ID: <20110331142635.GF5465@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 31, 2011 at 04:38:12PM +0300, Ameya Palande wrote:
> +static int rx51_lp5523_setup(void)
> +{
> +	int err;
> +
> +	err = gpio_request_one(RX51_LP5523_CHIP_EN_GPIO, GPIOF_DIR_OUT,
> +			"lp5523_enable");
> +	if (err < 0) {
> +		pr_err("Unable to get lp5523_enable GPIO\n");
> +		return err;
> +	}
> +
> +	return err;

isn't enough to return gpio_request_one(RX51_LP5523_CHIP_EN_GPIO,
GPIOF_DIR_OUT, "lp5523_enable"); ??

-- 
balbi
