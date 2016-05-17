From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Tue, 17 May 2016 14:27:00 +0000
Subject: imx-drm: regression due to commit 503fe87bd0a8 ("gpu: ipu-v3: Fix
 imx-ipuv3-crtc module autoloading")
In-Reply-To: <20160513123336.6996dd89@ipc1.ka-ro>
References: <20160513123336.6996dd89@ipc1.ka-ro>
Message-ID: <1463495219.3210.6.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there

On Fri, 2016-05-13 at 12:33 +0200, Lothar Wa?mann wrote:
> Hi,
> 
> the commit 503fe87bd0a8 ("gpu: ipu-v3: Fix imx-ipuv3-crtc module
> autoloading")
> indeed fixes the autoloading issue, but completely breaks the driver
> in
> non-modular mode (at least with the parallel-display driver I didn't
> yet check with the imx-ldb driver.
> Can anyone confirm that the imx-drm driver in current linux-next
> (next-20160512) works for them with any i.MX6 or i.MX53 board?

I can confirm that this is actually broken both in v4.6 and next-
20160517. Reverting commit 407c9eba7897 ("drm/imx: Remove of_node
assignment from ipuv3-crtc driver probe") in both cases makes regular
imx_v6_v7_defconfig work again.

> I'm always very suspicious when seeing code moving of_node's from
> one device to another or assigning of_node's to platform devices that
> weren't instantiated via DT.
> 
> 
> Lothar Wa?mann

Cheers

Marcel

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
