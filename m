From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 12 Mar 2015 14:19:44 +0100
Subject: [PATCH v3 0/9] ARM: at91 cleanups for 4.1 #1
In-Reply-To: <1426093235-11759-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426093235-11759-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55019270.3010400@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/03/2015 18:00, Alexandre Belloni a ?crit :
> This series removes more mach/headers.
> 
> Then it introduces a more scalable SoC detection infrastructure which allows to
> remove the at91_map_io/at91_alt_map_io and iotable_init ugliness.
> 
> Changes in v3:
>  - Stop trying to unmap a range that failed ot be mapped
> 
> Changes in v2:
>  - All the SoC names are lowercased
>  - Removed the unused compatible string
>  - Use name/subname to display the type and subtype
> 
> 
> 
> Alexandre Belloni (7):
>   ARM: at91: remove unused at91_ioremap_matrix and header
>   ARM: at91: remove unused _matrix.h headers
>   ARM: at91/dt: introduce atmel,<chip>-dbgu
>   ARM: at91: at91rm9200 use SoC detection infrastructure
>   ARM: at91: at91sam9: use SoC detection infrastructure
>   ARM: at91: sama5 use SoC detection infrastructure
>   ARM: at91: remove old setup
> 
> Arnd Bergmann (1):
>   ARM: at91: remove NEED_MACH_IO_H
> 
> Boris BREZILLON (1):
>   ARM: at91: add soc detection infrastructure

I agree with the whole series with little comments on the way to sort
SoCs and families (if it exists).

Please have a look in patch 5/9.

Thanks a lot, bye.

>  .../devicetree/bindings/serial/atmel-usart.txt     |   3 +-
>  arch/arm/Kconfig                                   |   2 +-
>  arch/arm/boot/dts/at91rm9200.dtsi                  |   2 +-
>  arch/arm/boot/dts/at91sam9260.dtsi                 |   2 +-
>  arch/arm/boot/dts/at91sam9261.dtsi                 |   2 +-
>  arch/arm/boot/dts/at91sam9263.dtsi                 |   2 +-
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |   2 +-
>  arch/arm/boot/dts/at91sam9n12.dtsi                 |   2 +-
>  arch/arm/boot/dts/at91sam9rl.dtsi                  |   2 +-
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |   2 +-
>  arch/arm/boot/dts/sama5d3.dtsi                     |   2 +-
>  arch/arm/boot/dts/sama5d4.dtsi                     |   2 +-
>  arch/arm/mach-at91/Kconfig                         |   1 +
>  arch/arm/mach-at91/Makefile                        |   2 +-
>  arch/arm/mach-at91/at91rm9200.c                    |  34 ++-
>  arch/arm/mach-at91/at91sam9.c                      |  86 ++++--
>  arch/arm/mach-at91/generic.h                       |   4 -
>  arch/arm/mach-at91/include/mach/at91_matrix.h      |  23 --
>  .../mach-at91/include/mach/at91sam9260_matrix.h    |  80 -----
>  .../mach-at91/include/mach/at91sam9261_matrix.h    |  64 ----
>  .../mach-at91/include/mach/at91sam9263_matrix.h    | 129 --------
>  .../mach-at91/include/mach/at91sam9g45_matrix.h    | 153 ----------
>  .../mach-at91/include/mach/at91sam9n12_matrix.h    |  53 ----
>  .../arm/mach-at91/include/mach/at91sam9rl_matrix.h |  96 ------
>  .../arm/mach-at91/include/mach/at91sam9x5_matrix.h |  53 ----
>  arch/arm/mach-at91/include/mach/io.h               |  27 --
>  arch/arm/mach-at91/sama5.c                         |  54 +++-
>  arch/arm/mach-at91/setup.c                         | 330 ---------------------
>  arch/arm/mach-at91/soc.c                           | 110 +++++++
>  arch/arm/mach-at91/soc.h                           |  95 ++++++
>  drivers/pcmcia/Kconfig                             |   1 +
>  drivers/pcmcia/at91_cf.c                           |  13 +-
>  32 files changed, 351 insertions(+), 1082 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91_matrix.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9260_matrix.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9261_matrix.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9263_matrix.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9g45_matrix.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12_matrix.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9rl_matrix.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5_matrix.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/io.h
>  delete mode 100644 arch/arm/mach-at91/setup.c
>  create mode 100644 arch/arm/mach-at91/soc.c
>  create mode 100644 arch/arm/mach-at91/soc.h
> 


-- 
Nicolas Ferre
