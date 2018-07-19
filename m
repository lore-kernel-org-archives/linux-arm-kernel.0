From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 19 Jul 2018 12:30:30 +0200
Subject: [PATCH v10 10/10] drivers: clk: Add ZynqMP clock driver
In-Reply-To: <1531857547-16652-11-git-send-email-jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
 <1531857547-16652-11-git-send-email-jollys@xilinx.com>
Message-ID: <6dadc5a6-7bc1-0e37-4df6-0278d9046c96@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen and Mike,

On 17.7.2018 21:59, Jolly Shah wrote:
> From: Jolly Shah <jolly.shah@xilinx.com>
> 
> This patch adds CCF compliant clock driver for ZynqMP.
> Clock driver queries supported clock information from
> firmware and regiters pll and output clocks with CCF.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Tejas Patel <tejasp@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/clk/Kconfig                  |   1 +
>  drivers/clk/Makefile                 |   1 +
>  drivers/clk/zynqmp/Kconfig           |  10 +
>  drivers/clk/zynqmp/Makefile          |   4 +
>  drivers/clk/zynqmp/clk-gate-zynqmp.c | 144 +++++++
>  drivers/clk/zynqmp/clk-mux-zynqmp.c  | 141 +++++++
>  drivers/clk/zynqmp/clk-zynqmp.h      |  68 ++++
>  drivers/clk/zynqmp/clkc.c            | 719 +++++++++++++++++++++++++++++++++++
>  drivers/clk/zynqmp/divider.c         | 217 +++++++++++
>  drivers/clk/zynqmp/pll.c             | 335 ++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |   1 +
>  11 files changed, 1641 insertions(+)
>  create mode 100644 drivers/clk/zynqmp/Kconfig
>  create mode 100644 drivers/clk/zynqmp/Makefile
>  create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
>  create mode 100644 drivers/clk/zynqmp/clkc.c
>  create mode 100644 drivers/clk/zynqmp/divider.c
>  create mode 100644 drivers/clk/zynqmp/pll.c

DT binding was reviewed by Stephen but I can't see any review for the
driver itself. Should I wait for your review or do you want to take
binding doc 09/10 and 10/10 separately or this can go via arm-soc tree?

Thanks,
Michal
