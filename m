From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Tue, 20 May 2014 15:17:30 +0200
Subject: [PATCH v7 2/4] ARM: dts: Fix STi boards compatibles
In-Reply-To: <1400591852-17577-1-git-send-email-maxime.coquelin@st.com>
References: <1400591852-17577-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1400591852-17577-3-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible strings have to be ordered from specific to generic.
This patch fixes this for STi boards, which did the exact opposite.

Cc: Olof Johansson <olof@lixom.net>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih415-b2000.dts | 2 +-
 arch/arm/boot/dts/stih415-b2020.dts | 2 +-
 arch/arm/boot/dts/stih416-b2000.dts | 3 +--
 arch/arm/boot/dts/stih416-b2020.dts | 3 +--
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/stih415-b2000.dts b/arch/arm/boot/dts/stih415-b2000.dts
index d4af531..bdfbd37 100644
--- a/arch/arm/boot/dts/stih415-b2000.dts
+++ b/arch/arm/boot/dts/stih415-b2000.dts
@@ -11,5 +11,5 @@
 #include "stih41x-b2000.dtsi"
 / {
 	model = "STiH415 B2000 Board";
-	compatible = "st,stih415", "st,stih415-b2000";
+	compatible = "st,stih415-b2000", "st,stih415";
 };
diff --git a/arch/arm/boot/dts/stih415-b2020.dts b/arch/arm/boot/dts/stih415-b2020.dts
index 442b019..71903a8 100644
--- a/arch/arm/boot/dts/stih415-b2020.dts
+++ b/arch/arm/boot/dts/stih415-b2020.dts
@@ -11,5 +11,5 @@
 #include "stih41x-b2020.dtsi"
 / {
 	model = "STiH415 B2020 Board";
-	compatible = "st,stih415", "st,stih415-b2020";
+	compatible = "st,stih415-b2020", "st,stih415";
 };
diff --git a/arch/arm/boot/dts/stih416-b2000.dts b/arch/arm/boot/dts/stih416-b2000.dts
index a5eb6ee..488e80a 100644
--- a/arch/arm/boot/dts/stih416-b2000.dts
+++ b/arch/arm/boot/dts/stih416-b2000.dts
@@ -9,8 +9,7 @@
 /dts-v1/;
 #include "stih416.dtsi"
 #include "stih41x-b2000.dtsi"
-
 / {
-	compatible = "st,stih416", "st,stih416-b2000";
 	model = "STiH416 B2000";
+	compatible = "st,stih416-b2000", "st,stih416";
 };
diff --git a/arch/arm/boot/dts/stih416-b2020.dts b/arch/arm/boot/dts/stih416-b2020.dts
index 276f28d..4e2df66 100644
--- a/arch/arm/boot/dts/stih416-b2020.dts
+++ b/arch/arm/boot/dts/stih416-b2020.dts
@@ -11,6 +11,5 @@
 #include "stih41x-b2020.dtsi"
 / {
 	model = "STiH416 B2020";
-	compatible = "st,stih416", "st,stih416-b2020";
-
+	compatible = "st,stih416-b2020", "st,stih416";
 };
-- 
1.9.1
