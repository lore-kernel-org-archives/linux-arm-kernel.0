From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Mar 2012 20:09:47 +0000
Subject: [GIT PULL] [for v3.4] Pull request containing ux500 DT enablement
In-Reply-To: <4F62220D.1090106@linaro.org>
References: <4F62220D.1090106@linaro.org>
Message-ID: <201203162009.48239.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Lee Jones wrote:
> The following changes since commit fff9a13341312c8d0f06e04c1345e855528b03da:
> 
>   ARM: ux500: CONFIG: Enable Device Tree support for future endeavours (2012-03-15 16:33:54 +0000)
> 
> are available in the git repository at:
>   git://git.linaro.org/people/ljones/linux-3.0-ux500.git device-tree-snowball-ux500
> 
> Arnd Bergmann (3):
>       ARM: ux500: Initial Device Tree support for Snowball
>       ARM: ux500: combine the board init functions for DT boot
>       ARM: ux500: split dts file for snowball into generic part
> 
> Lee Jones (5):
>       ARM: ux500: db8500: list most devices in the snowball device tree
>       ARM: ux500: Enable Cortex-A9 GIC (Generic Interrupt Controller) in Device Tree
>       ARM: ux500: Enable PL011 AMBA UART Controller for Device Tree
>       ARM: ux500: Enable PL310 Level 2 Cache Controller in Device Tree
>       ARM: ux500: Enable PL022 SSP Controller in Device Tree

I've pulled this into next/dt2, not next/dt for now. I had to rebase the patches
as we discussed and then did some build tests to make sure nothing broke. I found
one bug with your patches and CONFIG_OF disabled, which I fixed in the patch itself,
and found some build warnings that you should take a look at in the for-next
branch. Also the patch "CONFIG: Enable Device Tree support for future endeavours"
seems essential for the entire series, so I applied it as well, along with 
your localtime patch.

I still think we can make it for v3.4, but I'll let this sit in linux-next for a
few days longer than the other pull requests and if we find more problems it's out
and gets postponed till v3.5.

	Arnd
