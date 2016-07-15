From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 15 Jul 2016 11:25:18 +0200
Subject: [PATCH 5/7] ARM: dts: at91: at91sam9g25ek: fix isi endpoint node
In-Reply-To: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1468574720-24296-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a reg property in the endpoint node as documented in
Documentation/devicetree/bindings/media/video-interfaces.txt

Solves:
Warning (unit_address_vs_reg): Node /ahb/apb/isi at f8048000/port/endpoint at 0 has a unit name, but no reg property

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g25ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 30bfd2e12cae..91a71774472e 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -56,6 +56,7 @@
 				status = "okay";
 				port {
 					isi_0: endpoint at 0 {
+						reg = <0>;
 						remote-endpoint = <&ov2640_0>;
 						bus-width = <8>;
 						vsync-active = <1>;
-- 
2.8.1
