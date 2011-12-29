From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 29 Dec 2011 21:26:24 -0200
Subject: [PATCH v2] usb: gadget: Fix build error due to selection of
 USB_FSL_MPH_DR_OF by ARCH_MXC
In-Reply-To: <1324553602-3411-1-git-send-email-fabio.estevam@freescale.com>
References: <1324492640-25481-1-git-send-email-fabio.estevam@freescale.com>
 <1324553602-3411-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAOMZO5CdBupw2A+4gaDBo-mh=MqimaecTWLUO7PcvAqaDrKihA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Thu, Dec 22, 2011 at 9:33 AM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> USB_FSL_MPH_DR_OF is a PowerPC driver and should not be selected by ARCH_MXC.
>
> Doing a 'make mx3_defconfig' and selecting i.MX6 we get:
>
> CC [M] ?drivers/usb/host/fsl-mph-dr-of.o
> drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
> drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata' has no member named 'dma_mask'
>
> Fix this error by not allowing USB_FSL_MPH_DR_OF to be selected by ARCH_MXC.
>
> Cc: stable at kernel.org
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Does this patch look good?

Regards,

Fabio Estevam
