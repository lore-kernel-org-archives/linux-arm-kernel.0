From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 24 Feb 2017 14:49:14 +0100
Subject: [PATCH v2 2/2] arm64: dts: r8a7796: Upgrade to PSCI v1.0 to support
 Suspend-to-RAM
In-Reply-To: <1487944154-31435-1-git-send-email-geert+renesas@glider.be>
References: <1487944154-31435-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1487944154-31435-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>

>From PSCI v1.0, Suspend-to-RAM is supported via SYSTEM_SUSPEND PSCI
function call. Hence, upgrade PSCI version for R-Car M3-W to support
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
---
Khiem: I've updated your email address.

v2:
  - Keep "arm,psci-0.2".
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index e664456490ec0cc7..4985274b3c5f4a06 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -29,7 +29,7 @@
 	};
 
 	psci {
-		compatible = "arm,psci-0.2";
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
 	};
 
-- 
2.7.4
