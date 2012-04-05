From: joancarles@fqingenieria.es (joancarles)
Date: Thu, 05 Apr 2012 15:43:17 +0200
Subject: [PATCH] mx25: fix typo in memory size selector for keypad driver
Message-ID: <8f943264186703f0190c91f8b78b5a63@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While adding support for the keypad platform driver on a custom device, 
I have found a small inconsistency in the memory region setup for the 
keypad driver for MX25 based devices. Attached is a patch to address 
this typo. Please review
and stage for mainline inclusion in the next round of mx25 fixes.

Signed-off-by: Joan Carles <joancarles@fqingenieria.es>
Signed-off-by: Roberto Nibali <rnibali@gmail.com>
---
  arch/arm/plat-mxc/devices/platform-imx-keypad.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-keypad.c 
b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
index 479c3e9..4645f21 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-keypad.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
@@ -23,7 +23,7 @@ const struct imx_imx_keypad_data 
imx21_imx_keypad_data __initconst =

  #ifdef CONFIG_SOC_IMX25
  const struct imx_imx_keypad_data imx25_imx_keypad_data __initconst =
-	imx_imx_keypad_data_entry_single(MX25, SZ_16K);
+	imx_imx_keypad_data_entry_single(MX25, SZ_16);
  #endif /* ifdef CONFIG_SOC_IMX25 */

  #ifdef CONFIG_SOC_IMX27
-- 
1.7.4.1

-- 
Joan C. Abelaira
