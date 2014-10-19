From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 19 Oct 2014 10:47:09 +0800
Subject: [PATCH v4] ARM: ls1021a: add gating clocks to IP blocks.
In-Reply-To: <30c0e84a022340bcae3c8f5086b4e4b4@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1413428973-29982-1-git-send-email-Li.Xiubo@freescale.com>
 <367D14D2-228C-4BC8-9D01-F45EC6C9B005@codeaurora.org>
 <30c0e84a022340bcae3c8f5086b4e4b4@BY2PR0301MB0613.namprd03.prod.outlook.com>
Message-ID: <20141019024708.GI7869@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 17, 2014 at 09:37:24AM +0000, Li.Xiubo at freescale.com wrote:
> > > .../devicetree/bindings/clock/ls1021a-clock.txt    |  27 +++
> > > arch/arm/mach-imx/Makefile                         |   2 +
> > > arch/arm/mach-imx/clk-ls1021a.c                    | 191
> > +++++++++++++++++++++
> > > arch/arm/mach-imx/clk.h                            |   8 +
> > > include/dt-bindings/clock/ls1021a-clock.h          |  55 ++++++
> > 
> > Why is clock support for a new platform in mach-imx instead of drivers/clk ?
> > 
> 
> @Shawn,
> 
> Has any suggestions about move this to drivers/clk/ ?

Oh, yes, if you do not rely on anything that mach-imx clock facilities:
helpers, locking and so on, you should really have it in drivers/clk.

Shawn
