From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:35:30 +0000
Subject: [PATCH 16/33] MFD: ucb1x00-ts: provide input layer with device parent
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3wg-0000Yo-O9@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the input layer struct device with its parent device, so
that the input layer's device appears in the correct place in the
device tree.  This also allows the input device to be visibily
associated with its hardware.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-ts.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index ec6ffb6..742d0c7 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -363,6 +363,7 @@ static int ucb1x00_ts_add(struct ucb1x00_dev *dev)
 	idev->id.product = ts->ucb->id;
 	idev->open       = ucb1x00_ts_open;
 	idev->close      = ucb1x00_ts_close;
+	idev->dev.parent = &ts->ucb->dev;
 
 	idev->evbit[0]   = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
 	idev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
-- 
1.7.4.4
