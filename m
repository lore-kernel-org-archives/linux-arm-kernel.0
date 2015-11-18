From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 22:06:36 +0100
Subject: [PATCH] usb: musb: USB_TI_CPPI41_DMA requires dmaengine support
In-Reply-To: <CADYTM3bwZhLWyL_D+jFwQTDGHT3VBoQdxaPjaex7YZU=POLO+A@mail.gmail.com>
References: <4370741.70D0kgBgnp@wuerfel> <3958456.qUtBLJFy2S@wuerfel>
 <CADYTM3bwZhLWyL_D+jFwQTDGHT3VBoQdxaPjaex7YZU=POLO+A@mail.gmail.com>
Message-ID: <4749121.AD5OMAAsPq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 14:39:10 Bin Liu wrote:
> > Ideally we should remove the 'select TI_CPPI41' here as well, but
> > what we could do instead is to make that a silent symbol and remove
> > the prompt so it always gets enabled implicitly when USB_TI_CPPI41_DMA
> > and DMADEVICES are both enabled.
> 
> But what if DMADEVICES was disabled and USB_TI_CPPI41_DMA was enabled?
> I would think I had CPPI fully enabled for MUSB, but it didn't because
> TI_CPPI41 was disabled.

That would cause a runtime failure, just like any other configuration
that does not enable all the hardware you want to use.
 
> I would think this patch is the test option so far, we might have to
> document somewhere that to dmaengine has to be enabled to use MUSB
> CPPI, but I am not sure where the best place is to document...

There are hundreds of device drivers that use dmaengines as a
backend, we don't normally document this, just like we don't
document the fact that you need to enable the right gpio, irqchip,
timer, clock etc drivers for your platform.

	Arnd
