From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jul 2016 17:19:27 +0100
Subject: [PATCH 2/2] init/main: Trigger re-execution of deferred deferred
 probe()s
In-Reply-To: <20160712161927.7521-1-lee.jones@linaro.org>
References: <20160712161927.7521-1-lee.jones@linaro.org>
Message-ID: <20160712161927.7521-3-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices require files from rootfs.

Ensure they are given a chance to re-probe() now that the rootfs is mounted.

Tested-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 init/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index 4c17fda..0b905a1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1035,6 +1035,7 @@ static noinline void __init kernel_init_freeable(void)
 	 * and default modules
 	 */
 
+	deferred_probe_trigger();
 	integrity_load_keys();
 	load_default_modules();
 }
-- 
2.9.0
