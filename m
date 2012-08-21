From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Aug 2012 09:12:41 +0200
Subject: [PATCH 04/11] pinctrl: mvebu: add pinctrl driver for Armada 370
In-Reply-To: <20120820193622.4e539451@skate>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdYNZar7865-T12J37h3AWA9-8R1R5tymuOhaB0b3ddEAA@mail.gmail.com>
 <50326A60.1070007@gmail.com> <20120820193622.4e539451@skate>
Message-ID: <503334E9.508@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2012 07:36 PM, Thomas Petazzoni wrote:
> Le Mon, 20 Aug 2012 18:48:32 +0200,
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> a ?crit :
> 
>> this is really difficult here ;) I thought I could just add PINCTRL_DOVE
>> to MACH_DOVE inside ARCH_MVEBU, PINCTRL_KIRKWOOD to MACH_KIRKWOOD, aso.
>> But there is a common MACH_ARMADA_370_XP for both 370 and XP obviously.
>>
>> If it is ok for you I will add both PINCTRL_ stubs to the Kconfig and
>> you work it out if you ever have two distinct MACHs? Or it could remain
>> selectable in pinctrl/Kconfig but that will then be different with the
>> other stubs.
> 
> In order to keep the consistency with other SoC families, maybe we can
> split the 370 and XP options in two separate MACH_ARMADA_370 and
> MACH_ARMADA_XP. So, in the ideal world, once all Marvell EBU SoCs are
> converted to DT+mach-mvebu, we should have:
> 
>  *) arch/arm/Kconfig defines MACH_MVEBU
> 
>  *) arch/arm/mach-mvebu/Kconfig defines MACH_KIRKWOOD, MACH_DOVE,
>     MACH_MX78X00, MACH_ARMADA_370, MACH_ARMADA_XP, MACH_ORION5X
> 
> Then, an user is free to build a single kernel image that supports all,
> or a selection of the supported Marvell EBU SoCs.

I agree with Thomas

> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
