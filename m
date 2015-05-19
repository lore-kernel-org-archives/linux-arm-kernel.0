From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 19 May 2015 15:02:27 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Add Atmel SAMA5 family
In-Reply-To: <20150519123358.GA15179@piout.net>
References: <1428051678-20450-1-git-send-email-alexandre.belloni@free-electrons.com>
 <555AFF3F.10400@atmel.com> <9986808.t62JLgg5NJ@wuerfel>
 <20150519123358.GA15179@piout.net>
Message-ID: <555B3463.2060700@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/05/2015 14:33, Alexandre Belloni a ?crit :
> On 19/05/2015 at 13:04:22 +0200, Arnd Bergmann wrote :
>>>> @@ -250,15 +261,18 @@ CONFIG_SERIAL_FSL_LPUART=y
>>>>  CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>>>>  CONFIG_SERIAL_ST_ASC=y
>>>>  CONFIG_SERIAL_ST_ASC_CONSOLE=y
>>>> +CONFIG_HW_RANDOM=y
>>>>  CONFIG_I2C_CHARDEV=y
>>>>  CONFIG_I2C_DAVINCI=y
>>>>  CONFIG_I2C_MUX=y
>>
>> seems non-essential.
>>
> 
> That is an oversight, it should be compiled as a module.

Ok, I modify it: no need to bother sending a new revision.

>>>> @@ -502,6 +522,8 @@ CONFIG_RTC_DRV_MV=y
>>>>  CONFIG_RTC_DRV_TEGRA=y
>>>>  CONFIG_DMADEVICES=y
>>>>  CONFIG_DW_DMAC=y
>>>> +CONFIG_AT_HDMAC=y
>>>> +CONFIG_AT_XDMAC=y
>>>>  CONFIG_MV_XOR=y
>>>>  CONFIG_TEGRA20_APB_DMA=y
>>>>  CONFIG_SH_DMAE=y
>>
>> What are these required for? I assume you need them for MMC? If so, that's
>> fine.
>>
> 
> That is indeed the reason.

Yep.

So I simply do a s/y/m/ on the CONFIG_HW_RANDOM then included it in our
at91-4.2-defconfig branch.

Bye,
-- 
Nicolas Ferre
