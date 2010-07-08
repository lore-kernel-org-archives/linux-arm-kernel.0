From: tony@atomide.com (Tony Lindgren)
Date: Thu, 08 Jul 2010 13:08:22 +0300
Subject: [PATCH 3/5] omap2/3/4: serial: kill dev_attr_sleep_timeout sparse warn
In-Reply-To: <20100708100715.19285.30066.stgit@baageli.muru.com>
References: <20100708100715.19285.30066.stgit@baageli.muru.com>
Message-ID: <20100708100822.19285.15230.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

Remove the following sparse warnings by declaring attr as static:
arch/arm/mach-omap2/serial.c:627:1: warning: symbol 'dev_attr_sleep_timeout'
was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 9476c1c..584a2ed 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -558,7 +558,8 @@ static ssize_t sleep_timeout_store(struct device *dev,
 	return n;
 }
 
-DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
+static DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show,
+		sleep_timeout_store);
 #define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
 #else
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
