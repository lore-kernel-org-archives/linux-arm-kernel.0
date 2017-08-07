From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon,  7 Aug 2017 16:13:22 +0800
Subject: [PATCH 4/7] arm64: dts: hikey960: Add optee node
In-Reply-To: <20170807081325.11406-1-guodong.xu@linaro.org>
References: <20170807081325.11406-1-guodong.xu@linaro.org>
Message-ID: <20170807081325.11406-5-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Chong <victor.chong@linaro.org>

This patch adds op-tee node for hikey960

Signed-off-by: Victor Chong <victor.chong@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 6609b0f..b96d865 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -159,6 +159,13 @@
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
 };
 
 &i2c0 {
-- 
2.10.2
