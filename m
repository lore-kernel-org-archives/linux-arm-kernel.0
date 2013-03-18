From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:59:31 +0900
Subject: [PATCH 04/13] ARM: shmobile: mark mackerel sh_mmcif_device
 __maybe_unused
In-Reply-To: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607980-22153-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Patch eac036ef9e "ARM: shmobile: streamline mackerel SD and MMC devices"
made the use of the sh_mmcif_device variable for mackarel optional,
but the definition is always provided, causing a build warning.

arch/arm/mach-shmobile/board-mackerel.c:1120:31: warning: 'sh_mmcif_device'
	defined but not used [-Wunused-variable]

Marking the variable as __maybe_unused will do the right thing here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index fb058c7..ef22ec4 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1118,7 +1118,7 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
 
-static struct platform_device sh_mmcif_device = {
+static struct platform_device sh_mmcif_device __maybe_unused = {
 	.name		= "sh_mmcif",
 	.id		= 0,
 	.dev		= {
-- 
1.7.10.4
