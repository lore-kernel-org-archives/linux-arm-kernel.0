From: vw@iommu.org (Wan Zongshun)
Date: Tue, 12 Jul 2016 12:30:48 +0800
Subject: [PATCH v2 01/10] ARM: NUC900: Add nuc970 machine support
In-Reply-To: <18260150.aRRy8ybKlm@wuerfel>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <1468135649-19980-2-git-send-email-vw@iommu.org>
 <18260150.aRRy8ybKlm@wuerfel>
Message-ID: <57847278.8000408@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016?07?12? 00:04, Arnd Bergmann wrote:
> On Sunday, July 10, 2016 3:27:21 PM CEST Wan Zongshun wrote:
>> +ifeq ($(CONFIG_SOC_NUC970),)
>>   obj-y                          := irq.o time.o mfp.o gpio.o clock.o
>>   obj-y                          += clksel.o dev.o cpu.o
>> +endif
>>   # W90X900 CPU support files
>
> When mfp.o is disabled like this, I get a link error in two drivers
> using the exported interface:
>
> ERROR: "mfp_set_groupg" [drivers/spi/spi-nuc900.ko] undefined!
> ERROR: "mfp_set_groupi" [drivers/input/keyboard/w90p910_keypad.ko] undefined!

Why remove mfp modules? this multifunction pin driver should be used for 
those two drivers, if no mfp_set_groupX, I don't think driver can work.

Now mfp has standard driver subsystem?

>
> Any idea for a better migration strategy?
>
> 	Arnd
>
>
