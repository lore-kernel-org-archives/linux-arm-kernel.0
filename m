From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 05 Aug 2014 16:48:35 +0200
Subject: [PATCH V2 2/4] ARM: perf: Associate PMU data with driver.
In-Reply-To: <20140805144831.25462.18149.stgit@localhost>
References: <20140805144831.25462.18149.stgit@localhost>
Message-ID: <20140805144835.25462.71004.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to use the PM hooks for platform specific control we sometimes
need access to the PMU driver data.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 arch/arm/kernel/perf_event_cpu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index c09e18e..951a542 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -311,6 +311,7 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 
 	cpu_pmu = pmu;
 	cpu_pmu->plat_device = pdev;
+	dev_set_drvdata(&pdev->dev, pmu);
 
 	if (node && (of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node))) {
 		pmu->activated_flags.secure_regs_available =
