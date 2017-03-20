From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:29 +0100
Subject: [PATCH 18/32] arm64: dts: r8a7795: Upgrade to PSCI v1.0 to support
 Suspend-to-RAM
In-Reply-To: <cover.1489999913.git.horms+renesas@verge.net.au>
References: <cover.1489999913.git.horms+renesas@verge.net.au>
Message-ID: <71585040b77e7b388708dc35bdc49f106fa55a4a.1489999913.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>

>From PSCI v1.0, Suspend-to-RAM is supported via SYSTEM_SUSPEND PSCI
function call. Hence, upgrade PSCI version for R-Car H3 to support
Suspend-to-RAM.

The Suspend-to-RAM is highly dependent on ARM Trusted Firwmare support
since necessary callback functions will be registered after a query
to ARM Trusted Firmware about SYSTEM_SUSPEND support.

Since PSCI v1.0 is backward compatible with PSCI v0.2, CPU Hotplug and
CPUIdle should be able to work normally with this change.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Keep "arm,psci-0.2"]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 3573872974e0..c1e00a3e7c45 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -29,7 +29,7 @@
 	};
 
 	psci {
-		compatible = "arm,psci-0.2";
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
 	};
 
-- 
2.7.0.rc3.207.g0ac5344
