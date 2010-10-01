From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:43 -0700
Subject: [PATCH 19/47] davinci: dm365 evm: use EDMAQ_3 as the audio DMA queue
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-20-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

By default the audio driver uses EDMAQ_0 as the DMA queue,
but on DM365 this queue is specially designed for video
transfers with a large fifo size. Having both audio and
video transfers on the same queue leads to noise on the
audio side.

This patch changes the audio queue number for DM365 to
EDMAQ_3.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 84acef1..bdea2da 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -175,7 +175,9 @@ static struct at24_platform_data eeprom_info = {
 	.context	= (void *)0x7f00,
 };
 
-static struct snd_platform_data dm365_evm_snd_data;
+static struct snd_platform_data dm365_evm_snd_data = {
+	.asp_chan_q = EVENTQ_3,
+};
 
 static struct i2c_board_info i2c_info[] = {
 	{
-- 
1.7.2.1
