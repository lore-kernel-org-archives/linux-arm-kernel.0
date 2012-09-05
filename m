From: horms@verge.net.au (Simon Horman)
Date: Wed,  5 Sep 2012 10:34:51 +0900
Subject: [PATCH 1/3] ARM: shmobile: armadillo800eva: fixup: sound card
 detection order
In-Reply-To: <1346808893-14124-1-git-send-email-horms@verge.net.au>
References: <1346808893-14124-1-git-send-email-horms@verge.net.au>
Message-ID: <1346808893-14124-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Since armadillo800eva has 2 sound cards,
and had reversed deferred probe order issue,
it was purposely registered in reverse order.

But it was solved by
1d29cfa57471a5e4b8a7c2a7433eeba170d3ad92
(driver core: fixup reversed deferred probe order)

armadillo800eva board is expecting that
FSI-WM8978 is the 1st, and FSI-HDMI is the 2nd sound card.
This patch fixes it up

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index cf10f92..ecd8136 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -901,8 +901,8 @@ static struct platform_device *eva_devices[] __initdata = {
 	&camera_device,
 	&ceu0_device,
 	&fsi_device,
-	&fsi_hdmi_device,
 	&fsi_wm8978_device,
+	&fsi_hdmi_device,
 };
 
 static void __init eva_clock_init(void)
-- 
1.7.10.4
