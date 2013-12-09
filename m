From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  9 Dec 2013 15:06:49 -0700
Subject: [PATCH 3/3] ARM: tegra: set up /aliases entries for RTCs
In-Reply-To: <1386626809-6251-1-git-send-email-swarren@wwwdotorg.org>
References: <1386626809-6251-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1386626809-6251-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This ensures that the PMIC RTC provides the system time, rather than
the on-SoC RTC, which is not battery-backed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is just an example. If the previous two patches are accepted,
I'll flesh this patch out to cover all boards, and repost.
---
 arch/arm/boot/dts/tegra20-seaboard.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index ff63da7ff00d..1e62b7c5611f 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -6,6 +6,11 @@
 	model = "NVIDIA Seaboard";
 	compatible = "nvidia,seaboard", "nvidia,tegra20";
 
+	aliases {
+		rtc0 = "/i2c at 7000d000/tps6586x at 34";
+		rtc1 = "/rtc at 7000e000";
+	};
+
 	memory {
 		reg = <0x00000000 0x40000000>;
 	};
-- 
1.8.1.5
