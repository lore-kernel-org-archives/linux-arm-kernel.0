From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 16 Oct 2014 16:29:17 +0200
Subject: [PATCH v4] ARM: ls1021a: add gating clocks to IP blocks.
In-Reply-To: <1413428973-29982-1-git-send-email-Li.Xiubo@freescale.com>
References: <1413428973-29982-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <367D14D2-228C-4BC8-9D01-F45EC6C9B005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 16, 2014, at 5:09 AM, Xiubo Li <Li.Xiubo@freescale.com> wrote:

> A given application may not use all the peripherals on the device.
> In this case, it may be desirable to disable unused peripherals.
> DCFG provides a mechanism for gating clocks to IP blocks that are
> not used when running an application.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
> 
> Change in V4:
> - Convert all the bits BE as default.
> - Follow some tips from Shawn to be the same with other clk drivers of fsl.
> 
> 
> 
> .../devicetree/bindings/clock/ls1021a-clock.txt    |  27 +++
> arch/arm/mach-imx/Makefile                         |   2 +
> arch/arm/mach-imx/clk-ls1021a.c                    | 191 +++++++++++++++++++++
> arch/arm/mach-imx/clk.h                            |   8 +
> include/dt-bindings/clock/ls1021a-clock.h          |  55 ++++++

Why is clock support for a new platform in mach-imx instead of drivers/clk ?

> 5 files changed, 283 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/clock/ls1021a-clock.txt
> create mode 100644 arch/arm/mach-imx/clk-ls1021a.c
> create mode 100644 include/dt-bindings/clock/ls1021a-clock.h

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
