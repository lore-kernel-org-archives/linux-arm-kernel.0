From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Mar 2017 11:51:52 +0100
Subject: [PATCH v2 5/5] arm: spear6xx: remove unneeded pinctrl properties in
 spear600-evb
In-Reply-To: <1490093512-32665-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1490093512-32665-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1490093512-32665-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spear6xx doesn't have a pinctrl driver, since the pinmux is globally
defined through a single register, generally configured by the
firmware/bootloader.

Therefore, the pinctrl related properties in spear600-evb.dts are not
necessary.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/spear600-evb.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/spear600-evb.dts b/arch/arm/boot/dts/spear600-evb.dts
index f36603f..c67e76c 100644
--- a/arch/arm/boot/dts/spear600-evb.dts
+++ b/arch/arm/boot/dts/spear600-evb.dts
@@ -96,14 +96,10 @@
 
 &uart0 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <>;
 };
 
 &uart1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <>;
 };
 
 &rtc {
-- 
2.7.4
