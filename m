From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 26 Apr 2016 09:17:14 +0100
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <55296515.n2D97kIgVc@wuerfel>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <20160423065431.GA5840@afzalpc> <571DCD8D.8070605@arm.com>
 <55296515.n2D97kIgVc@wuerfel>
Message-ID: <571F240A.9030404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/16 13:59, Arnd Bergmann wrote:
> On Monday 25 April 2016 08:55:57 Vladimir Murzin wrote:
>> On 23/04/16 07:54, Afzal Mohammed wrote:
>>> Hi,
>>>
>>> On Fri, Apr 22, 2016 at 12:43:33PM +0100, Vladimir Murzin wrote:
>>>
>>>> Small set of fixes discovered with R-class cores.
>>>
>>> just curious, is Cortex-R supported on mainline ?, thought it was not
>>> supported, but subject & changelogs gave such a feeling.
>>
>> Hi,
>>
>> I believe it is supported since c90ad5c "ARM: add Cortex-R7 Processor
>> Info" although overtime it got blocked (at least for Vexpress) with
>> Kconfig changes. There was attempt [1] to sort it out, but looks like
>> these patches went nowhere, so I'm trying to re-start with the fixes
>> coming first.
>>
>> [1]
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/174256.html
> 
> Good to know, thanks for working on this!

Since you are in a thread, just want to confirm if the following is
still the right (only?) way how we want to support R-class?

-----8<-------
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f066e..ead2b25 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -289,8 +289,7 @@ choice

  config ARCH_MULTIPLATFORM
         bool "Allow multiple platforms to be selected"
-       depends on MMU
-       select ARM_PATCH_PHYS_VIRT
+       select ARM_PATCH_PHYS_VIRT if MMU
         select AUTO_ZRELADDR
         select COMMON_CLK
         select MULTI_IRQ_HANDLER
----->8--------

I have separate Kconfig entry to represent R-class Vexpress platform
locally, but I guess it is noway, right? ;)

> 
> What hardware platform do you use? It would be nice to make it a little
> more explicit which platforms can use the ARMv7-R, or an ARMv7-A with
> the MMU disabled.

Currently I'm dealing mostly with ARMv7-R FVP models which represents
Vexpress with R-class tile (it is why this mini series have MPU
patches). I've never tried ARMv7-A with the MMU disabled and I'm quite
in doubt if it is feasible.

Cheers
Vladimir

> 
> 	Arnd
> 
> 
