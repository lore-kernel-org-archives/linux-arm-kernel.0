From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 11:43:53 +0100
Subject: [PATCH 01/16] ARM: ux500: Enable the external bus with Device Tree
In-Reply-To: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334659448-11521-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow for proper initialisation of the SMSC9115 Ethernet chip
and other devices which may be connected to the 'external bus',
Device Tree must first enable and traverse though it. This patch
enables the 'external bus' which will facilitate further
initialisation of its suborantate DT nodes.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index d68a73c..a352313 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -770,6 +770,7 @@ struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 static const struct of_device_id u8500_soc_node[] = {
 	/* only create devices below soc node */
 	{ .compatible = "stericsson,db8500", },
+	{ .compatible = "simple-bus"},
 	{ },
 };
 
-- 
1.7.9.1
