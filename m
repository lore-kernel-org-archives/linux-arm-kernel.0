From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 09 Jan 2018 16:59:05 +0900
Subject: [PATCH 8/9] arm64: dts: exynos: Add cpu_suspend property of PSCI
 for exynos5433
In-Reply-To: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
References: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <CGME20180109075906epcas1p15df259f70311dd96fc2c9ff256b2b615@epcas1p1.samsung.com>
Message-ID: <1515484746-10656-9-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM64 Exynos5433 supports PSCI(Power State Coordinate Interface)[1] v0.1.
When PSCI v0.1 is used, the device-tree should contain the specific entry
point such as cpu_suspend. This patch adds the 'cpu_suspend' property
in order to support the cpuidle and suspend execution on Exynos5433 SoC.

The 'cpu_suspend' of psci is originally intended for use in idle subsystems.
Although the cpuidle and suspend-to-RAM framework have separate routine
in order to enter the low-power state, PSCI v0.1 doesn't support
the separate the entry point such as 'system_suspend' on PSCI v1.0.

So, the 'cpu_suspend' of PSCI v0.1 on Exynos5433 is used for both
cpuidle and suspend-to-RAM.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0022d/Power_State_Coordination_Interface_PDD_v1_1_DEN0022D.pdf

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 77f4321b247c..0d99ded21202 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -227,6 +227,7 @@
 	psci {
 		compatible = "arm,psci";
 		method = "smc";
+		cpu_suspend = <0xc4000001>;
 		cpu_off = <0x84000002>;
 		cpu_on = <0xC4000003>;
 	};
-- 
1.9.1
