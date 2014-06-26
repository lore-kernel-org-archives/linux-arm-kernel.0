From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Jun 2014 15:23:15 +0100
Subject: [PATCH 6/7] ASoC: kirkwood: allow smaller audio periods and smaller
 number of periods
In-Reply-To: <20140626142231.GR32514@n2100.arm.linux.org.uk>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
Message-ID: <E1X0Aa3-0003iU-Hc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no hardware restriction requiring a minimum of 8 periods, or
a minimum of 2048 bytes in a period.  Let's drop these values so that
userspace has more flexibility in choosing these parameters.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index ab21de090938..90e32a781424 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -124,9 +124,9 @@
 
 /* Theses values come from the marvell alsa driver */
 /* need to find where they come from               */
-#define KIRKWOOD_SND_MIN_PERIODS		8
+#define KIRKWOOD_SND_MIN_PERIODS		2
 #define KIRKWOOD_SND_MAX_PERIODS		16
-#define KIRKWOOD_SND_MIN_PERIOD_BYTES		0x800
+#define KIRKWOOD_SND_MIN_PERIOD_BYTES		256
 #define KIRKWOOD_SND_MAX_PERIOD_BYTES		0x8000
 #define KIRKWOOD_SND_MAX_BUFFER_BYTES		(KIRKWOOD_SND_MAX_PERIOD_BYTES \
 						 * KIRKWOOD_SND_MAX_PERIODS)
-- 
1.8.3.1
