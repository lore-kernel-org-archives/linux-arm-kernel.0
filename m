From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 17:59:50 +0100
Subject: [PATCH kexec-tools v2 13/32] arm: fix pointer signedness warning in
 kexec-uImage-arm.c
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xsU-0003sg-4H@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kexec/arch/arm/kexec-uImage-arm.c: In function 'uImage_arm_probe':
kexec/arch/arm/kexec-uImage-arm.c:14:2: warning: pointer targets in passing argument 1 of 'uImage_probe_kernel' differ in signedness [-Wpointer-sign]

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/kexec-uImage-arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-uImage-arm.c b/kexec/arch/arm/kexec-uImage-arm.c
index 03c2f4d..8e0a9ac 100644
--- a/kexec/arch/arm/kexec-uImage-arm.c
+++ b/kexec/arch/arm/kexec-uImage-arm.c
@@ -11,7 +11,8 @@
 
 int uImage_arm_probe(const char *buf, off_t len)
 {
-	return uImage_probe_kernel(buf, len, IH_ARCH_ARM);
+	return uImage_probe_kernel((const unsigned char *)buf, len,
+				   IH_ARCH_ARM);
 }
 
 int uImage_arm_load(int argc, char **argv, const char *buf, off_t len,
-- 
1.9.1
