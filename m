From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 12 Dec 2011 11:25:11 +0000
Subject: [PATCH v4 0/5] ARM: davinci: re-arrange definitions to have a
 common	davinci header
In-Reply-To: <1323352528-1207-1-git-send-email-manjunath.hadli@ti.com>
References: <1323352528-1207-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6043FD6@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On Thu, Dec 08, 2011 at 19:25:23, Hadli, Manjunath wrote:
> Re-arrange definitions and remove unnecessary code so that we can
> have a common header for all davinci platforms. This will enable
> us to share defines and enable common routines to be used without
> polluting hardware.h.
>  This patch set forms the base for a later set of patches for having
> a common system module base address (DAVINCI_SYSTEM_MODULE_BASE).

Its easy to dismiss this series as causing "needless churn" by
moving around definitions from header to C files and consolidating
definitions from multiple header files to one.

You need to do a better job of "selling" this series. The best way
to do that would be to include future patches which benefit from
this series into this series itself. This way, its clear to judge
the relative benefit of the "churn". You gave some examples, but
showing code helps.

Also, one of the biggest gains from this series is reducing the
pollution in include/mach as asked by Russell in his "pet peaves"
mail. That should find reference in the cover letter and in the
commit text of patch 5/5.

Thanks,
Sekhar

> 
> Changes from previous version:
> 1. Addressed Shekhar's comments for non-inclusion of mach headers from core.
> 2. Move the mach header from include to mach
> 
> Manjunath Hadli (5):
>   davinci: vpif: remove obsolete header file inclusion
>   ARM: davinci: dm644x: remove the macros from the header to move to c
>     file
>   ARM: davinci: dm365: remove the macros from the header to move to c
>     file
>   ARM: davinci: dm646x: remove the macros from the header to move to c
>     file
>   ARM: davinci: create new common platform header for davinci
> 
>  arch/arm/mach-davinci/board-dm355-evm.c     |    2 +-
>  arch/arm/mach-davinci/board-dm355-leopard.c |    2 +-
>  arch/arm/mach-davinci/board-dm365-evm.c     |    2 +-
>  arch/arm/mach-davinci/board-dm644x-evm.c    |    2 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c    |    2 +-
>  arch/arm/mach-davinci/board-neuros-osd2.c   |    2 +-
>  arch/arm/mach-davinci/board-sffsdr.c        |    2 +-
>  arch/arm/mach-davinci/davinci.h             |   88 +++++++++++++++++++++++++++
>  arch/arm/mach-davinci/dm355.c               |    2 +-
>  arch/arm/mach-davinci/dm365.c               |   18 +++++-
>  arch/arm/mach-davinci/dm644x.c              |    9 +++-
>  arch/arm/mach-davinci/dm646x.c              |    9 +++-
>  arch/arm/mach-davinci/include/mach/dm355.h  |   32 ----------
>  arch/arm/mach-davinci/include/mach/dm365.h  |   52 ----------------
>  arch/arm/mach-davinci/include/mach/dm644x.h |   47 --------------
>  arch/arm/mach-davinci/include/mach/dm646x.h |   41 ------------
>  drivers/media/video/davinci/vpif.h          |    2 +-
>  drivers/media/video/davinci/vpif_display.c  |    2 -
>  18 files changed, 130 insertions(+), 186 deletions(-)
>  create mode 100644 arch/arm/mach-davinci/davinci.h
>  delete mode 100644 arch/arm/mach-davinci/include/mach/dm355.h
>  delete mode 100644 arch/arm/mach-davinci/include/mach/dm365.h
>  delete mode 100644 arch/arm/mach-davinci/include/mach/dm644x.h
>  delete mode 100644 arch/arm/mach-davinci/include/mach/dm646x.h
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
