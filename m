From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 10 Feb 2012 01:47:42 +0200
Subject: [PATCH v3 02/10] ARM: tegra: export Tegra chipid
In-Reply-To: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
References: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1328831277-21002-3-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The powergating and reset handling code needs to differentiate between Tegra
variants. Therefore we export the chipid here.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/fuse.c |    2 +-
 arch/arm/mach-tegra/fuse.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index 032a936..3298880 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -34,7 +34,7 @@
 int tegra_sku_id;
 int tegra_cpu_process_id;
 int tegra_core_process_id;
-static int tegra_chip_id;
+int tegra_chip_id;
 enum tegra_revision tegra_revision;
 
 /* The BCT to use at boot is specified by board straps that can be read
diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
index c554572..d2107b2 100644
--- a/arch/arm/mach-tegra/fuse.h
+++ b/arch/arm/mach-tegra/fuse.h
@@ -41,6 +41,7 @@ enum tegra_revision {
 extern int tegra_sku_id;
 extern int tegra_cpu_process_id;
 extern int tegra_core_process_id;
+extern int tegra_chip_id;
 extern enum tegra_revision tegra_revision;
 
 extern int tegra_bct_strapping;
-- 
1.7.4.1
