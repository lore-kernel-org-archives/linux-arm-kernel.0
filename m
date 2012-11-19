From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:23:53 -0500
Subject: [PATCH 284/493] arm64: remove use of __devinit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-284-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Catalin Marinas <catalin.marinas@arm.com> 
Cc: linux-arm-kernel at lists.infradead.org 
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index c76c724..f7073c7 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1221,7 +1221,7 @@ static struct of_device_id armpmu_of_device_ids[] = {
 	{},
 };
 
-static int __devinit armpmu_device_probe(struct platform_device *pdev)
+static int armpmu_device_probe(struct platform_device *pdev)
 {
 	if (!cpu_pmu)
 		return -ENODEV;
-- 
1.8.0
