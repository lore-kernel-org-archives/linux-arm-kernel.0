From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:18 +0100
Subject: [PATCH 13/18] ARM: ux500: Apply ab8500-debug node do the db8500 DT
 structure
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node has no properties. It merely allows probing of the
ab8500-debugfs driver during Device Tree initialisation.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index e69c3fa..0dc24e6 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -203,6 +203,10 @@
 				interrupts = <0 40 0x4>;
 				stericsson,irq-base = <520>;
 
+				ab8500-debugfs {
+					compatible = "stericsson,ab8500-debug";
+				};
+
 				ab8500-regulators {
 					compatible = "stericsson,ab8500-regulator";
 
-- 
1.7.9.5
