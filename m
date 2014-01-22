From: yao.yuan@freescale.com (Yuan Yao)
Date: Wed, 22 Jan 2014 12:09:31 +0800
Subject: [PATCH v4 1/3] ARM: dts: vf610: lpuart: Add eDMA support
In-Reply-To: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1390363773-24108-2-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add lpuart dts node properties for eDMA support, them depend on the eDMA driver.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 80db14e..4149ed6 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -101,5 +101,8 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	dmas = <&edma0 0 4>,
+		<&edma0 0 5>;
+	dma-names = "rx","tx";
 	status = "okay";
 };
-- 
1.8.4
