From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Sun, 21 Jul 2013 16:24:17 +0100
Subject: [PATCH] xen/arm and xen/arm64: update xen_restart after ff701306cd49
Message-ID: <1374420257-19467-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ff701306cd49 changes the prototype of arm_pm_restart.
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
