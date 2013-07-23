From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 23 Jul 2013 13:01:17 +0100
Subject: [PATCH v3] xen/arm,
 arm64: update xen_restart after ff701306cd49 and 7b6d864b48d9
Message-ID: <1374580878-22202-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7b6d864b48d9 (reboot: arm: change reboot_mode to use enum
reboot_mode) and ff701306cd49 (arm64: use common reboot infrastructure)
change the prototype of arm_pm_restart on arm and arm64.
Update xen_restart accordingly.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index f71c37e..c9770ba 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -172,7 +172,7 @@ static void __init xen_percpu_init(void *unused)
 	enable_percpu_irq(xen_events_irq, 0);
 }
 
-static void xen_restart(char str, const char *cmd)
+static void xen_restart(enum reboot_mode reboot_mode, const char *cmd)
 {
 	struct sched_shutdown r = { .reason = SHUTDOWN_reboot };
 	int rc;
-- 
1.7.2.5
