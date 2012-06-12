From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Tue, 12 Jun 2012 10:58:01 +0530
Subject: [PATCH RESEND v4] input: keyboard: Add keys driver for the LPC32xx
 SoC
In-Reply-To: <1339443891-15197-1-git-send-email-stigge@antcom.de>
References: <1339443891-15197-1-git-send-email-stigge@antcom.de>
Message-ID: <4FD6D361.2020305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 June 2012 01:14 AM, Roland Stigge wrote:
> +
> +struct lpc32xx_kscan_drv {
> +	struct input_dev *input;
> +	struct lpc32xx_kscan_cfg *kscancfg;
> +	struct clk *clk;
> +	void __iomem *kscan_base;
> +	int irq;
Do you really need this irq field?  It is used in the probe and remove only.

> +	u8 lastkeystates[8];
> +	u32 io_p_start;
> +	u32 io_p_size;
> +};
