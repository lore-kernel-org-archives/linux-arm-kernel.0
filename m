From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 10 Mar 2016 11:26:05 +0100
Subject: [PATCH 0/4] serial: imx: some irq and handshaking fixes
Message-ID: <1457605569-7828-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series doesn't solve all my problems but at least some. Now for my
remaining problem my machine at least doesn't reset (by watchdog) but
disables the serial irq instead which at least allows to debug further.
(Still I'm a bit out of ideas.)

The last patch doesn't fix a real problem I have, just noticed that
while working on the handshaking stuff.

It would be great if these patched made it into v4.6-rc1.

Best regards
Uwe

Uwe Kleine-K?nig (4):
  serial: imx: reorder functions to simplify next patch
  serial: imx: implement handshaking irq handling for DTE mode
  serial: imx: let irq handler return IRQ_NONE if no event was handled
  serial: imx: only count 0->1 transitions for RNG

 drivers/tty/serial/imx.c | 152 +++++++++++++++++++++++++++++------------------
 1 file changed, 95 insertions(+), 57 deletions(-)

-- 
2.7.0
