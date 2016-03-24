From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Mar 2016 14:24:19 +0100
Subject: [PATCH v2 0/6] serial: imx: handshaking fixes and improvments
Message-ID: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this is the reworked series to address the handshaking problems I saw.

Among others it made my i.MX25 stuck when the other side toggles DCD.
The first 4 patches are fixes that I'd like to see in 4.6-rcX, the last two
patches are merge window material.

Best regards
Uwe

Uwe Kleine-K?nig (6):
  serial: imx: fix polarity of RI
  serial: imx: let irq handler return IRQ_NONE if no event was handled
  serial: imx: make sure unhandled irqs are disabled
  serial: imx: only count 0->1 transitions for RNG
  serial: imx: reorder functions to simplify next patch
  serial: imx: implement DSR irq handling for DTE mode

 drivers/tty/serial/imx.c | 156 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 100 insertions(+), 56 deletions(-)

-- 
2.7.0
