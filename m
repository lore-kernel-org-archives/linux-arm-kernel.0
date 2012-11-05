From: anilkumar@ti.com (AnilKumar Ch)
Date: Mon, 5 Nov 2012 15:12:28 +0530
Subject: [PATCH 3/4] ARM: dts: AM33XX: Set pmic-shutdown-controller for
 BeagleBone
In-Reply-To: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
Message-ID: <1352108549-9341-4-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set ti,pmic-shutdown-controller for BeagleBone in am335x-bone.dts
file, this flag is used by the driver to set tps65217 PMIC status
to OFF when PWR_EN toggle.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 91eee97..40ea3c7 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -44,6 +44,8 @@
 /include/ "tps65217.dtsi"
 
 &tps {
+	ti,pmic-shutdown-controller;
+
 	regulators {
 		dcdc1_reg: regulator at 0 {
 			regulator-always-on;
-- 
1.7.9.5
