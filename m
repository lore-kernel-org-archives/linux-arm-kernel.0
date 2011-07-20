From: per.forlin@linaro.org (Per Forlin)
Date: Thu, 21 Jul 2011 00:01:59 +0200
Subject: [PATCH v3 1/3] fault-inject: make fault injection available for
	modules
In-Reply-To: <1311199321-4618-1-git-send-email-per.forlin@linaro.org>
References: <1311199321-4618-1-git-send-email-per.forlin@linaro.org>
Message-ID: <1311199321-4618-2-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

export symbols should_fail() and init_fault_attr_dentries() in order
to make modules use the fault injection functionality

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 lib/fault-inject.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 7e65af7..27783da 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -131,6 +131,7 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(should_fail);
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 
@@ -311,5 +312,6 @@ fail:
 	cleanup_fault_attr_dentries(attr);
 	return -ENOMEM;
 }
+EXPORT_SYMBOL_GPL(init_fault_attr_dentries);
 
 #endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
-- 
1.7.4.1
