From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:36 +0200
Subject: [PATCH 02/19] ARM: sa1111: move __sa1111_probe() to .devinit.text
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__sa1111_probe is only called by sa1111_probe that lives in .devinit.text.
So it's save to move the former to .devinit.text, too.

Acked-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/common/sa1111.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 517d50d..c0258a8 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -678,7 +678,7 @@ out:
  *	%-EBUSY		physical address already marked in-use.
  *	%0		successful.
  */
-static int
+static int __devinit
 __sa1111_probe(struct device *me, struct resource *mem, int irq)
 {
 	struct sa1111 *sachip;
-- 
1.7.1
