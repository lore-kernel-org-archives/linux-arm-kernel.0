From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 18:00:10 +0100
Subject: [PATCH kexec-tools v2 17/32] arm: return proper error for missing
 crash kernel
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xso-0003t4-Tj@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return the proper error code (ENOCRASHKERNEL) for a missing crash
kernel region in /proc/iomem, so the error handling in kexec.c can
print the appropriate message.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index d85ab9b..4755f06 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -451,7 +451,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			 * No crash kernel memory reserved. We cannot do more
 			 * but just bail out.
 			 */
-			return -1;
+			return ENOCRASHKERNEL;
 		}
 		base = start;
 	} else {
-- 
1.9.1
