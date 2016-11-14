From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 Nov 2016 15:44:10 +0000
Subject: [PATCH] ARM: dts: sun8i: replace enable-sdio-wakeup with
 wakeup-source for BananaPi M1+
Message-ID: <1479138250-17780-4-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the mmc core driver will continue to support the legacy
"enable-sdio-wakeup" property to enable SDIO as the wakeup source,
"wakeup-source" is the new standard binding.

This patch replaces the legacy "enable-sdio-wakeup" with the unified
"wakeup-source" property in order to avoid any further copy-paste
duplication.

Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

Inspite of getting rid of most of the legacy property almost a year ago,
addition of new platforms have brought this back and over time it's
now found again in few places. Just get rid of them *again*

Regards,
Sudeep

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index ba5bca0fe997..1df47aa0a07b 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -167,7 +167,7 @@
 	mmc-pwrseq = <&mmc3_pwrseq>;
 	bus-width = <4>;
 	non-removable;
-	enable-sdio-wakeup;
+	wakeup-source;
 	status = "okay";

 	brcmf: bcrmf at 1 {
--
2.7.4
