From: carlo@caione.org (Carlo Caione)
Date: Mon, 30 May 2016 15:51:25 +0200
Subject: [PATCH 1/3] watchdog: Add Meson GXBB Watchdog Driver
In-Reply-To: <1464614948-28247-2-git-send-email-narmstrong@baylibre.com>
References: <1464614948-28247-1-git-send-email-narmstrong@baylibre.com>
 <1464614948-28247-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160530135125.GB16188@mephisto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/16 15:29, Neil Armstrong wrote:
> Add watchdog specific driver for Amlogic Meson GXBB SoC.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> +

> +#define GXBB_WDT_CTRL1_REG			0x4
...
> +#define GXBB_WDT_CTRL_EE_RESET_NOW		BIT(26)
...
> +#define GXBB_WDT_CTRL_IRQ_EN			BIT(23)
...
> +#define GXBB_WDT_CTRL_XTAL_SEL			(0)
...
> +#define GXBB_WDT_CTRL_CLK81_SEL			BIT(19)
...
> +#define GXBB_WDT_CTRL1_GPIO_PULSE		BIT(17)
...
> +#define GXBB_WDT_CTRL1_GPIO_POL_RESET_0		BIT(16)
> +#define GXBB_WDT_CTRL1_GPIO_POL_RESET_1		(0)
> +#define GXBB_WDT_CTRL1_GPIO_PULSE_CNT		(BIT(16) - 1)

nit: all these defines are not used at all in the driver. You can remove them

Thanks!


-- 
Carlo Caione
