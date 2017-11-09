From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Nov 2017 13:47:13 +0000
Subject: next/master boot: 264 boots: 62 failed, 199 passed with 3
 conflicts (next-20171109)
In-Reply-To: <20171109134502.wyxxcstplybe4ed4@sirena.co.uk>
References: <5a0446a2.85a8500a.55819.1c58@mx.google.com>
 <20171109134502.wyxxcstplybe4ed4@sirena.co.uk>
Message-ID: <20171109134713.fjw7wlflu4dj45xm@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 01:45:02PM +0000, Mark Brown wrote:
> On Thu, Nov 09, 2017 at 04:14:26AM -0800, kernelci.org bot wrote:
> 
> Today's -next fails to boot a bcm2836-rpi-2-b on any config in kernelci,
> it was working yesterday:
> 
> >     bcm2835_defconfig:
> >         bcm2836-rpi-2-b:
> >             lab-collabora: new failure (last pass: next-20171107)
> 
> The boot log looks like something went badly wrong with USB:
> 
> [    1.643488] dwc2 3f980000.usb: DWC OTG Controller
> [    1.648225] dwc2 3f980000.usb: new USB bus registered, assigned bus number 1
> [    1.655328] dwc2 3f980000.usb: irq 39, io mem 0x3f980000
> [    1.661495] hub 1-0:1.0: USB hub found
> [    1.665301] hub 1-0:1.0: 1 port detected
> [    1.669239] hub 1-0:1.0: config failed, can't get hub status (err 2)
> [    1.676763] hub 1-0:1.0: activate --> -22
> [    1.680806] hub 1-0:1.0: activate --> -22
> [    1.684855] hub 1-0:1.0: activate --> -22
> 
> and so on until the tester gets bored.  There's nothing obvious changed
> in arch/arm or drivers/usb though.
> 
> More info and full log here:
> 
>    https://kernelci.org/boot/id/5a04231159b514cb291cdd1a/

There's similar issues reported for Odroid c1 with the same DesignWare
controller so it's unlikely to be something Raspberry Pi related:

    https://kernelci.org/boot/id/5a0416c059b514c4931cdd1b/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171109/a386f5ca/attachment.sig>
