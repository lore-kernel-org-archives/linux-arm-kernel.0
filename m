From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Sun, 20 Jun 2010 21:22:54 +0200
Subject: [PATCH] eukrea_mbimx27: fix audio support when SOC is compiled as
	module
Message-ID: <1277061774-24309-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
index 2e57912..75559aa 100644
--- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
@@ -96,7 +96,8 @@ static int eukrea_mbimx27_pins[] = {
 	PD30_PF_CSPI1_MISO,
 	PD31_PF_CSPI1_MOSI,
 	/* SSI4 */
-#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
+#if defined(CONFIG_SND_SOC_EUKREA_TLV320) \
+	|| defined(CONFIG_SND_SOC_EUKREA_TLV320_MODULE)
 	PC16_PF_SSI4_FS,
 	PC17_PF_SSI4_RXD | GPIO_PUEN,
 	PC18_PF_SSI4_TXD | GPIO_PUEN,
@@ -338,7 +339,8 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	mxc_gpio_setup_multiple_pins(eukrea_mbimx27_pins,
 		ARRAY_SIZE(eukrea_mbimx27_pins), "MBIMX27");
 
-#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
+#if defined(CONFIG_SND_SOC_EUKREA_TLV320) \
+	|| defined(CONFIG_SND_SOC_EUKREA_TLV320_MODULE)
 	/* SSI unit master I2S codec connected to SSI_PINS_4*/
 	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
 			MXC_AUDMUX_V1_PCR_SYN |
-- 
1.6.3.3
