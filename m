From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Fri, 18 Nov 2016 14:42:08 +0800
Subject: [PATCH 1/3] arm: hisi: add ARCH_MULTI_V5 support
In-Reply-To: <114569cb-79ab-a46d-8582-6169f182a32c@hisilicon.com>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
 <20161017120705.3726-2-wenpan@hisilicon.com> <5893354.6MrIxqzRoI@wuerfel>
 <e78a288b-8bab-9441-2edb-6ec08e5103d7@hisilicon.com>
 <582C2785.2010804@hisilicon.com>
 <114569cb-79ab-a46d-8582-6169f182a32c@hisilicon.com>
Message-ID: <511e01ae-6083-13c8-a486-40e01bf753be@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marty,

On 2016/11/17 11:03, Jiancheng Xue wrote:
> Hi Wei?
> 
> On 2016/11/16 17:31, Wei Xu wrote:
>> Hi Pan,
>>
>> On 2016/11/16 8:56, wenpan wrote:
>>> Hi Marty?
>>> Does this confict with your patch? If not?I hope this could be merged first.  Besides could you tell me the link to your related patch?
>>
>> This is the link: https://patchwork.kernel.org/patch/9334743/
>>

Could you give your comments on this patch?
If you have any objections to it, please let us know.

> 
> Thank you for offering this.If I want to give some comments on Marty's patch,
> what should I do?
> 
> For Marty's patch, I think there's no need to add specific config item ARCH_HIxxxx
> for every chipset. Some existing chipsets depend on ARCH_HISI directly like Hi3519
> and Hi3798CV200. If some options like ARM_GIC is removed from ARCH_HISI, this kind
> of chipsets will must choose other place to select it. I suggest we should keep selecting
> ARM_GIC under ARCH_HISI as Pan's patch do.
> 
> The code may be like this:
> 
> config ARCH_HISI
>  	bool "Hisilicon SoC Support"
> -	depends on ARCH_MULTI_V7
> +	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
>  	select ARM_AMBA
> -	select ARM_GIC
> +	select ARM_GIC if ARCH_MULTI_V7
> +	select ARM_VIC if ARCH_MULTI_V5 || depends on ARCH_MULTI_V6
>  	select ARM_TIMER_SP804
>  	select POWER_RESET
>  	select POWER_RESET_HISI
>  	select POWER_SUPPLY
> 

What's your opinion about this?

Best Regards,
Jiancheng

>>> On 2016/10/17 21:48, Arnd Bergmann wrote:
>>>> On Monday, October 17, 2016 8:07:03 PM CEST Pan Wen wrote:
>>>>> Add support for some HiSilicon SoCs which depend on ARCH_MULTI_V5.
>>>>>
>>>>> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
>>>>>
>>>>
>>>> Looks ok. I've added Marty Plummer to Cc, he was recently proposing
>>>> patches for Hi3520, which I think is closely related to this one.
>>>> Please try to work together so the patches don't conflict. It should
>>>> be fairly straightforward since you are basically doing the same
>>>> change here.
>>>>
> 
> 
> 
> .
> 
