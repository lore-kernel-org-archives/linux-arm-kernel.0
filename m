From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 May 2011 08:27:36 +0100
Subject: [PATCH 01/13] Make clocksource name const
In-Reply-To: <20110510072700.GA29869@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
Message-ID: <E1QJhM0-0000yN-CG@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As nothing should be writing to the clocksource name string, make the
clocksource name pointer const.  Build-tested on ARM Versatile Express.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Colin Cross <ccross@android.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Erik Gilling <konkers@android.com>
Cc: "Hans J. Koch" <hjk@hansjkoch.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-omap at vger.kernel.org
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Olof Johansson <olof@lixom.net>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/clocksource.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index c37b21a..94c1f38 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -161,7 +161,7 @@ struct clocksource {
 	/*
 	 * First part of structure is read mostly
 	 */
-	char *name;
+	const char *name;
 	struct list_head list;
 	int rating;
 	cycle_t (*read)(struct clocksource *cs);
-- 
1.7.4.4
