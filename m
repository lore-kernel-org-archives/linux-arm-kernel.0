From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Apr 2017 14:46:43 +0200
Subject: [PATCH v2 5/7] arm: spear6xx: remove unneeded pinctrl properties in
 spear600-evb
In-Reply-To: <1492433205-13376-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1492433205-13376-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1492433205-13376-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spear6xx doesn't have a pinctrl driver, since the pinmux is globally
defined through a single register, generally configured by the
firmware/bootloader.

Therefore, the pinctrl related properties in spear600-evb.dts are not
necessary.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
