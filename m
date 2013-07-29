From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 29 Jul 2013 11:20:21 +0100
Subject: [GIT PULL] Xen ARM fix for 3.11
Message-ID: <alpine.DEB.2.02.1307291056000.4893@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,
I have one fix for Xen on ARM for 3.11 (also appended for your
convenience):


The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git xen-arm-3.11-rc2-warn-tag

Stefano Stabellini (1):
      xen/arm,arm64: update xen_restart after ff701306cd49 and 7b6d864b48d9

 arch/arm/xen/enlighten.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


Thanks,

Stefano




commit 2451ade070ef9b0a0f118ac41896da856e72b5a1
Author: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Date:   Sun Jul 21 15:17:54 2013 +0000

    xen/arm,arm64: update xen_restart after ff701306cd49 and 7b6d864b48d9
    
    Commit 7b6d864b48d9 (reboot: arm: change reboot_mode to use enum
    reboot_mode) and ff701306cd49 (arm64: use common reboot infrastructure)
    change the prototype of arm_pm_restart on arm and arm64.
    Update xen_restart accordingly.
    
    Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

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
