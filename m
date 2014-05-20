From: theuns.verwoerd@gmail.com (Theuns Verwoerd)
Date: Tue, 20 May 2014 18:04:40 +1200
Subject: [PATCH 1/1] ARM: Reduce Netwinder startup message from warning to
 notice
Message-ID: <CALMkhJxVHSHsBKuiOEnstcLaRnTcGqJWwijfabdxCqYmY+jYjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>

Reduce the level of the Netwinder floating point startup message from KERN_WARN
to KERN_NOTICE, since it is normal (correct) behaviour.

Signed-off-by: Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>

---

This is useful to support a test framework that monitors the kernel
for unexpected
warnings, in preference to white-listing the spurious warning.  Tested on kernel
version 3.6.11.

diff --git a/arch/arm/nwfpe/fpmodule.c b/arch/arm/nwfpe/fpmodule.c
index 4e729f0..ad68be4 100644
--- a/arch/arm/nwfpe/fpmodule.c
+++ b/arch/arm/nwfpe/fpmodule.c
@@ -98,7 +98,7 @@ static int __init fpe_init(void)
                return 0;

        /* Display title, version and copyright information. */
-       printk(KERN_WARNING "NetWinder Floating Point Emulator V0.97 ("
+       printk(KERN_NOTICE "NetWinder Floating Point Emulator V0.97 ("
               NWFPE_BITS " precision)\n");

        thread_register_notifier(&nwfpe_notifier_block);
