From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Jan 2013 19:35:44 +0800
Subject: [PATCH 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
In-Reply-To: <20130111105651.GF11085@arwen.pp.htv.fi>
References: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
 <20130111105651.GF11085@arwen.pp.htv.fi>
Message-ID: <20130111113543.GA2080@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 12:56:51PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Jan 11, 2013 at 05:56:28PM +0800, Peter Chen wrote:
> > It changes the driver to use platform_device_id rather than cpu_is_xxx
> > to determine the SoC type, and updates the platform code accordingly.
> > 
> > Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> > Tested at mx51 bbg board, it works ok after enable phy clock
> > (Need another patch to fix this problem)
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> 
> this is too big for -rc, can you break it down into smaller pieces ?
> 
This is a patch missed from my series that enables multiplatform
support for IMX (because the driver is not enabled in defconfig,
sorry).  To me, it's logically one patch to convert the driver over
to use platform_device_id.  It does not make much sense to split it.

Shawn
