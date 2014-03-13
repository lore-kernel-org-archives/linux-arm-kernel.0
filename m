From: joelf@ti.com (Joel Fernandes)
Date: Thu, 13 Mar 2014 15:35:16 -0500
Subject: [RFC 2/5] ARM: dts: am33xx: Set parent clock for timer through DT
In-Reply-To: <1394742919-32163-1-git-send-email-joelf@ti.com>
References: <1394742919-32163-1-git-send-email-joelf@ti.com>
Message-ID: <1394742919-32163-3-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4e6c959..51b7008 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -352,6 +352,7 @@
 			interrupts = <67>;
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
+			ti,default-parent = <&sys_clkin_ck>;
 		};
 
 		timer2: timer at 48040000 {
@@ -360,6 +361,7 @@
 			reg = <0x48040000 0x400>;
 			interrupts = <68>;
 			ti,hwmods = "timer2";
+			ti,default-parent = <&sys_clkin_ck>;
 		};
 
 		timer3: timer at 48042000 {
-- 
1.7.9.5
