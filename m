From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed, 26 Oct 2016 14:39:47 +0200
Subject: [PATCH v2] ARM: davinci: da8xx: Fix some redefined symbol warnings
In-Reply-To: <3dc1c2c2-c4c5-07d0-3d3e-b8d917adda81@ti.com>
References: <1477397492-7925-1-git-send-email-abailon@baylibre.com>
 <1477397492-7925-2-git-send-email-abailon@baylibre.com>
 <3dc1c2c2-c4c5-07d0-3d3e-b8d917adda81@ti.com>
Message-ID: <e8963754-4bea-631b-82c5-555c521fd873@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2016 01:57 PM, Sekhar Nori wrote:
> On Tuesday 25 October 2016 05:41 PM, Alexandre Bailon wrote:
>> Some macro for DA8xx CFGCHIP are defined in usb-davinci.h,
>> but da8xx-cfgchip.h intend to replace them.
>> The usb-da8xx.c is using both headers, causing redefined symbol warnings.
>> Remove the macro and update the da830-evm board file to use da8xx-cfgchip.h
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> 
> This leads to build error on v4.9-rc2:
Oops! Sorry for that. I will  fit it.
> 
> arch/arm/mach-davinci/board-da830-evm.c: In function 'da830_evm_usb_init':
> arch/arm/mach-davinci/board-da830-evm.c:120:15: error: 'CFGCHIP2_REFFREQ' undeclared (first use in this function)
>   cfgchip2 &= ~CFGCHIP2_REFFREQ;
> 
> Thanks,
> Sekhar
> 
