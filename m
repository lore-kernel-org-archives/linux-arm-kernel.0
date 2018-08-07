From: ykaukab@suse.de (Mian Yousaf Kaukab)
Date: Tue,  7 Aug 2018 20:14:16 +0200
Subject: [PATCH 3/6] arm64: add sysfs vulnerability show for spectre v1
In-Reply-To: <20180807181419.15690-1-ykaukab@suse.de>
References: <20180807181419.15690-1-ykaukab@suse.de>
Message-ID: <20180807181419.15690-4-ykaukab@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hard-coded since patches are merged and there are no configuration
options.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 arch/arm64/kernel/cpu_errata.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 996edb4e18ad..92616431ae4e 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -706,4 +706,10 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "Vulnerable\n");
 }
 
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+}
+
 #endif
-- 
2.11.0
