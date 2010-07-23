From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jul 2010 21:58:26 +0200
Subject: [PATCH 03/11] ARM: sa1111: move __sa1111_probe() to .devinit.text
In-Reply-To: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1279915120-4373-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__sa1111_probe is only called by sa1111_probe that lives in .devinit.text.
So it's save to move the former to .devinit.text, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/common/sa1111.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 6f80665..97c5bc9 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -681,7 +681,7 @@ out:
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
