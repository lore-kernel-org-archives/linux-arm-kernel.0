From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 13 Sep 2012 22:12:12 +0800
Subject: [PATCH 11/12] ARM: initial multiplatform support
In-Reply-To: <1346962375-26163-12-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-12-git-send-email-robherring2@gmail.com>
Message-ID: <20120913141208.GA1338@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 03:12:54PM -0500, Rob Herring wrote:
> ---
>  arch/arm/Kconfig                                  |  123 ++++++++--------
>  arch/arm/Kconfig.debug                            |    1 +
>  arch/arm/Makefile                                 |  155 +++++++++++----------
>  arch/arm/boot/compressed/misc.c                   |    6 +
>  arch/arm/include/asm/timex.h                      |    4 +
>  arch/arm/mach-highbank/Kconfig                    |   15 ++
>  arch/arm/mach-highbank/Makefile.boot              |    1 -
>  arch/arm/mach-highbank/include/mach/timex.h       |    6 -
>  arch/arm/mach-highbank/include/mach/uncompress.h  |    9 --
>  arch/arm/mach-mvebu/Kconfig                       |   10 ++
>  arch/arm/mach-mvebu/Makefile                      |    2 +
>  arch/arm/mach-mvebu/Makefile.boot                 |    1 -
>  arch/arm/mach-mvebu/include/mach/timex.h          |   13 --
>  arch/arm/mach-mvebu/include/mach/uncompress.h     |   43 ------
>  arch/arm/mach-picoxcell/Kconfig                   |   14 ++
>  arch/arm/mach-picoxcell/Makefile.boot             |    1 -
>  arch/arm/mach-picoxcell/include/mach/hardware.h   |   21 ---
>  arch/arm/mach-picoxcell/include/mach/timex.h      |   25 ----
>  arch/arm/mach-picoxcell/include/mach/uncompress.h |   21 ---
>  arch/arm/mach-socfpga/Kconfig                     |   16 +++
>  arch/arm/mach-socfpga/Makefile.boot               |    1 -
>  arch/arm/mach-socfpga/include/mach/timex.h        |   19 ---
>  arch/arm/mach-socfpga/include/mach/uncompress.h   |    9 --
>  23 files changed, 205 insertions(+), 311 deletions(-)
>  create mode 100644 arch/arm/mach-highbank/Kconfig
>  delete mode 100644 arch/arm/mach-highbank/Makefile.boot
>  delete mode 100644 arch/arm/mach-highbank/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-highbank/include/mach/uncompress.h
>  delete mode 100644 arch/arm/mach-mvebu/Makefile.boot
>  delete mode 100644 arch/arm/mach-mvebu/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-mvebu/include/mach/uncompress.h
>  create mode 100644 arch/arm/mach-picoxcell/Kconfig
>  delete mode 100644 arch/arm/mach-picoxcell/Makefile.boot
>  delete mode 100644 arch/arm/mach-picoxcell/include/mach/hardware.h
>  delete mode 100644 arch/arm/mach-picoxcell/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-picoxcell/include/mach/uncompress.h
>  create mode 100644 arch/arm/mach-socfpga/Kconfig
>  delete mode 100644 arch/arm/mach-socfpga/Makefile.boot
>  delete mode 100644 arch/arm/mach-socfpga/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-socfpga/include/mach/uncompress.h
> 
Hmm, why do I not see the same file removals for mach-vexpress?

-- 
Regards,
Shawn
