From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 30 Jan 2014 11:19:19 +1100
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20140130111919.afc7f4e5b58e409aaabf7550@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/clk/Makefile between commit fd3fdaf09f26 ("clk: sort Makefile")
from Linus' tree and commit 7ee2c5117483 ("clk: bcm281xx: add initial
clock framework support") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clk/Makefile
index a367a9831717,7c7f40e9ba05..000000000000
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@@ -9,44 -9,44 +9,45 @@@ obj-$(CONFIG_COMMON_CLK)	+= clk-gate.
  obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
  obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
  
 -# SoCs specific
 -obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
 -obj-$(CONFIG_ARCH_EFM32)	+= clk-efm32gg.o
 -obj-$(CONFIG_ARCH_NOMADIK)	+= clk-nomadik.o
 -obj-$(CONFIG_ARCH_HIGHBANK)	+= clk-highbank.o
 -obj-$(CONFIG_ARCH_HI3xxx)	+= hisilicon/
 -obj-$(CONFIG_ARCH_NSPIRE)	+= clk-nspire.o
 -obj-$(CONFIG_ARCH_MXS)		+= mxs/
 -obj-$(CONFIG_ARCH_SOCFPGA)	+= socfpga/
 -obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 -obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
 -obj-$(CONFIG_COMMON_CLK_VERSATILE) += versatile/
 -obj-$(CONFIG_ARCH_SIRF)		+= clk-prima2.o
 -obj-$(CONFIG_PLAT_ORION)	+= mvebu/
 +# hardware specific clock types
 +# please keep this section sorted lexicographically by file/directory path name
++obj-$(CONFIG_ARCH_BCM)			+= bcm/
 +obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 +obj-$(CONFIG_ARCH_BCM2835)		+= clk-bcm2835.o
 +obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
 +obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
 +obj-$(CONFIG_MACH_LOONGSON1)		+= clk-ls1x.o
 +obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 +obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 +obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 +obj-$(CONFIG_CLK_PPC_CORENET)		+= clk-ppc-corenet.o
 +obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
 +obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
 +obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
 +obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
 +obj-$(CONFIG_ARCH_U300)			+= clk-u300.o
 +obj-$(CONFIG_ARCH_VT8500)		+= clk-vt8500.o
 +obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
 +obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
 +obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
 +obj-$(CONFIG_ARCH_HI3xxx)		+= hisilicon/
 +obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
  ifeq ($(CONFIG_COMMON_CLK), y)
 -obj-$(CONFIG_ARCH_MMP)		+= mmp/
 +obj-$(CONFIG_ARCH_MMP)			+= mmp/
  endif
 -obj-$(CONFIG_MACH_LOONGSON1)	+= clk-ls1x.o
 -obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 -obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 -obj-$(CONFIG_ARCH_U8500)	+= ux500/
 -obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
 -obj-$(CONFIG_ARCH_ZYNQ)		+= zynq/
 -obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 -obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
 -obj-$(CONFIG_COMMON_CLK_XGENE)  += clk-xgene.o
 -obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
 -obj-$(CONFIG_COMMON_CLK_AT91)	+= at91/
 +obj-$(CONFIG_PLAT_ORION)		+= mvebu/
 +obj-$(CONFIG_ARCH_MXS)			+= mxs/
 +obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 +obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 +obj-$(CONFIG_PLAT_SAMSUNG)		+= samsung/
  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= shmobile/
 -
 -obj-$(CONFIG_X86)		+= x86/
 -obj-$(CONFIG_ARCH_BCM)		+= bcm/
 -
 -# Chip specific
 -obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN) += clk-axi-clkgen.o
 -obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
 -obj-$(CONFIG_COMMON_CLK_MAX77686) += clk-max77686.o
 -obj-$(CONFIG_COMMON_CLK_SI5351) += clk-si5351.o
 -obj-$(CONFIG_COMMON_CLK_S2MPS11) += clk-s2mps11.o
 -obj-$(CONFIG_CLK_TWL6040)	+= clk-twl6040.o
 -obj-$(CONFIG_CLK_PPC_CORENET)	+= clk-ppc-corenet.o
 +obj-$(CONFIG_ARCH_SIRF)			+= sirf/
 +obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
 +obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 +obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
 +obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 +obj-$(CONFIG_ARCH_OMAP2PLUS)		+= ti/
 +obj-$(CONFIG_ARCH_U8500)		+= ux500/
 +obj-$(CONFIG_COMMON_CLK_VERSATILE)	+= versatile/
 +obj-$(CONFIG_X86)			+= x86/
 +obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140130/7fbd45c9/attachment.sig>
