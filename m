From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Aug 2012 19:50:06 +0000
Subject: [PATCH 1/4] ARM: clps711x: Remove board support for CEIVA
In-Reply-To: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
References: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
Message-ID: <201208211950.07166.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 August 2012, Alexander Shiyan wrote:
> The current kernel does not fit in the CEIVA ROM. Also, some functional
> has already been removed due migrate from 2.6 to 3.0, and it seems that
> no one uses this platform. So, remove support for this board and modules
> specific only to this board.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

I got curious about this machine and found some ten year old emails
and a howto from Colin Cross about this machine. Since he's still
actively working on ARM Linux, maybe he has some final words to say
about this platform before it gets removed.

Otherwise, no objections.

	Arnd

>  arch/arm/mach-clps711x/Kconfig                 |    6 -
>  arch/arm/mach-clps711x/Makefile                |    1 -
>  arch/arm/mach-clps711x/ceiva.c                 |   64 --
>  arch/arm/mach-clps711x/include/mach/hardware.h |   48 --
>  arch/arm/tools/mach-types                      |    1 -
>  drivers/video/Kconfig                          |   12 -
>  drivers/video/Makefile                         |    1 -
>  drivers/video/epson1355fb.c                    |  749 ------------------------
>  include/video/epson1355.h                      |   64 --
>  9 files changed, 0 insertions(+), 946 deletions(-)
>  delete mode 100644 arch/arm/mach-clps711x/ceiva.c
>  delete mode 100644 drivers/video/epson1355fb.c
>  delete mode 100644 include/video/epson1355.h
