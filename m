From: rabin@rab.in (Rabin Vincent)
Date: Wed, 3 Feb 2010 21:38:36 +0530
Subject: [PATCHv2 05/11] mxc: Core support for i.MX5 series of
	processors from Freescale
In-Reply-To: <f10f79e7313ecdeeb59ab881795baedf2430c636.1265173480.git.amit.kucheria@canonical.com>
References: <cover.1265173480.git.amit.kucheria@canonical.com>
	<f10f79e7313ecdeeb59ab881795baedf2430c636.1265173480.git.amit.kucheria@canonical.com>
Message-ID: <20100203160835.GA1928@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 09:16:27PM -0800, Amit Kucheria wrote:
> diff --git a/arch/arm/mach-mx5/clock.c b/arch/arm/mach-mx5/clock.c
[...]
> +static struct clk_lookup lookups[] __initdata = {
> +	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
> +	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
> +	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
> +	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
> +	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
> +};

This shouldn't be __initdata.  clk_get() uses this, and modules may use
clk_get().

Rabin
