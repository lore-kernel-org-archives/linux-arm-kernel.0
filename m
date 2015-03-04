From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  4 Mar 2015 14:35:53 +0000
Subject: [PATCH v2 6/6] target-arm: cpu.h document why env->spsr exists
In-Reply-To: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
References: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1425479753-18349-7-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was getting very confused about the duplication of state. Perhaps we
should just get rid of env->spsr and use helpers that understand the
banking?

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

diff --git a/target-arm/cpu.h b/target-arm/cpu.h
index 11845a6..d7fd13f 100644
--- a/target-arm/cpu.h
+++ b/target-arm/cpu.h
@@ -155,6 +155,11 @@ typedef struct CPUARMState {
        This contains all the other bits.  Use cpsr_{read,write} to access
        the whole CPSR.  */
     uint32_t uncached_cpsr;
+    /* The spsr is a alias for spsr_elN where N is the current
+     * exception level. It is provided for here so the TCG msr/mrs
+     * implementation can access one register. Care needs to be taken
+     * to ensure the banked_spsr[] is also updated.
+     */
     uint32_t spsr;
 
     /* Banked registers.  */
-- 
2.3.1
