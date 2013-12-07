From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 7 Dec 2013 10:49:38 +0400
Subject: [PATCH 0/3] ARM: clps711x: IRQCHIP driver
In-Reply-To: <1386008082-6867-1-git-send-email-shc_work@mail.ru>
References: <1386008082-6867-1-git-send-email-shc_work@mail.ru>
Message-ID: <20131207104938.e4a311a8d15e717f3c10d1dc@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  2 Dec 2013 22:14:42 +0400
Alexander Shiyan <shc_work@mail.ru> wrote:

> This series is devoted to new CLPS711X irqchip driver.
> The driver designed for booting from ATAGS and devicetree.
> 
> Alexander Shiyan (3):
>   ARM: clps711x: Add CLPS711X irqchip driver
>   ARM: dts: clps711x: Add bindings documentation for CLPS711X irqchip
>     driver
>   ARM: clps711x: Migrate CLPS711X subarch to the new irqchip driver
> 
>  .../interrupt-controller/cirrus,clps711x-intc.txt  |  41 ++++
>  arch/arm/Kconfig                                   |   2 -
>  arch/arm/mach-clps711x/board-autcpu12.c            |   2 -
>  arch/arm/mach-clps711x/board-cdb89712.c            |   2 -
>  arch/arm/mach-clps711x/board-clep7312.c            |   2 -
>  arch/arm/mach-clps711x/board-edb7211.c             |   2 -
>  arch/arm/mach-clps711x/board-p720t.c               |   2 -
>  arch/arm/mach-clps711x/common.c                    | 201 +----------------
>  arch/arm/mach-clps711x/common.h                    |   5 +-
>  arch/arm/mach-clps711x/include/mach/clps711x.h     |  16 --
>  drivers/irqchip/Kconfig                            |   8 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-clps711x.c                     | 246 +++++++++++++++++++++
>  13 files changed, 302 insertions(+), 228 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
>  create mode 100644 drivers/irqchip/irq-clps711x.c

Any comments on this series?

-- 
Alexander Shiyan <shc_work@mail.ru>
