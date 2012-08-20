From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 20 Aug 2012 18:48:32 +0200
Subject: [PATCH 04/11] pinctrl: mvebu: add pinctrl driver for Armada 370
In-Reply-To: <CACRpkdYNZar7865-T12J37h3AWA9-8R1R5tymuOhaB0b3ddEAA@mail.gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdYNZar7865-T12J37h3AWA9-8R1R5tymuOhaB0b3ddEAA@mail.gmail.com>
Message-ID: <50326A60.1070007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2012 04:25 PM, Linus Walleij wrote:
>> +config PINCTRL_ARMADA_370
>> +       bool "Support for Marvell Armada 370 SoCs"
>> +       depends on PINCTRL_MVEBU
>> +       depends on MACH_ARMADA_370_XP
>
> select PINCTRL_MVEBU simply?
>
> And then have the Armada Kconfig
>
> select PINCTRL
> select PINCTRL_ARMADA_370

Linus, Thomas, Gregory,

this is really difficult here ;) I thought I could just add PINCTRL_DOVE
to MACH_DOVE inside ARCH_MVEBU, PINCTRL_KIRKWOOD to MACH_KIRKWOOD, aso.
But there is a common MACH_ARMADA_370_XP for both 370 and XP obviously.

If it is ok for you I will add both PINCTRL_ stubs to the Kconfig and
you work it out if you ever have two distinct MACHs? Or it could remain
selectable in pinctrl/Kconfig but that will then be different with the
other stubs.

Sebastian
