From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu,  4 Sep 2014 16:35:26 -0600
Subject: [PATCH v5 1/7] msm: scm: Add SCM warmboot flags for quad core targets.
In-Reply-To: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
References: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1409870132-16929-2-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quad core targets like APQ8074, APQ8064, APQ8084 need SCM support set up
warm boot addresses in the Secure Monitor. Extend the SCM flags to
support warmboot addresses for secondary cores.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 include/soc/qcom/scm-boot.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/soc/qcom/scm-boot.h b/include/soc/qcom/scm-boot.h
index 6aabb24..02b445c 100644
--- a/include/soc/qcom/scm-boot.h
+++ b/include/soc/qcom/scm-boot.h
@@ -18,6 +18,8 @@
 #define SCM_FLAG_COLDBOOT_CPU3		0x20
 #define SCM_FLAG_WARMBOOT_CPU0		0x04
 #define SCM_FLAG_WARMBOOT_CPU1		0x02
+#define SCM_FLAG_WARMBOOT_CPU2		0x10
+#define SCM_FLAG_WARMBOOT_CPU3		0x40
 
 int scm_set_boot_addr(phys_addr_t addr, int flags);
 
-- 
1.9.1
