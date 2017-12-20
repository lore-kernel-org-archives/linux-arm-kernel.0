From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 14:12:25 +1030
Subject: [PATCH v6 1/5] clk: Add clock driver for ASPEED BMC SoCs
In-Reply-To: <20171128071908.12279-2-joel@jms.id.au>
References: <20171128071908.12279-1-joel@jms.id.au>
 <20171128071908.12279-2-joel@jms.id.au>
Message-ID: <CACPK8Xcu+jC_Z6OTpq99UpB46zz2YXcUQOPnp+FG9WRTsB9QFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 5:49 PM, Joel Stanley <joel@jms.id.au> wrote:
> This adds the stub of a driver for the ASPEED SoCs. The clocks are
> defined and the static registration is set up.
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v6:
>  - Add SPDX copyright notices
> v5:
>  - Add Andrew's reviewed-by
>  - Make aspeed_gates not initconst to avoid section mismatch warning
> v3:
>  - use named initlisers for aspeed_gates table
>  - fix clocks typo
>  - Move ASPEED_NUM_CLKS to the bottom of the list
>  - Put gates at the start of the list, so we can use them to initalise
>    the aspeed_gates table
>  - Add ASPEED_CLK_SELECTION_2
>  - Set parent of network MAC gates
> ---
>  drivers/clk/Kconfig                      |  12 +++
>  drivers/clk/Makefile                     |   1 +
>  drivers/clk/clk-aspeed.c                 | 139 +++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/aspeed-clock.h |  44 ++++++++++
>  4 files changed, 196 insertions(+)
>  create mode 100644 drivers/clk/clk-aspeed.c
>  create mode 100644 include/dt-bindings/clock/aspeed-clock.h

> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> new file mode 100644
> index 000000000000..9e170fb9a0da
> --- /dev/null
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +
> +#ifndef DT_BINDINGS_ASPEED_CLOCK_H
> +#define DT_BINDINGS_ASPEED_CLOCK_H
> +
> +#define ASPEED_CLK_GATE_ECLK           0
> +#define ASPEED_CLK_GATE_GCLK           1
> +#define ASPEED_CLK_GATE_MCLK           2
> +#define ASPEED_CLK_GATE_VCLK           3
> +#define ASPEED_CLK_GATE_BCLK           4
> +#define ASPEED_CLK_GATE_DCLK           5
> +#define ASPEED_CLK_GATE_REFCLK         6
> +#define ASPEED_CLK_GATE_USBPORT2CLK    7
> +#define ASPEED_CLK_GATE_LCLK           8
> +#define ASPEED_CLK_GATE_USBUHCICLK     9
> +#define ASPEED_CLK_GATE_D1CLK          10
> +#define ASPEED_CLK_GATE_YCLK           11
> +#define ASPEED_CLK_GATE_USBPORT1CLK    12
> +#define ASPEED_CLK_GATE_UART1CLK       13
> +#define ASPEED_CLK_GATE_UART2CLK       14
> +#define ASPEED_CLK_GATE_UART5CLK       15
> +#define ASPEED_CLK_GATE_ESPICLK                16
> +#define ASPEED_CLK_GATE_MAC1CLK                17
> +#define ASPEED_CLK_GATE_MAC2CLK                18
> +#define ASPEED_CLK_GATE_RSACLK         19
> +#define ASPEED_CLK_GATE_UART3CLK       20
> +#define ASPEED_CLK_GATE_UART4CLK       21
> +#define ASPEED_CLK_GATE_SDCLKCLK       22
> +#define ASPEED_CLK_GATE_LHCCLK         23
> +#define ASPEED_CLK_HPLL                        24
> +#define ASPEED_CLK_AHB                 25
> +#define ASPEED_CLK_APB                 26
> +#define ASPEED_CLK_UART                        27
> +#define ASPEED_CLK_SDIO                        28
> +#define ASPEED_CLK_ECLK                        29
> +#define ASPEED_CLK_ECLK_MUX            30
> +#define ASPEED_CLK_LHCLK               31
> +#define ASPEED_CLK_MAC                 32
> +#define ASPEED_CLK_BCLK                        33
> +#define ASPEED_CLK_MPLL                        34
> +
> +#define ASPEED_NUM_CLKS                        35

In reviewing this change as part of some ASPEED device tree changes,
we moved the define out of this header (as we do not want it to be
part of the ABI) and into the c file where it is used.

I have a v7 ready to send out with this change. Are there any other
issues with this before I send that version out?

Cheers,

Joel
