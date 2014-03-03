From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Mar 2014 12:02:41 +1100
Subject: linux-next: manual merge of the bcm2835 tree with the arm-soc tree
Message-ID: <20140303120241.11066f951d53c50fb14faf47@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Today's linux-next merge of the bcm2835 tree got a conflict in
arch/arm/mach-bcm2835/Kconfig between commits ddb902cc3459 ("ARM:
centralize common multi-platform kconfig options") and 0676b21fffd1
("ARM: bcm2835: enable V6K instead of plain V6") from the arm-soc tree
and commit d30fe6272183 ("ARM: bcm2835: Move to mach-bcm directory") from
the bcm2835 tree.

I fixed it up (I applied the below merge fix patch) and can carry the fix
as necessary (no action is required).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 3 Mar 2014 12:00:40 +1100
Subject: [PATCH] ARM: bcm2835: merge fix for movement to mach-bcm directory

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/mach-bcm/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 396d05c8b570..7de3282a8613 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -33,10 +33,6 @@ config ARCH_BCM2835
 	select ARM_AMBA
 	select ARM_ERRATA_411920
 	select ARM_TIMER_SP804
-	select CLKDEV_LOOKUP
-	select CLKSRC_OF
-	select CPU_V6
-	select GENERIC_CLOCKEVENTS
 	select PINCTRL
 	select PINCTRL_BCM2835
 	help
-- 
1.9.0

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/5010523f/attachment.sig>
