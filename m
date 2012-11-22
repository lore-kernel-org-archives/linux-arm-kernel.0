From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Fri, 23 Nov 2012 06:30:12 +0900
Subject: [PATCH 3/3] ARM: Kirkwood: Convert to EHCI via DT for OpenBlocks A6
In-Reply-To: <1353619812-2195-1-git-send-email-iwamatsu@nigauri.org>
References: <1353619812-2195-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <1353619812-2195-3-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EHCI driver enables by default in kirkwood.dtsi.
This removes kirkwood_ehci_init function.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/mach-kirkwood/board-openblocks_a6.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-kirkwood/board-openblocks_a6.c b/arch/arm/mach-kirkwood/board-openblocks_a6.c
index e807e8c..e71f984 100644
--- a/arch/arm/mach-kirkwood/board-openblocks_a6.c
+++ b/arch/arm/mach-kirkwood/board-openblocks_a6.c
@@ -66,6 +66,5 @@ void __init openblocks_a6_init(void)
 	 * Basic setup. Needs to be called early.
 	 */
 	kirkwood_mpp_conf(openblocks_a6_mpp_config);
-	kirkwood_ehci_init();
 	kirkwood_ge00_init(&openblocks_ge00_data);
 }
-- 
1.7.10.4
