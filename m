From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:37 +0900
Subject: [GIT PULL 20/26] ARM: shmobile: r8a7790: add missing __initdata
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
Message-ID: <163a2a6cf1fa1d20c6c9e89d358180f409bcc7ce.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds missing __initdata to driver data/resource
which are used from platform_device_register_xxx()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 6d4aa04..d0f5c9f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -161,13 +161,13 @@ static struct resource thermal_resources[] __initdata = {
 					thermal_resources,		\
 					ARRAY_SIZE(thermal_resources))
 
-static struct sh_timer_config cmt00_platform_data = {
+static struct sh_timer_config cmt00_platform_data __initdata = {
 	.name = "CMT00",
 	.timer_bit = 0,
 	.clockevent_rating = 80,
 };
 
-static struct resource cmt00_resources[] = {
+static struct resource cmt00_resources[] __initdata = {
 	DEFINE_RES_MEM(0xffca0510, 0x0c),
 	DEFINE_RES_MEM(0xffca0500, 0x04),
 	DEFINE_RES_IRQ(gic_spi(142)), /* CMT0_0 */
-- 
1.8.3.2
