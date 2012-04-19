From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Apr 2012 21:36:30 +0100
Subject: [PATCH 01/15] ARM: ux500: Enable the external bus with Device Tree
In-Reply-To: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334867804-31942-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow for proper initialisation of the SMSC9115 Ethernet chip
and other devices which may be connected to the 'external bus',
Device Tree must first enable and traverse though it. This patch
enables the 'external bus' which will facilitate further
initialisation of its suborantate DT nodes.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index d68a73c..7938258 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -767,9 +767,10 @@ struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	{},
 };
 
-static const struct of_device_id u8500_soc_node[] = {
+static const struct of_device_id u8500_local_bus_nodes[] = {
 	/* only create devices below soc node */
 	{ .compatible = "stericsson,db8500", },
+	{ .compatible = "simple-bus"},
 	{ },
 };
 
-- 
1.7.9.1
