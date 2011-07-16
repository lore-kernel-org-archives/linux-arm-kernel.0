From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 16 Jul 2011 02:05:40 -0600 (MDT)
Subject: [PATCH 2/4] TI816X: clock: Add clock data
In-Reply-To: <1301070006-8363-1-git-send-email-hemantp@ti.com>
References: <1301070006-8363-1-git-send-email-hemantp@ti.com>
Message-ID: <alpine.DEB.2.00.1107160201410.25013@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Spot-checking this...

On Fri, 25 Mar 2011, Hemant Pedanekar wrote:

> +static struct clk uart1_fck = {
> +	.name		= "uart1_fck",
> +	.parent		= &sysclk10_ck,
> +	.ops		= &clkops_omap2_dflt,
> +	.enable_reg	= TI816X_CM_ALWON_UART_0_CLKCTRL,
> +	.enable_bit	= TI816X_MODULEMODE_SWCTRL,
> +	.clkdm_name	= "alwon_l3_slow_clkdm",
> +	.recalc		= &followparent_recalc,
> +};

Is this really in the alwon_l3_slow_clkdm clockdomain?  Looking at SPRS680 
section 5.2 "L4 Interconnect", these UARTs seem to be in some L4 
clockdomain?


- Paul
