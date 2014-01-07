From: fkan@apm.com (Feng Kan)
Date: Tue,  7 Jan 2014 14:50:37 -0800
Subject: [PATCH V2 2/6] arm64: add missing dts entry for X-Gene platform.
In-Reply-To: <1389135041-16062-1-git-send-email-fkan@apm.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
Message-ID: <1389135041-16062-3-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing dts entry for the X-Gene reboot driver.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index d37d736..78d29781 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -187,5 +187,10 @@
 			interrupt-parent = <&gic>;
 			interrupts = <0x0 0x4c 0x4>;
 		};
+
+		reboot at 17000014 {
+			compatible = "apm,xgene-reboot";
+			reg = <0x0 0x17000014 0x0 0x4>;
+		};
 	};
 };
-- 
1.7.6.1
