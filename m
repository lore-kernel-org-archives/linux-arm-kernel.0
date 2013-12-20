From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Fri, 20 Dec 2013 21:34:37 +0900
Subject: [PATCH] ARM: dts: add clock provider for mshc node for Exynos4412 SOC
In-Reply-To: <1358764755-21470-1-git-send-email-thomas.abraham@linaro.org>
References: <1358764755-21470-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <000201cefd7f$d8b7c840$8a2758c0$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock lookup information is required as driver can manipulate
clock rate properly.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 arch/arm/boot/dts/exynos4412.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index ec1b166..9cbe59a 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -41,5 +41,7 @@
 		interrupts = <0 77 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 301>, <&clock 149>;
+		clock-name = "biu", "ciu";
 	};
 };
-- 
1.7.0.4
