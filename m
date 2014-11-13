From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 13 Nov 2014 15:53:43 +0100
Subject: [PATCH] ARM: at91: move sdramc/ddrsdr header to include/soc/at91
In-Reply-To: <54649221.9060307@atmel.com>
References: <1415393901-18469-1-git-send-email-alexandre.belloni@free-electrons.com>
 <54649221.9060307@atmel.com>
Message-ID: <20141113155343.5c92c2d6@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Nov 2014 12:12:33 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> On 07/11/2014 21:58, Alexandre Belloni :
> > Move the (DDR) SDRAM controller headers to include/soc/at91 to remove the
> > dependency on mach/ headers from the at91-reset driver.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> > As my previous attempts were not popular, solve the mach/ headers issue by
> > simply moving them. I'll get back to better driver separation when it will be
> > possible to map the SRAM as executable memory.
> > 
> >  MAINTAINERS                                        |   1 +
> >  arch/arm/mach-at91/include/mach/at91_ramc.h        |   6 +-
> >  .../arm/mach-at91/include/mach/at91rm9200_sdramc.h |  63 -----------
> >  arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h  | 124 ---------------------
> >  arch/arm/mach-at91/include/mach/at91sam9_sdramc.h  |  85 --------------
> >  arch/arm/mach-at91/pm.h                            |   1 -
> >  drivers/power/reset/at91-reset.c                   |   4 +-
> >  include/soc/at91/at91rm9200_sdramc.h               |  63 +++++++++++
> >  include/soc/at91/at91sam9_ddrsdr.h                 | 124 +++++++++++++++++++++
> >  include/soc/at91/at91sam9_sdramc.h                 |  85 ++++++++++++++
> >  10 files changed, 278 insertions(+), 278 deletions(-)
> >  delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200_sdramc.h
> >  delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
> >  delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9_sdramc.h
> >  create mode 100644 include/soc/at91/at91rm9200_sdramc.h
> >  create mode 100644 include/soc/at91/at91sam9_ddrsdr.h
> >  create mode 100644 include/soc/at91/at91sam9_sdramc.h
> 
> This would have been cleaner and easier to understand with
> git format-patch -M
> 
> --8<--------------------------------
>  MAINTAINERS                                                         | 1 +
>  arch/arm/mach-at91/include/mach/at91_ramc.h                         | 6 +++---
>  arch/arm/mach-at91/pm.h                                             | 1 -
>  drivers/power/reset/at91-reset.c                                    | 4 ++--
>  .../mach-at91/include/mach => include/soc/at91}/at91rm9200_sdramc.h | 0
>  .../mach-at91/include/mach => include/soc/at91}/at91sam9_ddrsdr.h   | 0
>  .../mach-at91/include/mach => include/soc/at91}/at91sam9_sdramc.h   | 0
>  7 files changed, 6 insertions(+), 6 deletions(-)
>  rename {arch/arm/mach-at91/include/mach => include/soc/at91}/at91rm9200_sdramc.h (100%)
>  rename {arch/arm/mach-at91/include/mach => include/soc/at91}/at91sam9_ddrsdr.h (100%)
>  rename {arch/arm/mach-at91/include/mach => include/soc/at91}/at91sam9_sdramc.h (100%)
> --8<--------------------------------
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> and queued for at91-3.19-cleanup


I'm getting back to this patch because I'd like understand what exactly
should be put in include/soc/<soc-name> and what should be put in the
subsystem directory (include/linux/<subsystem>) ?

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
