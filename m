From: stigge@antcom.de (Roland Stigge)
Date: Thu, 12 Jul 2012 14:22:55 +0200
Subject: [PATCH] ARM: LPC32xx: Adjust to pl08x DMA interface changes
Message-ID: <1342095778-13403-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adjusts the LPC32xx platform support to the new pl08x DMA interface,
fixing the compile error resulting from changed pl08x structures.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

Applies to today's linux-next (integrated lpc32xx-next and dma branches which collide)

 arch/arm/mach-lpc32xx/phy3250.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 8625237..b07dcc9 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -186,13 +186,12 @@ static struct pl08x_channel_data pl08x_slave_channels[] = {
 	},
 };
 
-/* NOTE: These will change, according to RMK */
-static int pl08x_get_signal(struct pl08x_dma_chan *ch)
+static int pl08x_get_signal(const struct pl08x_channel_data *cd)
 {
-	return ch->cd->min_signal;
+	return cd->min_signal;
 }
 
-static void pl08x_put_signal(struct pl08x_dma_chan *ch)
+static void pl08x_put_signal(const struct pl08x_channel_data *cd, int ch)
 {
 }
 
-- 
1.7.10.4
