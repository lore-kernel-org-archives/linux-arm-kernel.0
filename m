From: robherring2@gmail.com (Rob Herring)
Date: Fri, 07 Sep 2012 07:51:20 -0500
Subject: [PATCH 07/12] ARM: move all dtb targets out of Makefile.boot
In-Reply-To: <20120907051917.GD10582@lunn.ch>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-8-git-send-email-robherring2@gmail.com>
 <20120907022711.GE26709@S2101-09.ap.freescale.net>
 <50495DB9.5030008@wwwdotorg.org> <20120907051917.GD10582@lunn.ch>
Message-ID: <5049EDC8.1040406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2012 12:19 AM, Andrew Lunn wrote:
>>> PS. A little heads-up: if this lands on 3.7, there will be conflict
>>> on arch/arm/mach-mxs/Makefile.boot which gets new entries in this
>>> cycle.
>>
>> The same is true of Tegra:
>>
>> -dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu.dtb
>> +dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu-a02.dtb
>> +dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu-a04.dtb
> 
> Ditto kirkwood and mvebu. And Dove might also gain DT support,
> resulting in new entries in its Makefile.boot.

It's basically scripted plus fix-up multi-line entries. We could do this
at the end of the merge window. I don't think "make dtbs" for
multi-platform enabled platforms being bisectable is too important.

Rob
