From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:49:58 +0900
Subject: [PATCH 10/11] ARM: shmobile: r8a7740: Add A4SU pm domain support
In-Reply-To: <cover.1415058794.git.horms+renesas@verge.net.au>
References: <cover.1415058794.git.horms+renesas@verge.net.au>
Message-ID: <4ee7830c3ef9224bd078abe41a33c7396f827078.1415058794.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add support for the A4SU power domain.
This domain contains the USBPHY hardware block, which is currently not
used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 74e6a67..27117a8 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -75,6 +75,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 	}, {
 		.genpd.name	= "A3SG",
 		.bit_shift	= 13,
+	}, {
+		.genpd.name	= "A4SU",
+		.bit_shift	= 20,
 	},
 };
 
-- 
2.1.1
