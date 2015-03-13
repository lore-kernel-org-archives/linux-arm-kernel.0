From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 Mar 2015 14:43:09 +0100
Subject: [PATCH v2.0 0/2] ARM: AT91: pm: add support to disable the DDR's
 clock
In-Reply-To: <1425873378-8253-1-git-send-email-wenyou.yang@atmel.com>
References: <1425873378-8253-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <5502E96D.2050002@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/03/2015 04:56, Wenyou Yang a ?crit :
> Hi,
> 
> The patch series purpose is to disable the DDR controller's clock and DDR
> system clock during the suspending to achieve the lower power consumption.
> 
> It is based on the branch, at91-4.0-fixes
> git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
> 	+ [PATCH] ARM: at91: Add pm support for sama5d3 and sama5d4
> 
> Change log for v2.0
>  - rebase.
> 
> Wenyou Yang (2):
>   pm: at91: add the PM initialization for the sama5d3 and sama5d4
>   pm: at91: add support to disable/enable the DDR clock

I still have to make up my mind with this series. I keep it out of my
first cleanup pull-request for now.

Let's keep on thinking about it...

Bye,


>  arch/arm/mach-at91/generic.h              |    4 ++
>  arch/arm/mach-at91/include/mach/sama5d3.h |    1 +
>  arch/arm/mach-at91/include/mach/sama5d4.h |    5 ++
>  arch/arm/mach-at91/pm.c                   |   25 +++++++++
>  arch/arm/mach-at91/pm.h                   |    9 ++++
>  arch/arm/mach-at91/pm_suspend.S           |   83 +++++++++++++++++++++++++++++
>  arch/arm/mach-at91/sama5.c                |    8 ++-
>  include/linux/clk/at91_pmc.h              |    1 +
>  8 files changed, 135 insertions(+), 1 deletion(-)
> 


-- 
Nicolas Ferre
