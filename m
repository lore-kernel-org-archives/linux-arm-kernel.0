From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Apr 2011 09:26:33 +0300
Subject: [v2 0/7] OMAP: GPIO: Use PM runtime framework
In-Reply-To: <1303139217-10285-1-git-send-email-charu@ti.com>
References: <no>
 <1303139217-10285-1-git-send-email-charu@ti.com>
Message-ID: <20110419062633.GA15620@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Varadarajan, Charulatha <charu@ti.com> [110418 18:00]:
> From: Charulatha V <charu@ti.com>
> 
> Use PM runtime framework in OMAP GPIO driver.
...
 
>  arch/arm/mach-omap2/gpio.c             |    6 +
>  arch/arm/mach-omap2/pm34xx.c           |   22 +-
>  arch/arm/plat-omap/gpio.c              |  766 ++++++++++++++++++--------------
>  arch/arm/plat-omap/include/plat/gpio.h |    3 +-
>  4 files changed, 439 insertions(+), 358 deletions(-)

Before this series gets merged we first need to do the following:

- Pass some registers in platform_data so we can have common
  functions in gpio.c instead of having to test for the bank->method
  in each function. This allows getting rid of the ifdefs as
  discussed in the ARM Linux consolidation thread.

- Move it to drivers/gpio

- Further consolidate with whatever common GPIO code might
  be coming up.

Regards,

Tony
