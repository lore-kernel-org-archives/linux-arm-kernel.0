From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 10 Jul 2014 10:04:04 +0800
Subject: [PATCH v10 05/11] document: dt: add the binding on HiP04
In-Reply-To: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1404957850-13340-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bootwrapper-phys, bootwrapper-size, bootwrapper-magic properties for
Hisilicon HiP04 SoC.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 .../devicetree/bindings/arm/hisilicon/hisilicon.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index df0a452..5024992 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -4,6 +4,10 @@ Hisilicon Platforms Device Tree Bindings
 Hi4511 Board
 Required root node properties:
 	- compatible = "hisilicon,hi3620-hi4511";
+HiP04 D01 Board
+Required root node properties:
+	- compatible = "hisilicon,hip04-d01";
+
 
 Hisilicon system controller
 
@@ -19,6 +23,15 @@ Optional properties:
 		If reg value is not zero, cpun exit wfi and go
 - resume-offset : offset in sysctrl for notifying cpu0 when resume
 - reboot-offset : offset in sysctrl for system reboot
+- relocation-entry : relocation address of secondary cpu boot code
+- relocation-size : relocation size of secondary cpu boot code
+- bootwrapper-phys : physical address of boot wrapper
+- bootwrapper-size : size of boot wrapper
+- bootwrapper-magic : magic number for secondary cpu in boot wrapper
+The memory area of [bootwrapper-phys : bootwrapper-phys+bootwrapper-size]
+should be reserved. This should be set in /memreserve/ node in DTS file.
+bootwrapper-phys, bootwrapper-size, bootwrapper-magic is used in HiP04
+DTS file.
 
 Example:
 
@@ -31,6 +44,7 @@ Example:
 		reboot-offset = <0x4>;
 	};
 
+
 PCTRL: Peripheral misc control register
 
 Required Properties:
@@ -44,3 +58,10 @@ Example:
 		compatible = "hisilicon,pctrl";
 		reg = <0xfca09000 0x1000>;
 	};
+
+
+Fabric:
+
+Required Properties:
+- compatible: "hisilicon,hip04-fabric";
+- reg: Address and size of Fabric
-- 
1.9.1
