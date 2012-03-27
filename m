From: khilman@ti.com (Kevin Hilman)
Date: Mon, 26 Mar 2012 17:05:17 -0700
Subject: arm-soc/next/boards: mis-merge breaks build on OMAP4/Panda
Message-ID: <877gy6rjr6.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Looks like a conflict resolution in next/boards is causing a build
failure for OMAP4/Panda in arm-soc/for-next.

This merge:

  Merge tag 'asoc-3.4' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into next/boards

broke the build on OMAP4/Panda due to a missing ';' at the end of the
newly added panda_abe_audio platform_device.

Since you already sent the pull request to Linus, here's a patch on top
of next/boards to fix it.

Kevin

>From 3180f1d289b80dbe63f38931edd1245f10b619a0 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Mon, 26 Mar 2012 16:57:40 -0700
Subject: [PATCH] ARM: OMAP4: Panda: fix mis-merge build error

Merging some board changes from the ASoC tree with some board fixes
from the OMAP tree resulted in a minor mis-merge causing build failure
on OMAP4/Panda.  Fix it.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 7459844..7866749 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -114,7 +114,7 @@ static struct platform_device panda_abe_audio = {
 	.dev = {
 		.platform_data = &panda_abe_audio_data,
 	},
-}
+};
 
 static struct platform_device btwilink_device = {
 	.name	= "btwilink",
-- 
1.7.9.2
