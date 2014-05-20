From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Tue, 20 May 2014 15:22:55 +0200
Subject: [PATCH v3 11/11] ARM: STi: DT: STiH41x Add clk_ignore_unused to
 bootargs
In-Reply-To: <1400592175-13176-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1400592175-13176-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1400592175-13176-12-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interconnect clocks are not yet managed at the init, then
we have to start the kernel with clk_ignore_unused.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih41x-b2000.dtsi | 2 +-
 arch/arm/boot/dts/stih41x-b2020.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
index bf65c49..a29ced6 100644
--- a/arch/arm/boot/dts/stih41x-b2000.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
@@ -14,7 +14,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyAS0,115200";
+		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
 		linux,stdout-path = &serial2;
 	};
 
diff --git a/arch/arm/boot/dts/stih41x-b2020.dtsi b/arch/arm/boot/dts/stih41x-b2020.dtsi
index 838513f..d8a8429 100644
--- a/arch/arm/boot/dts/stih41x-b2020.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2020.dtsi
@@ -14,7 +14,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyAS0,115200";
+		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
 		linux,stdout-path = &sbc_serial1;
 	};
 
-- 
1.9.1
