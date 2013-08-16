From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Fri, 16 Aug 2013 19:41:02 +0530
Subject: [PATCH v5 2/2] ARM: davinci: da850: add OF_DEV_AUXDATA entry for
 davinci_emac
In-Reply-To: <1376662262-21795-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1376662262-21795-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <1376662262-21795-3-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

Add OF_DEV_AUXDATA for ethernet davinci_emac driver in da850 board dt
file to use emac clock.

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index d172563..d2bc574 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -44,6 +44,8 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ns16550a", 0x01d0c000, "serial8250.1", NULL),
 	OF_DEV_AUXDATA("ns16550a", 0x01d0d000, "serial8250.2", NULL),
 	OF_DEV_AUXDATA("ti,davinci_mdio", 0x01e24000, "davinci_mdio.0", NULL),
+	OF_DEV_AUXDATA("ti,davinci-dm6467-emac", 0x01e20000, "davinci_emac.1",
+		       NULL),
 	{}
 };
 
-- 
1.7.9.5
