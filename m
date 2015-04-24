From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Apr 2015 16:32:25 +0800
Subject: [PATCH 1/1] arm: imx: move clk common part to driver/clk/imx
In-Reply-To: <1429735784-32492-1-git-send-email-Frank.Li@freescale.com>
References: <1429735784-32492-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150424083224.GB25323@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 04:49:44AM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> move clock common part to driver/clk/imx
> except clk-pllv1.c because it use cpu_is_xxx()
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/mach-imx/Makefile                         |   5 +-
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/imx/Makefile                           |   4 +
>  {arch/arm/mach-imx => drivers/clk/imx}/clk-busy.c  |   0
>  .../mach-imx => drivers/clk/imx}/clk-fixup-div.c   |   0
>  .../mach-imx => drivers/clk/imx}/clk-fixup-mux.c   |   0
>  .../clk/imx}/clk-gate-exclusive.c                  |   0
>  {arch/arm/mach-imx => drivers/clk/imx}/clk-gate2.c |   0
>  {arch/arm/mach-imx => drivers/clk/imx}/clk-pfd.c   |   0
>  {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv2.c |   0
>  {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv3.c |   0
>  {arch/arm/mach-imx => drivers/clk/imx}/clk.c       |   0
>  drivers/clk/imx/clk.h                              | 139 +++++++++++++++++++++
>  13 files changed, 145 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/clk/imx/Makefile
>  rename {arch/arm/mach-imx => drivers/clk/imx}/clk-busy.c (100%)
>  rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-div.c (100%)
>  rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-mux.c (100%)
>  rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate-exclusive.c (100%)
>  rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate2.c (100%)
>  rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pfd.c (100%)
>  rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv2.c (100%)
>  rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv3.c (100%)
>  rename {arch/arm/mach-imx => drivers/clk/imx}/clk.c (100%)
>  create mode 100644 drivers/clk/imx/clk.h

It's not nice to duplicate clk.h.  Let's move all i.MX clock driver
together.  I will try to cook up a series to do that over the weekend.

Shawn
