From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 30 Nov 2011 11:37:21 +0000
Subject: [PATCH v3 0/5] ARM: davinci: re-arrange definitions to have a
 common	davinci header
In-Reply-To: <1321525138-3928-1-git-send-email-manjunath.hadli@ti.com>
References: <1321525138-3928-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B60354BC@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On Thu, Nov 17, 2011 at 15:48:53, Hadli, Manjunath wrote:
> Re-arrange definitions and remove unnecessary code so that we canx

These are two different things and should be done in separate
patches. Sergei has already pointed out couple of instances.

> have a common header for all davinci platforms. This will enable

You mean all DMx platforms? DA8x and TNETVx will still have
their own header files after this patch set.

> us to share defines and enable common routines to be used without
> polluting hardware.h.
>  This patch set forms the base for a later set of patches for having
> a common system module base address (DAVINCI_SYSTEM_MODULE_BASE).
> 
> Changes from previous version(As per Sergei's comments):
> 1. Renamed davinci_common.h to davinci.h.
> 2. Added extra line whereever appropriate.
> 3. removed unnecessary header inclusion.
> 
> Manjunath Hadli (5):
>   ARM: davinci: dm644x: remove the macros from the header to move to c
>     file
>   ARM: davinci: dm365: remove the macros from the header to move to c
>     file
>   ARM: davinci: dm646x: remove the macros from the header to move to c
>     file

These headlines should describe the changes better. You are moving
_private_ defines to C file (to reduce header file pollution). That
should be clear from the headline.

>   ARM: davinci: create new common platform header for davinci
>   ARM: davinci: delete individual platform header files and use a
>     common header
> 
>  arch/arm/mach-davinci/board-dm355-evm.c      |    2 +-
>  arch/arm/mach-davinci/board-dm355-leopard.c  |    2 +-
>  arch/arm/mach-davinci/board-dm365-evm.c      |    2 +-
>  arch/arm/mach-davinci/board-dm644x-evm.c     |    2 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c     |    2 +-
>  arch/arm/mach-davinci/board-neuros-osd2.c    |    2 +-
>  arch/arm/mach-davinci/board-sffsdr.c         |    2 +-
>  arch/arm/mach-davinci/dm355.c                |    2 +-
>  arch/arm/mach-davinci/dm365.c                |   18 +++++-
>  arch/arm/mach-davinci/dm644x.c               |    9 +++-
>  arch/arm/mach-davinci/dm646x.c               |    9 +++-
>  arch/arm/mach-davinci/include/mach/davinci.h |   88 ++++++++++++++++++++++++++

This file should be placed in arch/arm/mach-davinci itself
since the definitions are private to arch/arm/mach-davinci.
Russell has been complaining about placing unnecessary files
in include/mach.

Thanks,
Sekhar
