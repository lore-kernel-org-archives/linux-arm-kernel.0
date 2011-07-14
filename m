From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 14 Jul 2011 13:25:20 +0100
Subject: [PATCH 1/2] ARM: Tegra: Harmony: Register and configure WM8903
	IRQ GPIO
In-Reply-To: <1310589618-16080-1-git-send-email-swarren@nvidia.com>
References: <1310589618-16080-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110714122520.GB14249@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 02:40:17PM -0600, Stephen Warren wrote:

> +	gpio_request(TEGRA_GPIO_CDC_IRQ, "wm8903");
> +	gpio_direction_input(TEGRA_GPIO_CDC_IRQ);
> +
>  	i2c_register_board_info(0, &wm8903_board_info, 1);

This seems silly - we should fix this in the core code rather than have
every single board that ahppens to use an interrupt which is also
available as a GPIO manually faff around with gpiolib.
