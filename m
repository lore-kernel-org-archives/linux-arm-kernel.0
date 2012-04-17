From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 17 Apr 2012 10:41:49 +0200
Subject: [PATCH v3 0/3] Add support for Atmel's AT91SAM9N12-EK (With DT)
In-Reply-To: <1334643991-19148-1-git-send-email-hong.xu@atmel.com>
References: <1334643991-19148-1-git-send-email-hong.xu@atmel.com>
Message-ID: <4F8D2CCD.4080800@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2012 08:26 AM, Hong Xu :
> This series adds support for Atmel's AT91SAM9N12-EK.
> 
> Patches are on top of v3.4-rc2 and target for v3.5
> 
> Changes since v2 (details are in patch files respectively)
> * Removed blank lines
> * Removed Nandflash partitioning info (AT91 will handle this later)
> * Removed IRQ priority table (AT91 will handle this in an unified way)
> 
> Hong Xu (3):
>   AT91: Add DT description files for AT91SAM9N12-EK
>   AT91: Add machine header file for AT91SAM9N12 SoC
>   AT91: Add machine files for AT91SAM9N12 SoC

Fine with me. I will queue this SoC support for 3.5 inclusion. Maybe
some merge modifications will be needed against our "cleanup" branch but
I will manage that easily.

Thanks for adding this support Xu Hong.

Best regards,


> 
>  arch/arm/boot/dts/at91sam9n12.dtsi                 |  222 +++++++++++++++++++
>  arch/arm/boot/dts/at91sam9n12ek.dts                |   84 +++++++
>  arch/arm/mach-at91/Kconfig                         |    9 +
>  arch/arm/mach-at91/Makefile                        |    1 +
>  arch/arm/mach-at91/Makefile.boot                   |    2 +
>  arch/arm/mach-at91/at91sam9n12.c                   |  233 ++++++++++++++++++++
>  arch/arm/mach-at91/clock.c                         |   15 +-
>  arch/arm/mach-at91/include/mach/at91sam9n12.h      |   60 +++++
>  .../mach-at91/include/mach/at91sam9n12_matrix.h    |   53 +++++
>  arch/arm/mach-at91/include/mach/cpu.h              |   10 +
>  arch/arm/mach-at91/include/mach/hardware.h         |    2 +
>  arch/arm/mach-at91/setup.c                         |    6 +
>  arch/arm/mach-at91/soc.h                           |    5 +
>  13 files changed, 697 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/boot/dts/at91sam9n12.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9n12ek.dts
>  create mode 100644 arch/arm/mach-at91/at91sam9n12.c
>  create mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12.h
>  create mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12_matrix.h
> 


-- 
Nicolas Ferre
