From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Nov 2011 11:26:49 +0100
Subject: [PATCH] arm: device.h: Add dma_mask to pdev_archdata structure
In-Reply-To: <20111116082926.GE9581@n2100.arm.linux.org.uk>
References: <1321415178-12179-1-git-send-email-festevam@gmail.com>
 <20111116082926.GE9581@n2100.arm.linux.org.uk>
Message-ID: <20111116102649.GQ30612@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 08:29:26AM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 16, 2011 at 01:46:18AM -0200, Fabio Estevam wrote:
> > Fix the following build error when doing a 'make mx3_defconfig'
> > 
> > CC [M]  drivers/usb/host/fsl-mph-dr-of.o
> > drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
> > drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata' has no member named 'dma_mask'
> > make[3]: *** [drivers/usb/host/fsl-mph-dr-of.o] Error 1
> > make[2]: *** [drivers/usb/host] Error 2
> > make[1]: *** [drivers/usb] Error 2
> > make: *** [drivers] Error 2
> 
> Why is this required for just MX3?  Why should we take the hit of adding
> this (needlessly) for the other sub-architectures?  Why is MX3 doing this
> differently?
fsl-mph-dr-of.c is a driver that works on ARM and POWERPC. The latter
has dma_mask in pdev_archdata and fsl-mph-dr-of.c uses it to hold the
value pointed to by pdev->dev.dma_mask. AFAIK a driver should consider
pdev->dev.dma_mask readonly, shouldn't it?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
