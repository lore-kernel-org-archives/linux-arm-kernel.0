From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 14 May 2018 14:34:51 +0100
Subject: [PATCH v2 1/3] perf/arm-cc*: Fix MODULE_LICENSE() tags
In-Reply-To: <cover.1526303815.git.robin.murphy@arm.com>
References: <cover.1526303815.git.robin.murphy@arm.com>
Message-ID: <d62c107dcd95ff209cfa87d0165d8987aa5453a9.1526303815.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCI/CCN drivers are licensed under GPLv2, but the MODULE_LICENSE()
tags are using the bare "GPL" string implying GPLv2 or later. Fix them
to match their actual file license.

Acked-by: Pawel Moll <pawel.moll@arm.com>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: No change

 drivers/perf/arm-cci.c | 2 +-
 drivers/perf/arm-ccn.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 383b2d3dcbc6..53c774b20563 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1718,5 +1718,5 @@ static struct platform_driver cci_pmu_driver = {
 };
 
 builtin_platform_driver(cci_pmu_driver);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("ARM CCI PMU support");
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 65b7e4042ece..917b47e776df 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1594,4 +1594,4 @@ module_init(arm_ccn_init);
 module_exit(arm_ccn_exit);
 
 MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0.dirty
