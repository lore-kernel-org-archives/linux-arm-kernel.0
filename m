From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Apr 2015 12:21:22 +0200
Subject: [PATCH] ARM: mvebu: Fix the main PLL frequency on Armada 375,
 38x and 39x SoCs
In-Reply-To: <20150420172956.GZ15807@lukather>
References: <1429538373-31064-1-git-send-email-gregory.clement@free-electrons.com>
 <20150420172956.GZ15807@lukather>
Message-ID: <553624A2.5090504@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 20/04/2015 19:29, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Apr 20, 2015 at 03:59:33PM +0200, Gregory CLEMENT wrote:
>> Whereas for Armada 370 and XP the main PLL frequency was 2GHz for the
>> Armada 375, 38x and 39x, the frequency is 1GHz. When writting support
>                                                        ^ writing
> 
>> for these last SoCs, there was no offical value for the PLL. Now that
                                     ^ official

>> we have it, this patch fixes it in the device tree.
>>
>> This value is currently only used by the NAND driver for the setting
>> the NAND timing. Fortunately it is not acutally used: all the mainline
>                                          ^ actually
> 
>> board with a NAND flash comes with a NAND device tree node using the
> 
>   ^ boards                ^ come 
> 
>> "marvell,nand-keep-config" property. With this property the timings
>> are not modified in the kernel driver and are kept from the botloader.
>                                                               ^ bootloader

It seemed that my flyspell mode was not activated, thanks for your spell check.
I will send a new patch in a few day, waiting for other review.


Thanks,

Gregory


> 
> Maxime
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
