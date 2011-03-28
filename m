From: rajeev-dlh.kumar@st.com (Rajeev Kumar)
Date: Mon, 28 Mar 2011 15:23:57 +0530
Subject: [PATCH] input/spear-keyboard fix: return IRQ_NONE if (status reg &
	DATA_AVAIL)
Message-ID: <1301306037-27666-1-git-send-email-rajeev-dlh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should return IRQ_NONE from interrupt handler in case data is not
avail for keyboard

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 drivers/input/keyboard/spear-keyboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index f18dc67..c6ab1df 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -70,7 +70,7 @@ static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
 	u8 sts, val;
 
 	sts = readb(kbd->io_base + STATUS_REG);
-	if (sts & DATA_AVAIL)
+	if (!(sts & DATA_AVAIL))
 		return IRQ_NONE;
 
 	if (kbd->last_key != KEY_RESERVED) {
-- 
1.6.0.2
