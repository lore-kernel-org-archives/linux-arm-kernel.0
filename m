From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 11 May 2018 15:02:41 -0700
Subject: [PATCH 1/2] soc: bcm: brcmstb: pm: Add support for newer rev B3.0
 controllers
In-Reply-To: <20180511220242.837-1-f.fainelli@gmail.com>
References: <20180511220242.837-1-f.fainelli@gmail.com>
Message-ID: <20180511220242.837-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Berger <opendmb@gmail.com>

Update the Device Tree binding document and add a matching entry for the
MEMC DDR controller revision B3.0 which is found on chips like 7278A0
and newer.

Signed-off-by: Doug Berger <opendmb@gmail.com>
[florian: tweak commit message, make it apply to upstream kernel]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt | 1 +
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
index c052caad36e8..fb762059e68e 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
@@ -190,6 +190,7 @@ Power-Down (SRPD), among other things.
 Required properties:
 - compatible     : should contain one of these
 	"brcm,brcmstb-memc-ddr-rev-b.2.2"
+	"brcm,brcmstb-memc-ddr-rev-b.3.0"
 	"brcm,brcmstb-memc-ddr"
 - reg            : the MEMC DDR register range
 
diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index dcf8c8065508..ade724677238 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -631,6 +631,10 @@ static const struct of_device_id brcmstb_memc_of_match[] = {
 		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.2",
 		.data = &ddr_seq_b22,
 	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.3.0",
+		.data = &ddr_seq_b22,
+	},
 	{
 		.compatible = "brcm,brcmstb-memc-ddr",
 		.data = &ddr_seq,
-- 
2.14.1
