From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  5 Feb 2016 13:08:18 +0100
Subject: [PATCH v3 0/3] Input: rotary_encoder - Fixups for Dmitry's rework and
 support for >2 gpios
Message-ID: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This bases on top of

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input rotary-encoder

(currently at 557a30f2f046).

Dmitry, I assume you will squash the two fixups accordingly, otherwise
just tell me, then I create proper patches.

Also let me note that with threaded irqs I'm able to rotate my device
quicker than irq handling happens. So a quick counterclockwise rotation
might be detected as single step clockwise rotation.

Best regards
Uwe

Uwe Kleine-K?nig (3):
  fixup! Input: rotary_encoder - convert to use gpiod API
  fixup! Input: rotary_encoder - use threaded irqs
  Input: rotary-encoder - support more than 2 gpios as input

 .../devicetree/bindings/input/rotary-encoder.txt   |   2 +-
 arch/arm/mach-pxa/raumfeld.c                       |   2 +-
 drivers/input/misc/rotary_encoder.c                | 158 +++++++++------------
 3 files changed, 68 insertions(+), 94 deletions(-)

-- 
2.7.0
