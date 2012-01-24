From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Jan 2012 10:25:10 +0200
Subject: [PATCH v2] usb: gadget: Fix build error due to selection of
 USB_FSL_MPH_DR_OF by ARCH_MXC
In-Reply-To: <1324553602-3411-1-git-send-email-fabio.estevam@freescale.com>
References: <1324492640-25481-1-git-send-email-fabio.estevam@freescale.com>
 <1324553602-3411-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120124082507.GG27414@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 09:33:22AM -0200, Fabio Estevam wrote:
> USB_FSL_MPH_DR_OF is a PowerPC driver and should not be selected by ARCH_MXC.
> 
> Doing a 'make mx3_defconfig' and selecting i.MX6 we get:
> 
> CC [M]  drivers/usb/host/fsl-mph-dr-of.o
> drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
> drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata' has no member named 'dma_mask'
> 
> Fix this error by not allowing USB_FSL_MPH_DR_OF to be selected by ARCH_MXC.

I would like to have these drivers compile on all archs, so I'm sorry
but this cannot be applied as is.

All of these stupid arch dependencies should vanish. Please fix this in
another way.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120124/e48c8517/attachment.sig>
