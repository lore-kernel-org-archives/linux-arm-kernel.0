From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 30 Aug 2016 09:55:33 +0100
Subject: Older hisilicon chipsets
In-Reply-To: <7850061.5OOjP34nIO@wuerfel>
References: <7773f0e5-d045-1e93-529b-74a601467ed1@gmail.com>
 <20160827150457.GM10637@io.lakedaemon.net>
 <ec3ec22f-f05e-aaec-8e9a-bfc0565b9e9d@gmail.com> <7850061.5OOjP34nIO@wuerfel>
Message-ID: <57C54A05.9090601@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Marty

On 29/08/2016 11:54, Arnd Bergmann wrote:
> On Saturday, August 27, 2016 1:53:25 PM CEST Marty Plummer wrote:
>> On 08/27/2016 10:04 AM, Jason Cooper wrote:
>>>
>>> Ah, yes.  The same device we were discussing on #mvlinux?
>>>
>> Indeed, the very same
>>>
>>> Note that I have no experience with HiSilicon. :-)  However, I think
>>> it's correct to add it mach-hisi/.   A quick grep shows that there is
>>> devicetree support for hisilicon SoCs (arch/arm/boot/dts/).  So that
>>> means there's a *lot* less code to add under mach-hisi/.
>>>
>> The issue here is that mach-hisi/Kconfig and CONFIG_ARCH_HISI require
>> ARMv7, whereas the hi3520 has an arm1176/arm926 core, thereby being
>> ARMv6/v5
> 
> No problem, just modify the dependency list for the top-level option.
> 
>>> Ideally, most of it will be a devicetree.  Assuming we have code for the
>>> SoC and associated drivers.
>>>
>> Yes, I've been doing some work on that already, but as I've said, unsure
>> where one should/would insert all these different things.
> 
> start with getting the serial console working. debug_ll is useful for
> early bringup and should only need a patch to arch/arm/Kconfig.debug.
> 
> Later you would typically use earlycon (using a stdout-path property
> in DT to point to the UART and configuration). The approximate order
> in which you need other drivers is:
> 
> * drivers/irqchip (often a standard VIC or GIC)
> * drivers/clocksource
> * drivers/tty/serial/
> * drivers/clk
> * drivers/pinctrl (or drivers/gpio for simpler I/O pins)
> * drivers/mmc
> * drivers/net/ethernet
> * drivers/spi/
> * drivers/i2c/
> * drivers/mtd/
> 
> In each case, look for a driver that works on your hardware first,
> or create one based on the old source if that doesn't exist upstream.
> 
>>> I've added GregKH to the Cc to see if he knows of anyone currently
>>> working with Hisilicon.
>>>
>> Thanks, mayhaps someone can get even a response from Hisilicon, as I've
>> yet to recieve even that.
> 
> I expect that Xu Wei will pick up the patches once they are ready to
> go in, but he probably won't have a lot of comments for your patches.

I will once they are ready.
Thanks for your kindly guiding!

Best Regards,
Wei

> 
> 	Arnd
> 
> .
> 
