From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 May 2014 09:38:03 -0600
Subject: [PATCH v6 1/3] ARM: kconfig: allow PCI support to be selected
 with ARCH_MULTIPLATFORM
In-Reply-To: <20140508151526.GE8981@arm.com>
References: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
 <1399478839-3564-2-git-send-email-will.deacon@arm.com>
 <536B9DE9.80100@wwwdotorg.org> <20140508151526.GE8981@arm.com>
Message-ID: <536BA4DB.6070102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2014 09:15 AM, Will Deacon wrote:
> On Thu, May 08, 2014 at 04:08:25PM +0100, Stephen Warren wrote:
>> On 05/07/2014 10:07 AM, Will Deacon wrote:
>>> When targetting ARCH_MULTIPLATFORM, we may include support for SoCs with
>>> PCI-capable devices (e.g. mach-virt with virtio-pci).
>>>
>>> This patch allows PCI support to be selected for these SoCs by selecting
>>> CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_MULTIPLATFORM=y.
>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>
>>> @@ -314,6 +314,7 @@ config ARCH_MULTIPLATFORM
>>>  	select CLKSRC_OF
>>>  	select COMMON_CLK
>>>  	select GENERIC_CLOCKEVENTS
>>> +	select MIGHT_HAVE_PCI
>>
>> Doesn't ARCH_MULTIPLATFORM allow ARCH_$soc to be selected, and ARCH_$soc
>> selects MIGHT_HAVE_PCI?
>>
>> That way, you can only enable PCI support if you have actually enabled
>> an SoC that has PCI, and equally ARCH_$soc selects MIGHT_HAVE_PCI just
>> like it always used to work before ARCH_MULTIPLATFORM.
> 
> Yeah, I initially had this only for mach-virt, but the last review suggested
> moving it here:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/252937.html

Hmm. OK. I guess we should remove the select from the individual
ARCH_$soc then too?
