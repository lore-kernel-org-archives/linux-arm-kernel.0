From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 17 Apr 2014 15:24:12 +0200
Subject: [PATCH RESEND 3/5] ARM: berlin: add the pinctrl dependency for
 the Marvell Berlin SoCs
In-Reply-To: <20140417131357.GA31034@kwain>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-4-git-send-email-antoine.tenart@free-electrons.com>
 <5347B065.8060001@gmail.com> <20140417131357.GA31034@kwain>
Message-ID: <534FD5FC.6060703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 03:13 PM, Antoine T?nart wrote:
> On Fri, Apr 11, 2014 at 11:05:41AM +0200, Sebastian Hesselbarth wrote:
>> On 04/10/2014 03:07 PM, Antoine T?nart wrote:
>>> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
>>> ---
>>>   arch/arm/mach-berlin/Kconfig | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
>>> index d3c5f14dc142..291f1cac6c3d 100644
>>> --- a/arch/arm/mach-berlin/Kconfig
>>> +++ b/arch/arm/mach-berlin/Kconfig
>>> @@ -4,6 +4,8 @@ config ARCH_BERLIN
>>>   	select GENERIC_IRQ_CHIP
>>>   	select DW_APB_ICTL
>>>   	select DW_APB_TIMER_OF
>>> +	select PINCTRL
>>> +	select PINCTRL_BERLIN
>>
>> As said in the review of the previous patch, drop PINCTRL here
>> and select it in the PINCTRL_BERLIN Kconfig. Also, you'll need
>> PINCTRL_BERLIN_BG2 and PINCTRL_BERLIN_BG2Q as we don't want to
>> bloat each Berlin kernel with both drivers.
>
> Regarding PINCTRL, I can't drop it, pin-controller drivers depend on it.
> drivers/pinctrl/Kconfig begins with:
> 	if PINCTRL

Ah, ok. Then select PINCTRL here and the corresponding
PINCTRL_BERLIN_foo in the individual SoC Kconfig entries.

Sebastian
