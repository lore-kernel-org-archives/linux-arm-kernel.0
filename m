From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Apr 2013 19:50:09 +0800
Subject: [PATCH V2] ARM: mx5: Add support for DENX M53EVK
In-Reply-To: <1366665827-8949-1-git-send-email-marex@denx.de>
References: <1366665827-8949-1-git-send-email-marex@denx.de>
Message-ID: <20130423115007.GD27475@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 11:23:47PM +0200, Marek Vasut wrote:
> This patch adds support for the DENX M53EVK board. The board currently supports
> NAND, Ethernet, UART, CAN, I2C.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile         |    1 +
>  arch/arm/boot/dts/imx53-m53evk.dts |  259 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 260 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx53-m53evk.dts
> 
> V2: - Rebase on top of Shawn's patch:
>       "[PATCH] ARM: imx: move imx53-qsb audio codec clk lookup into DT"
>     - Use BGR666 format on LCD, this makes it depend on:
>       "[PATCH V2] video: imx: Add BGR666 support for parallel display"

Does it hurt if I just go ahead to apply the patch?  Or do I have to
wait for above patch goes in?

Shawn

>     - Remove the first LCD as it's not populated
>     - Reorder the DT nodes in alphabetical order
>     - Configure PWM pinmux properly
>     - Pass IRQ GPIO to STMPE-TS driver using "interrupt" and
>       "interrupt-parent" DT properties
