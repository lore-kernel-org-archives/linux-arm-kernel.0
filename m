From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 25 Jun 2015 15:30:51 +0200
Subject: [PATCH 1/2] ARM-kernel: Delete an unnecessary check before the
 function call "smp_set_ops"
In-Reply-To: <558C01C5.4060303@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <558C01C5.4060303@users.sourceforge.net>
Message-ID: <558C028B.7020907@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jun 2015 15:00:17 +0200

The smp_set_ops() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e6d8c76..9ac786d 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -977,7 +977,7 @@ void __init setup_arch(char **cmdline_p)
 		if (!mdesc->smp_init || !mdesc->smp_init()) {
 			if (psci_smp_available())
 				smp_set_ops(&psci_smp_ops);
-			else if (mdesc->smp)
+			else
 				smp_set_ops(mdesc->smp);
 		}
 		smp_init_cpus();
-- 
2.4.4
