From: robherring2@gmail.com (Rob Herring)
Date: Wed, 16 Nov 2011 07:19:00 -0600
Subject: [PATCH] arm: device.h: Add dma_mask to pdev_archdata structure
In-Reply-To: <20111116082926.GE9581@n2100.arm.linux.org.uk>
References: <1321415178-12179-1-git-send-email-festevam@gmail.com>
 <20111116082926.GE9581@n2100.arm.linux.org.uk>
Message-ID: <4EC3B844.3060402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2011 02:29 AM, Russell King - ARM Linux wrote:
> On Wed, Nov 16, 2011 at 01:46:18AM -0200, Fabio Estevam wrote:
>> Fix the following build error when doing a 'make mx3_defconfig'
>>
>> CC [M]  drivers/usb/host/fsl-mph-dr-of.o
>> drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
>> drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata' has no member named 'dma_mask'
>> make[3]: *** [drivers/usb/host/fsl-mph-dr-of.o] Error 1
>> make[2]: *** [drivers/usb/host] Error 2
>> make[1]: *** [drivers/usb] Error 2
>> make: *** [drivers] Error 2
> 
> Why is this required for just MX3?  Why should we take the hit of adding
> this (needlessly) for the other sub-architectures?  Why is MX3 doing this
> differently?

This or some way to populate a dma_mask value is needed for devicetree
based probing.

That being said, fsl-mph-dr-of.c directly accessing struct pdev_archdata
is not right either.

Rob
