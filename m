From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 11 Mar 2015 17:56:36 +0100
Subject: [PATCH 14/15] ARM: cns3xxx: don't export static symbol
In-Reply-To: <1426092997-30605-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1426092997-30605-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1426092997-30605-15-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
type T;
identifier f;
@@

static T f (...) { ... }

@@
identifier r.f;
declarer name EXPORT_SYMBOL;
@@

-EXPORT_SYMBOL(f);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/arm/mach-cns3xxx/pm.c |    1 -
 1 file changed, 1 deletion(-)

diff -u -p a/arch/arm/mach-cns3xxx/pm.c b/arch/arm/mach-cns3xxx/pm.c
--- a/arch/arm/mach-cns3xxx/pm.c
+++ b/arch/arm/mach-cns3xxx/pm.c
@@ -73,7 +73,6 @@ static void cns3xxx_pwr_soft_rst_force(u
 
 	__raw_writel(reg, PM_SOFT_RST_REG);
 }
-EXPORT_SYMBOL(cns3xxx_pwr_soft_rst_force);
 
 void cns3xxx_pwr_soft_rst(unsigned int block)
 {
