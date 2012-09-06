From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 6 Sep 2012 17:55:28 +0300
Subject: [PATCH 1/2] ARM: tegra: fix return value for debugfs init
Message-ID: <1346943329-4898-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tegra_powergate_debugfs_init() always returns -ENOMEM. It shouldn't do that
when registering the debugfs entry succeeded.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/powergate.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index 15d5065..27aee4a 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -237,14 +237,13 @@ static const struct file_operations powergate_fops = {
 int __init tegra_powergate_debugfs_init(void)
 {
 	struct dentry *d;
-	int err = -ENOMEM;
 
 	d = debugfs_create_file("powergate", S_IRUGO, NULL, NULL,
 		&powergate_fops);
 	if (!d)
 		return -ENOMEM;
 
-	return err;
+	return 0;
 }
 
 #endif
-- 
1.7.7.rc0.72.g4b5ea.dirty
