From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 13 Jan 2015 15:43:00 +0100
Subject: [PATCH] ARM: dts: re-fromat AT91 part to match other entries
In-Reply-To: <20150112224203.GL22090@quad.lixom.net>
References: <20150112224203.GL22090@quad.lixom.net>
Message-ID: <1421160180-23452-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The entries are separated as ARM V4/V5 and ARM V7 as some other per-SoC config
options may be removed in the near future.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi Olof,

This is an attempt to match other ARM SoC families format.
If you feel that the patch can be good, do not hesitate to take it yourself. I
don't plan to integrate it in any of my pull-request so it can appear quickly in
arm-soc and can be used by everyone.

 arch/arm/boot/dts/Makefile | 90 +++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 50 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7be7a6f62d81..66ea13037dbc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1,56 +1,46 @@
 ifeq ($(CONFIG_OF),y)
 
 # Keep at91 dtb files sorted alphabetically for each SoC
-# rm9200
-dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += mpa1600.dtb
-# sam9260
-dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91-qil_a9260.dtb
-dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb
-dtb-$(CONFIG_ARCH_AT91) += ethernut5.dtb
-dtb-$(CONFIG_ARCH_AT91) += evk-pro3.dtb
-dtb-$(CONFIG_ARCH_AT91) += tny_a9260.dtb
-dtb-$(CONFIG_ARCH_AT91) += usb_a9260.dtb
-# sam9261
-dtb-$(CONFIG_ARCH_AT91) += at91sam9261ek.dtb
-# sam9263
-dtb-$(CONFIG_ARCH_AT91) += at91sam9263ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += tny_a9263.dtb
-dtb-$(CONFIG_ARCH_AT91) += usb_a9263.dtb
-# sam9g20
-dtb-$(CONFIG_ARCH_AT91) += at91-foxg20.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek_2mmc.dtb
-dtb-$(CONFIG_ARCH_AT91) += kizbox.dtb
-dtb-$(CONFIG_ARCH_AT91) += tny_a9g20.dtb
-dtb-$(CONFIG_ARCH_AT91) += usb_a9g20.dtb
-dtb-$(CONFIG_ARCH_AT91) += usb_a9g20_lpw.dtb
-# sam9g45
-dtb-$(CONFIG_ARCH_AT91) += at91sam9m10g45ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += pm9g45.dtb
-# sam9n12
-dtb-$(CONFIG_ARCH_AT91) += at91sam9n12ek.dtb
-# sam9rl
-dtb-$(CONFIG_ARCH_AT91) += at91sam9rlek.dtb
-# sam9x5
-dtb-$(CONFIG_ARCH_AT91) += at91-ariag25.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91-cosino_mega2560.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g15ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g25ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g35ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9x25ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9x35ek.dtb
-# sama5d3
-dtb-$(CONFIG_ARCH_AT91)	+= at91-sama5d3_xplained.dtb
-dtb-$(CONFIG_ARCH_AT91)	+= sama5d31ek.dtb
-dtb-$(CONFIG_ARCH_AT91)	+= sama5d33ek.dtb
-dtb-$(CONFIG_ARCH_AT91)	+= sama5d34ek.dtb
-dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
-dtb-$(CONFIG_ARCH_AT91)	+= sama5d36ek.dtb
-# sama5d4
-dtb-$(CONFIG_ARCH_AT91)	+= at91-sama5d4ek.dtb
-
+dtb-$(CONFIG_SOC_SAM_V4_V5) += \
+	at91rm9200ek.dtb \
+	mpa1600.dtb \
+	animeo_ip.dtb \
+	at91-qil_a9260.dtb \
+	aks-cdu.dtb \
+	ethernut5.dtb \
+	evk-pro3.dtb \
+	tny_a9260.dtb \
+	usb_a9260.dtb \
+	at91sam9261ek.dtb \
+	at91sam9263ek.dtb \
+	tny_a9263.dtb \
+	usb_a9263.dtb \
+	at91-foxg20.dtb \
+	at91sam9g20ek.dtb \
+	at91sam9g20ek_2mmc.dtb \
+	kizbox.dtb \
+	tny_a9g20.dtb \
+	usb_a9g20.dtb \
+	usb_a9g20_lpw.dtb \
+	at91sam9m10g45ek.dtb \
+	pm9g45.dtb \
+	at91sam9n12ek.dtb \
+	at91sam9rlek.dtb \
+	at91-ariag25.dtb \
+	at91-cosino_mega2560.dtb \
+	at91sam9g15ek.dtb \
+	at91sam9g25ek.dtb \
+	at91sam9g35ek.dtb \
+	at91sam9x25ek.dtb \
+	at91sam9x35ek.dtb
+dtb-$(CONFIG_SOC_SAM_V7) += \
+	at91-sama5d3_xplained.dtb \
+	sama5d31ek.dtb \
+	sama5d33ek.dtb \
+	sama5d34ek.dtb \
+	sama5d35ek.dtb \
+	sama5d36ek.dtb \
+	at91-sama5d4ek.dtb
 dtb-$(CONFIG_ARCH_ATLAS6) += \
 	atlas6-evb.dtb
 dtb-$(CONFIG_ARCH_AXXIA) += \
-- 
2.1.3
