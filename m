From: robh@kernel.org (Rob Herring)
Date: Thu,  8 Sep 2016 13:59:34 -0500
Subject: [PATCH 3/3] config: android: enable CONFIG_SECCOMP
In-Reply-To: <20160908185934.18098-1-robh@kernel.org>
References: <20160908185934.18098-1-robh@kernel.org>
Message-ID: <20160908185934.18098-3-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of Android N, SECCOMP is required. Without it, we will get
mediaextractor error:

E /system/bin/mediaextractor: libminijail: prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER): Invalid argument

Signed-off-by: Rob Herring <robh@kernel.org>
---
 kernel/configs/android-base.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/configs/android-base.config b/kernel/configs/android-base.config
index 859fa27..980e72d 100644
--- a/kernel/configs/android-base.config
+++ b/kernel/configs/android-base.config
@@ -132,6 +132,7 @@ CONFIG_PREEMPT=y
 CONFIG_QUOTA=y
 CONFIG_RTC_CLASS=y
 CONFIG_RT_GROUP_SCHED=y
+CONFIG_SECCOMP=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
-- 
2.9.3
