From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 31 Jan 2012 10:58:28 +0100
Subject: [PATCH 15/19] ARM: OMAP3+: SmartReflex: add missing
 platform_set_drvdata()
In-Reply-To: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Message-ID: <1328003912-11709-16-git-send-email-j-pihet@ti.com>
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
index 65e1a7c..eacf4b3 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1062,6 +1062,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	platform_set_drvdata(pdev, sr_info);
+
 	if (!pdata) {
 		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
 		ret = -EINVAL;
-- 
1.7.5.4
