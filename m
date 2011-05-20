From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 20 May 2011 19:35:23 +0400
Subject: [PATCH 4/4] davinci: create new common platform header for davinci
In-Reply-To: <1305900841-4020-1-git-send-email-manjunath.hadli@ti.com>
References: <1305900841-4020-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4DD68A3B.7040800@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Manjunath Hadli wrote:

> remove the code from individual platform header files for
> dm365, dm355, dm644x and dm646x and consolidate it into a
> single and common header file dmx.h.
> Include the new header file in individual platform header
> files as a pre-cursor for deleting these headers in follow
> up patches.

> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> ---
>  arch/arm/mach-davinci/board-dm355-evm.c     |    2 +-
>  arch/arm/mach-davinci/board-dm355-leopard.c |    2 +-
>  arch/arm/mach-davinci/board-dm365-evm.c     |    6 ++-
>  arch/arm/mach-davinci/board-dm644x-evm.c    |    2 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c    |    5 ++-
>  arch/arm/mach-davinci/board-neuros-osd2.c   |    2 +-
>  arch/arm/mach-davinci/board-sffsdr.c        |    2 +-
>  arch/arm/mach-davinci/dm355.c               |    2 +-
>  arch/arm/mach-davinci/dm365.c               |    2 +-
>  arch/arm/mach-davinci/dm644x.c              |    2 +-
>  arch/arm/mach-davinci/dm646x.c              |    2 +-
>  arch/arm/mach-davinci/include/mach/dm355.h  |   32 -----------
>  arch/arm/mach-davinci/include/mach/dm365.h  |   40 --------------
>  arch/arm/mach-davinci/include/mach/dm644x.h |   40 --------------
>  arch/arm/mach-davinci/include/mach/dmx.h    |   77 +++++++++++++++++++++++++++
>  drivers/media/video/davinci/vpif.h          |    2 +-
>  drivers/media/video/davinci/vpif_capture.h  |    1 +
>  drivers/media/video/davinci/vpif_display.c  |    2 +-
>  18 files changed, 98 insertions(+), 125 deletions(-)
>  delete mode 100644 arch/arm/mach-davinci/include/mach/dm355.h
>  delete mode 100644 arch/arm/mach-davinci/include/mach/dm365.h
>  delete mode 100644 arch/arm/mach-davinci/include/mach/dm644x.h
>  create mode 100644 arch/arm/mach-davinci/include/mach/dmx.h

    BTW, you forgot to remove <mach/dm646x.h>...

WBR, Sergei
