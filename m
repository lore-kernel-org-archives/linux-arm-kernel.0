From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 23 Oct 2014 13:19:00 +0200
Subject: [PATCH v3 10/11] ARM: shmobile: r8a7740: Add A4SU pm domain support
In-Reply-To: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1414063141-8856-11-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the A4SU power domain.
This domain contains the USBPHY hardware block, which is currently not
used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,
v2:
  - Drop FIXME about hooking up USB platform devices, as the Armadillo
    platform code doesn't register a USB host device anyway?
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 74e6a67a28d3c336..27117a8a49ad8556 100644
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
1.9.1
