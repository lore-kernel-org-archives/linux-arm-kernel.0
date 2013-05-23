From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 23 May 2013 16:41:25 +0200
Subject: [PATCH v2 0/6] Support new Marvell bootloaders for Armada 370/XP
In-Reply-To: <1369315854-32724-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369315854-32724-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <519E2A95.1040600@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
On 05/23/2013 03:30 PM, Thomas Petazzoni wrote:

[...]

> Best regards,
> 
> Thomas
> 
> Thomas Petazzoni (6):
>   arm: mvebu: remove dependency of SMP init on static I/O mapping
>   arm: mvebu: avoid hardcoded virtual address in coherency code
>   arm: mvebu: move cache and mvebu-mbus initialization later
>   arm: mvebu: remove hardcoded static I/O mapping
>   arm: mvebu: don't hardcode a physical address in headsmp.S
>   arm: mvebu: support new bootloaders shipped by Marvell

I have already reviewed it internally. All the changes are really
limited to mvebu and do not impact any other subsystem. So you
have my acked-by, and once Jason Cooper will have given his Acked-by,
then I think we will be able to apply the series on mvebu/ branches.

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

> 
>  arch/arm/boot/dts/armada-370-xp.dtsi |    2 +-
>  arch/arm/boot/dts/armada-370.dtsi    |    3 +-
>  arch/arm/boot/dts/armada-xp-gp.dts   |    2 +-
>  arch/arm/include/debug/mvebu.S       |   77 +++++++++++++++++++--
>  arch/arm/mach-mvebu/armada-370-xp.c  |  124 +++++++++++++++++++++++++++++-----
>  arch/arm/mach-mvebu/armada-370-xp.h  |    4 +-
>  arch/arm/mach-mvebu/coherency.c      |   36 ++++------
>  arch/arm/mach-mvebu/coherency.h      |    4 --
>  arch/arm/mach-mvebu/common.h         |    2 +
>  arch/arm/mach-mvebu/headsmp.S        |   20 +++---
>  arch/arm/mach-mvebu/platsmp.c        |   10 ++-
>  11 files changed, 220 insertions(+), 64 deletions(-)
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
