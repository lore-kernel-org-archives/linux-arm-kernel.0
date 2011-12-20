From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Dec 2011 08:24:12 +0000
Subject: [PATCH] arm: device.h: Add dma_mask to pdev_archdata structure
In-Reply-To: <4EF0359C.1090703@googlemail.com>
References: <1321415178-12179-1-git-send-email-festevam@gmail.com>
 <4EF0359C.1090703@googlemail.com>
Message-ID: <20111220082412.GP14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 08:13:32AM +0100, Dirk Behme wrote:
> On 16.11.2011 04:46, Fabio Estevam wrote:
>> Fix the following build error when doing a 'make mx3_defconfig'
>>
>> CC [M]  drivers/usb/host/fsl-mph-dr-of.o
>> drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
>> drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata' has no member named 'dma_mask'
>> make[3]: *** [drivers/usb/host/fsl-mph-dr-of.o] Error 1
>> make[2]: *** [drivers/usb/host] Error 2
>> make[1]: *** [drivers/usb] Error 2
>> make: *** [drivers] Error 2
>>
>> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>
>> ---
>>   arch/arm/include/asm/device.h |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
>> index 7aa3680..6ec60f6 100644
>> --- a/arch/arm/include/asm/device.h
>> +++ b/arch/arm/include/asm/device.h
>> @@ -21,6 +21,7 @@ struct pdev_archdata {
>>   #ifdef CONFIG_ARCH_OMAP
>>   	struct omap_device *od;
>>   #endif
>> +	u64 dma_mask;
>>   };
>>
>>   #endif
>
> Will there  be a v2 of this patch fixing the review comments?
>
> It seems the number of people hit by the issue this patch deals with  
> increases ...

How about fixing the driver?  Or how about fixing this problem properly
and sorting it out in the standard platform device model, rather than
asking every arch to add this to their platform device archdata?
