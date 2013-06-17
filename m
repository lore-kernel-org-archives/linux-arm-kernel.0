From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Jun 2013 17:27:19 +1000
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
Message-ID: <20130617172719.f19a76fae98cc7ef82b91ae9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Today's linux-next merge of the clk tree got a conflict in
drivers/clk/tegra/clk-tegra114.c between commit 31972fd95527 ("clk:
tegra114: implement wait_for_reset and disable_clock for
tegra_cpu_car_ops") from the arm-soc tree and commit d53442e94db0 ("clk:
tegra: override bits for Tegra114 PLLM") from the clk tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clk/tegra/clk-tegra114.c
index 40d939d,7fe36ea..0000000
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@@ -250,9 -251,10 +251,13 @@@
  #define CLK_SOURCE_XUSB_DEV_SRC 0x60c
  #define CLK_SOURCE_EMC 0x19c
  
 +/* Tegra CPU clock and reset control regs */
 +#define CLK_RST_CONTROLLER_CPU_CMPLX_STATUS	0x470
 +
+ /* PLLM override registers */
+ #define PMC_PLLM_WB0_OVERRIDE 0x1dc
+ #define PMC_PLLM_WB0_OVERRIDE_2 0x2b0
+ 
  static int periph_clk_enb_refcnt[CLK_OUT_ENB_NUM * 32];
  
  static void __iomem *clk_base;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/a7703f96/attachment.sig>
