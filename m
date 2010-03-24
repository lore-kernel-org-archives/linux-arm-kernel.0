From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Wed, 24 Mar 2010 14:32:18 +0300
Subject: [PATCH 3/3] imx31: add rtc device on litekit board.
In-Reply-To: <1269430338-22690-2-git-send-email-vzapolskiy@gmail.com>
References: <1269430338-22690-1-git-send-email-vzapolskiy@gmail.com>
	<1269430338-22690-2-git-send-email-vzapolskiy@gmail.com>
Message-ID: <1269430338-22690-3-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for SoC build-in RTC device on litekit board.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mx31lite-db.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index 0201683..466996e 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -207,5 +207,6 @@ void __init mx31lite_db_init(void)
 	mxc_register_device(&mxc_spi_device0, &spi0_pdata);
 	platform_device_register(&litekit_led_device);
 	mxc_register_device(&imx_wdt_device0, NULL);
+	mxc_register_device(&imx_rtc_device0, NULL);
 }
 
-- 
1.6.6.1
