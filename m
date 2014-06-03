From: lho@apm.com (Loc Ho)
Date: Tue,  3 Jun 2014 15:13:05 -0600
Subject: [PATCH v2 3/3] arm64: Add APM X-Gene SoC SDHC controller DTS entry
In-Reply-To: <1401829985-5212-3-git-send-email-lho@apm.com>
References: <1401829985-5212-1-git-send-email-lho@apm.com>
 <1401829985-5212-2-git-send-email-lho@apm.com>
 <1401829985-5212-3-git-send-email-lho@apm.com>
Message-ID: <1401829985-5212-4-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds APM X-Gene SoC SDHC controller DTS entry.

Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 6042a99..3bd09e9 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -436,5 +436,13 @@
 			phys = <&phy3 0>;
 			phy-names = "sata-phy";
 		};
+
+		sdhc0: sdhc at 1c000000 {
+			compatible = "apm,arasan,sdhci-8.9a";
+			reg = <0x0 0x1c000000 0x0 0x100>,
+			      <0x0 0x1f2a0094 0x0 0x10>;
+			interrupts = <0x0 0x49 0x4>;
+			no-1-8-v;
+		};
 	};
 };
-- 
1.5.5
