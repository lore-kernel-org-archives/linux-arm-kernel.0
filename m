From: nikolas@gnu.org (Nik Nyby)
Date: Tue, 30 Jun 2015 18:56:29 -0400
Subject: [PATCH] ARM: tegra: fix typo in address end
Message-ID: <1435704989-23831-1-git-send-email-nikolas@gnu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a misspelling of "address" as "adress".

Signed-off-by: Nik Nyby <nikolas@gnu.org>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 9a2f0b0..3191929 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -559,7 +559,7 @@ tegra114_sdram_pad_address:
 	.word	TEGRA_EMC1_BASE + EMC_AUTO_CAL_INTERVAL			@0x28
 	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL			@0x2c
 	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL2			@0x30
-tegra114_sdram_pad_adress_end:
+tegra114_sdram_pad_address_end:
 
 tegra124_sdram_pad_address:
 	.word	TEGRA124_EMC_BASE + EMC_CFG				@0x0
@@ -576,11 +576,11 @@ tegra30_sdram_pad_size:
 	.word	tegra30_sdram_pad_address_end - tegra30_sdram_pad_address
 
 tegra114_sdram_pad_size:
-	.word	tegra114_sdram_pad_adress_end - tegra114_sdram_pad_address
+	.word	tegra114_sdram_pad_address_end - tegra114_sdram_pad_address
 
 	.type	tegra_sdram_pad_save, %object
 tegra_sdram_pad_save:
-	.rept (tegra114_sdram_pad_adress_end - tegra114_sdram_pad_address) / 4
+	.rept (tegra114_sdram_pad_address_end - tegra114_sdram_pad_address) / 4
 	.long	0
 	.endr
 
-- 
2.1.4
