From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:35:53 +0900
Subject: [PATCH 14/14] ARM: shmobile: Include CA7 cores in APMU table
In-Reply-To: <cover.1380532277.git.horms+renesas@verge.net.au>
References: <cover.1380532277.git.horms+renesas@verge.net.au>
Message-ID: <43651b15de94d6a5e188ea032311e9661ec708d2.1380532277.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add information to the shared APMU code regarding
the APMU instance used to control the CA7 cores.

This can be used on r8a7790 and r8a73a4, but should
most likely be converted to DT in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index caaaa35..1da5a72 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -86,6 +86,10 @@ static struct {
 	{
 		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
 		.cpus = { 0, 1, 2, 3 },
+	},
+	{
+		.iomem = DEFINE_RES_MEM(0xe6151000, 0x88),
+		.cpus = { 0x100, 0x101, 0x102, 0x103 },
 	}
 };
 
-- 
1.8.4
