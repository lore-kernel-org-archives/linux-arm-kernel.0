From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 25 Sep 2014 18:15:41 +0200
Subject: [PATCH v2 10/11] ARM: shmobile: r8a7740: Add A4SU pm domain support
In-Reply-To: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
References: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1411661742-4767-11-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the A4SU power domain.
This domain contains the USBPHY hardware block, which is currently not
used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop FIXME about hooking up USB platform devices, as the Armadillo
    platform code doesn't register a USB host device anyway?
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 7226c3543ecdc0ea..f3a1c92f5de6177d 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -63,6 +63,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
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
