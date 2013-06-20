From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 20 Jun 2013 15:39:05 +0100
Subject: [PATCH 2/3] ARM: kernel: downgrade missing clock-frequency from
 error to warning
In-Reply-To: <1371739146-32639-1-git-send-email-f.fainelli@gmail.com>
References: <1371739146-32639-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1371739146-32639-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A subsequent patch will modify the ARM CPU binding documentation to make
it mandatory to supply either a "clocks" node, or a "clock-frequency"
node when the property "device_type" equals "cpu". Since this is going
to start spitting errors for some in-tree platforms, dowgrade the error
message to a simple warning.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/kernel/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 8f340a1..091ec84 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -124,7 +124,7 @@ static void __init parse_dt_topology(void)
 		if (IS_ERR(cpu_clk)) {
 			prop = of_get_property(cn, "clock-frequency", &len);
 			if (!prop || len != 4) {
-				pr_err("%s missing clock-frequency property\n",
+				pr_warn("%s missing clock-frequency property\n",
 					cn->full_name);
 				continue;
 			}
-- 
1.8.1.2
