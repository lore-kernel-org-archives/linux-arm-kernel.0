From: nm@ti.com (Nishanth Menon)
Date: Tue, 22 Sep 2015 11:08:37 -0500
Subject: [PATCH 2/3] ARM: keystone: Update compatible to have SoC specific
 matches
In-Reply-To: <1442938118-4718-1-git-send-email-nm@ti.com>
References: <1442938118-4718-1-git-send-email-nm@ti.com>
Message-ID: <1442938118-4718-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With future SoCs of keystone2 family, the generic compatible match may
not be sufficient to handle SoC specific handling. So introduce matches
based on SoC compatiblity.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-keystone/keystone.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index e288010522f9..c279293f084c 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -97,6 +97,9 @@ static long long __init keystone_pv_fixup(void)
 }
 
 static const char *const keystone_match[] __initconst = {
+	"ti,k2hk",
+	"ti,k2e",
+	"ti,k2l",
 	"ti,keystone",
 	NULL,
 };
-- 
2.1.4
