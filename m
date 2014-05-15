From: george.cherian@ti.com (George Cherian)
Date: Thu, 15 May 2014 11:38:36 +0530
Subject: [RFC PATCH] ARM: dts: am33xx: Re-arrange the USB dt to reflect
 the h/w configuration
In-Reply-To: <20140514215034.GL27426@atomide.com>
References: <1399617068-19826-1-git-send-email-george.cherian@ti.com>
 <20140514215034.GL27426@atomide.com>
Message-ID: <537459E4.5060203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,
On 5/15/2014 3:20 AM, Tony Lindgren wrote:
> * George Cherian <george.cherian@ti.com> [140508 23:34]:
>> Re arrange the USB dt for AM33xx to take it a bit closer
>> to the hardware configuration.
>>
>> The USBSS is designed as follows
>>
>> USB control Module	0x44e10_0620
>>
>> USBSS			0x4740_0000
>>
>> USB0			0x4740_1000
>> USB0_PHY		0x4740_1300
>> USB0_CORE		0x4740_1400
>>
>> USB1			0x4740_1800
>> USB1_PHY		0x4740_1b00
>> USB1_CORE		0x4740_1c00
>>
>> CPPI DMA Controller	0x4740_2000
>> CPPI DMA Scheduler	0x4740_3000
>> Queue Manager		0x4740_4000
>>
>> So model the DT as follows
>> USBSS {
>>      usb_ctrl_mod: {
>>          0x44e10_0620
>>      }
>>      usb0: {
>>      0x4740_1000
>>      0x4740_1400
>>      }
>>      usb0_phy:{
>>      0x4740_1300
>>      }
>>      usb1:{
>>      0x4740_1800
>>      0x4740_1c00
>>      }
>>      usb1_phy: {
>>      0x4740_1b00
>>      }
>>      cppi41dma: {
>>      0x4740_2000
>>      0x4740_3000
>>      0x4740_4000
>>      }
>> }
> Is this just a cosmetic change or is this trying to workaround
> some edma related init order issue?
Please ignore this patch. Was trying to workaround some dma and phy 
related issues.
The same got fixed with following

http://www.spinics.net/lists/linux-usb/msg107244.html


>
> Regards,
>
> Tony


-- 
-George
