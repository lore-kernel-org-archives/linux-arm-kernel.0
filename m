From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Jan 2013 09:48:58 +0200
Subject: [PATCH v2 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
In-Reply-To: <1358147897-8599-1-git-send-email-peter.chen@freescale.com>
References: <1358147897-8599-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130114074858.GA10176@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 14, 2013 at 03:18:17PM +0800, Peter Chen wrote:
> It changes the driver to use platform_device_id rather than cpu_is_xxx
> to determine the SoC type, and updates the platform code accordingly.
> 
> Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> Tested at mx51 bbg board, it works ok after enable phy clock
> (Need another patch to fix this problem)
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

not good for -rc. You have to break this down as you're solving at least
three different problems with this patch.

Besides there are parts which are not related to the build break.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130114/abb4c364/attachment-0001.sig>
