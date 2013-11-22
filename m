From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 23 Nov 2013 01:35:46 +0400
Subject: [PATCH 0/9] ARM: sa1100: Rework IRQ handling
In-Reply-To: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CALT56yPz=71SEWhXZLKp67Qxq2GD9vhWsc5rFr7VU53uxuwXDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 12:47 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Dmitry Eremin-Solenikov (9):
>       ARM: sa1100 collie: use gpio-charger instead of pda-power
>       ARM: locomo: don't clobber chip data for chained irq

Russell, could you please reivew and ack these first two patches.
I would like to get them independently of the fate of the rest of this
patch serie.

>       ARM: sa1100: switch to MULTI_IRQ_HANDLER
>       ARM: sa1100: convert gpio driver to be a proper platform driver
>       ARM: sa1100: add platform functions to handle PWER settings
>       ARM: sa1100: enable IRQ domains
>       ARM: sa1100: move gpio irq handling to GPIO driver
>       ARM: sa1100: move per-IRQ PWER settings to core code
>       ARM: sa1100: refactor irq driver
>
>  arch/arm/Kconfig                                |   2 +
>  arch/arm/common/locomo.c                        |   4 +-
>  arch/arm/mach-sa1100/collie.c                   |  55 ++-------------
>  arch/arm/mach-sa1100/generic.c                  |  46 +++++++++++-
>  arch/arm/mach-sa1100/generic.h                  |   3 +-
>  arch/arm/mach-sa1100/include/mach/SA-1100.h     |   2 +
>  arch/arm/mach-sa1100/include/mach/entry-macro.S |  41 -----------
>  arch/arm/mach-sa1100/include/mach/irqs.h        |  73 +++++++++++--------
>  arch/arm/mach-sa1100/irq.c                      | 322 +++++++++++++++++++++--------------------------------------------------------------
>  drivers/gpio/Kconfig                            |   6 ++
>  drivers/gpio/Makefile                           |   2 +-
>  drivers/gpio/gpio-sa1100.c                      | 332 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  12 files changed, 500 insertions(+), 388 deletions(-)
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/entry-macro.S
>
>



-- 
With best wishes
Dmitry
