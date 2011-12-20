From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Dec 2011 13:33:02 -0800
Subject: [PATCH] arm/at91: fix build of stamp9g20
Message-ID: <1324416782-29035-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes build:

arch/arm/mach-at91/board-stamp9g20.c:126: error: expected '}' before ';' token

Signed-off-by: Olof Johansson <olof@lixom.net>
---

Nicolas, I haven't seen any replies from neither you nor Jean-Christoph
on the email I sent over a week ago about this. Can you ack this patch
and I'll apply it to the branch in arm-soc?

Thanks,

-Olof

 arch/arm/mach-at91/board-stamp9g20.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index e8d3d5b..72eb3b4 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -123,8 +123,8 @@ static void __init add_device_nand(void)
 static struct mci_platform_data __initdata mmc_data = {
 	.slot[0] = {
 		.bus_width	= 4,
-		.detect_pin	= -1;
-		.wp_pin		= -1;
+		.detect_pin	= -1,
+		.wp_pin		= -1,
 	},
 };
 #else
-- 
1.7.5.4
