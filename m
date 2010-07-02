From: inki.dae@samsung.com (InKi Dae)
Date: Fri, 02 Jul 2010 17:47:58 +0900
Subject: [PATCH 0/2] ARM: S5PV210: Add MIPI-DSI support.
In-Reply-To: <4C29AF72.6090200@samsung.com>
References: <4C29AF72.6090200@samsung.com>
Message-ID: <4C2DA7BE.6070701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

This patch is for MIPI-DSI controller based on S5PV210 (or S5PC110), and solved the problem, added cpu timing variables to fb_varscreen_info and Andrew Morton, Russell King and Jaya Kumar pointed out.
so I'm sending these patch series again.

LCD Panel can use following interfaces,
- RGB or CPU Interface.
- RGB or CPU Interface based on MIPI-DSI.

in case of small size lcd panel, it was ok only rgb or cpu interface not using mipi controller.
but big size panel(more then 480x800) needs MIPI-DSI Interface or other hardwares like LVDS To transfer image data to lcd panel fine.

I tested this patch on cpu interface based on MIPI so for this patch, Some mainline codes should be modified and also considered RGB interface.

This patch set consists of the following patches,

[PATCH 1/2] S5PV210: FB: Add MIPI-DSI and CPU Interface features.
[PATCH 1/2] S5PV210: Add MIPI-DSI Driver.

Best regards,
InKi Dae
