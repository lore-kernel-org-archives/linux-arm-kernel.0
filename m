From: balbi@ti.com (Felipe Balbi)
Date: Fri, 30 Dec 2011 12:32:10 +0200
Subject: [PATCH v2] usb: gadget: Fix build error due to selection of
 USB_FSL_MPH_DR_OF by ARCH_MXC
In-Reply-To: <CAOMZO5CdBupw2A+4gaDBo-mh=MqimaecTWLUO7PcvAqaDrKihA@mail.gmail.com>
References: <1324492640-25481-1-git-send-email-fabio.estevam@freescale.com>
 <1324553602-3411-1-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5CdBupw2A+4gaDBo-mh=MqimaecTWLUO7PcvAqaDrKihA@mail.gmail.com>
Message-ID: <20111230103209.GA27099@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 09:26:24PM -0200, Fabio Estevam wrote:
> Hi Felipe,
> 
> On Thu, Dec 22, 2011 at 9:33 AM, Fabio Estevam
> <fabio.estevam@freescale.com> wrote:
> > USB_FSL_MPH_DR_OF is a PowerPC driver and should not be selected by ARCH_MXC.
> >
> > Doing a 'make mx3_defconfig' and selecting i.MX6 we get:
> >
> > CC [M] ?drivers/usb/host/fsl-mph-dr-of.o
> > drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
> > drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata' has no member named 'dma_mask'
> >
> > Fix this error by not allowing USB_FSL_MPH_DR_OF to be selected by ARCH_MXC.
> >
> > Cc: stable at kernel.org
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Does this patch look good?

I'm not looking into patches until Jan 2nd. Sorry. Focussing on some
internal stuff during the merge window. Hang on for a little while and I
will soon get back to apply patches.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111230/53e4cf90/attachment.sig>
