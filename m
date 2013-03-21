From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 21 Mar 2013 19:16:19 +0000
Subject: [PATCH 3/4] xen: move the xenvm machine to mach-virt
In-Reply-To: <alpine.DEB.2.02.1303211848150.5135@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1303211848150.5135@kaball.uk.xensource.com>
Message-ID: <1363893380-14309-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

xenvm is based on mach-vexpress, move it to mach-virt.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: marc.zyngier at arm.com
CC: will.deacon at arm.com
CC: arnd at arndb.de
CC: rob.herring at calxeda.com
---
 arch/arm/mach-vexpress/v2m.c |    1 -
 arch/arm/mach-virt/virt.c    |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 915683c..c43ec78 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -469,7 +469,6 @@ static void __init v2m_dt_init(void)
 
 static const char * const v2m_dt_match[] __initconst = {
 	"arm,vexpress",
-	"xen,xenvm",
 	NULL,
 };
 
diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
index 31666f6..528c05e 100644
--- a/arch/arm/mach-virt/virt.c
+++ b/arch/arm/mach-virt/virt.c
@@ -40,6 +40,7 @@ static void __init virt_timer_init(void)
 
 static const char *virt_dt_match[] = {
 	"linux,dummy-virt",
+	"xen,xenvm",
 	NULL
 };
 
-- 
1.7.2.5
