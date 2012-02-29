From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 29 Feb 2012 23:33:44 +0100
Subject: [PATCH 08/13] ARM: OMAP3+: SmartReflex: add missing
 platform_set_drvdata()
In-Reply-To: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Message-ID: <1330554829-11347-9-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

That's very useful to fetch the correct struct sr_info
from the PM handlers.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 40a85e3..22fe442 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -888,6 +888,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	platform_set_drvdata(pdev, sr_info);
+
 	if (!pdata) {
 		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
 		ret = -EINVAL;
-- 
1.7.5.4
