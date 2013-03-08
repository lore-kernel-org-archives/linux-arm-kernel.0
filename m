From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 8 Mar 2013 12:13:17 +0100
Subject: [PATCH] ARM: Dove: add RTC device node
Message-ID: <20130308121317.4ee83c0a@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 48be9ac930086f removed the RTC initialization.
This patch re-enables the RTC via the DT.

Signed-off-by: Jean-Fran?ois Moine <moinejf@free.fr>
---
 arch/arm/boot/dts/dove.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 46afade..28ff4dc 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -197,6 +197,11 @@
 			status = "disabled";
 		};
 
+		rtc at d8500 {
+			compatible = "marvell,orion-rtc";
+			reg = <0xd8500 0x20>;
+		};
+
 		crypto: crypto at 30000 {
 			compatible = "marvell,orion-crypto";
 			reg = <0x30000 0x10000>,


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
