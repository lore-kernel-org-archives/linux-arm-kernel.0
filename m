From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 13 May 2016 12:33:36 +0200
Subject: imx-drm: regression due to commit 503fe87bd0a8 ("gpu: ipu-v3: Fix
 imx-ipuv3-crtc module autoloading")
Message-ID: <20160513123336.6996dd89@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the commit 503fe87bd0a8 ("gpu: ipu-v3: Fix imx-ipuv3-crtc module autoloading")
indeed fixes the autoloading issue, but completely breaks the driver in
non-modular mode (at least with the parallel-display driver I didn't
yet check with the imx-ldb driver.
Can anyone confirm that the imx-drm driver in current linux-next
(next-20160512) works for them with any i.MX6 or i.MX53 board?

I'm always very suspicious when seeing code moving of_node's from
one device to another or assigning of_node's to platform devices that
weren't instantiated via DT.


Lothar Wa?mann
