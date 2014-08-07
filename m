From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu,  7 Aug 2014 18:51:30 +0800
Subject: [PATCH v17 4/9] document: dt: add the binding on HiP04
In-Reply-To: <1407408695-19626-1-git-send-email-haojian.zhuang@linaro.org>
References: <1407408695-19626-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1407408695-19626-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Hisilicon HiP04 SoC platform & Fabric controller.

Fabric controller could be used to configure snoop filter among multiple
clusters.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 .../bindings/arm/hisilicon/hisilicon.txt           | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 934f000..f717c7b 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -5,6 +5,11 @@ Hi4511 Board
 Required root node properties:
 	- compatible = "hisilicon,hi3620-hi4511";
 
+HiP04 D01 Board
+Required root node properties:
+	- compatible = "hisilicon,hip04-d01";
+
+
 Hisilicon system controller
 
 Required properties:
@@ -55,3 +60,21 @@ Example:
 		compatible = "hisilicon,pctrl";
 		reg = <0xfca09000 0x1000>;
 	};
+
+-----------------------------------------------------------------------
+Fabric:
+
+Required Properties:
+- compatible: "hisilicon,hip04-fabric";
+- reg: Address and size of Fabric
+
+-----------------------------------------------------------------------
+Bootwrapper boot method (software protocol on SMP):
+
+Required Properties:
+- compatible: "hisilicon,hip04-bootwrapper";
+- boot-method: Address and size of boot method.
+  [0]: bootwrapper physical address
+  [1]: bootwrapper size
+  [2]: relocation physical address
+  [3]: relocation size
-- 
1.9.1
