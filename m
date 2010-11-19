From: inki.dae@samsung.com (daeinki)
Date: Fri, 19 Nov 2010 10:28:27 +0900
Subject: [PATCH 0/3] S5PV210: added MIPI-DSI Driver.
Message-ID: <4CE5D2BB.2060308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

This patch is a MIPI-DSI driver for S5PV210.

PATCH 1/3: add a structure for CPU interface to linux/fb.h
- RGB or CPU interfaces could be used as display mode but framebuffer
framework doesn't consider CPU interface so I added this structure
because fb_cpumode structure could be used commonly.

PATCH 2/3: add parameters for CPU interface to plat-samsung/fb.h
- MIPI-DSI driver would use s3c-fb driver so I added some parameters
because MIPI-DSI driver supports CPU interface also.

PATCH 3/3: add MIPI-DSI driver for S5PV210.

driver features:
. Maximum resolution ranges up to XGA (1024x760)
. CSIS0 supports 1,2,3 or 4 data lanes
. CSIS1 supports 1 or 2 data lanes
. supports pixel format : 16bpp, 18bpp packed,
    18bpp loosely packed (3 byte format), and 24bpp
. supports RGB interface for video image from display controller
. support I80 interface for command mode image input from display controller
. supports PMS control inteerface for PLL to configure byte clock frequency
. supports Prescaler to generate escape clock from byte clock


thank you.

signed-off-by: Inki Dae <inki.dae@samsung.com>
signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
