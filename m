From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 16 Jul 2010 17:01:13 +0900
Subject: [PATCH v2 1/5] ARM: Samsung SoC: added hclk/pclk info to s3c_freq for
	s5pv210 cpu-freq
In-Reply-To: <1279267277-6804-1-git-send-email-myungjoo.ham@samsung.com>
References: <1279267277-6804-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1279267277-6804-2-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5PV210 requires msys/dsys info as well; thus, we've included those at
struct s3c_freq, which is used by CPUFREQ of S5PV210.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/cpu-freq.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq.h b/arch/arm/plat-samsung/include/plat/cpu-freq.h
index 80c4a80..9e97df7 100644
--- a/arch/arm/plat-samsung/include/plat/cpu-freq.h
+++ b/arch/arm/plat-samsung/include/plat/cpu-freq.h
@@ -38,6 +38,12 @@ struct s3c_freq {
 	unsigned long	hclk_tns;	/* in 10ths of ns */
 	unsigned long	hclk;
 	unsigned long	pclk;
+#ifdef CONFIG_ARCH_S5PV210
+	unsigned long	hclk_msys;
+	unsigned long	pclk_msys;
+	unsigned long	hclk_dsys;
+	unsigned long	pclk_dsys;
+#endif
 };
 
 /**
-- 
1.6.3.3
