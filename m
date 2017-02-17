From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 17 Feb 2017 18:00:32 +0100
Subject: [PATCH 2/2] arm64: dts: r8a7796: Upgrade to PSCI v1.0 to support
 Suspend-to-RAM
In-Reply-To: <1487350832-29820-1-git-send-email-geert+renesas@glider.be>
References: <1487350832-29820-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1487350832-29820-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>

>From PSCI v1.0, Suspend-to-RAM is supported via SYSTEM_SUSPEND PSCI
function call. Hence, upgrade PSCI version for R-Car M3 to support
Suspend-to-RAM.

The Suspend-to-RAM is highly dependent on ARM Trusted Firwmare support
since necessary callback functions will be registered after a query
to ARM Trusted Firmware about SYSTEM_SUSPEND support.

Since PSCI v1.0 is backward compatible with PSCI v0.2, CPU Hotplug and
CPUIdle should be able to work normally with this change.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Khiem: I've updated your email address.
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 0cd83974e42154c0..0cfcc15e9177159a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -29,7 +29,7 @@
 	};
 
 	psci {
-		compatible = "arm,psci-0.2";
+		compatible = "arm,psci-1.0";
 		method = "smc";
 	};
 
-- 
1.9.1
