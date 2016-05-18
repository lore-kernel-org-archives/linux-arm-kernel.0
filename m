From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 18 May 2016 11:12:43 +0200
Subject: imx-drm: regression due to commit 503fe87bd0a8 ("gpu: ipu-v3:
 Fix imx-ipuv3-crtc module autoloading")
In-Reply-To: <1463137452.3544.5.camel@pengutronix.de>
References: <20160513123336.6996dd89@ipc1.ka-ro>
 <1463137452.3544.5.camel@pengutronix.de>
Message-ID: <20160518111243.111b8e9c@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 13 May 2016 13:04:12 +0200 Philipp Zabel wrote:
> Hi Lothar,
> 
> Am Freitag, den 13.05.2016, 12:33 +0200 schrieb Lothar Wa?mann:
> > Hi,
> > 
> > the commit 503fe87bd0a8 ("gpu: ipu-v3: Fix imx-ipuv3-crtc module autoloading")
> > indeed fixes the autoloading issue, but completely breaks the driver in
> > non-modular mode (at least with the parallel-display driver I didn't
> > yet check with the imx-ldb driver.
> > Can anyone confirm that the imx-drm driver in current linux-next
> > (next-20160512) works for them with any i.MX6 or i.MX53 board?
> 
> I have sent a patch: https://patchwork.kernel.org/patch/9081661/
> that I'd appreciate your input on.
> 
This patch works for the parallel-display driver but not for imx-ldb
(I didn't test the TV or HDMI drivers). It works when the DRM driver is
built as modules, but when it is non-modular I get a framebuffer
device which is useable from userspace, but no output on the LVDS
interface.

When reverting 503fe87bd0a8346ba9d8b7f49115dcd0a4185226 instead of
applying the above patch, the builtin driver works normally.


Lothar Wa?mann
