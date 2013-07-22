From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 22 Jul 2013 19:03:44 +0200
Subject: [PATCH v4 0/5] ARM: at91: prepare transition to common clk
 framework
In-Reply-To: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130722170344.GK16015@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:32 Thu 18 Jul     , Boris BREZILLON wrote:
> Hello,
> 
> This patch series prepares the transition to common clk framework by
> replacing all the clk_enable and clk_disable calls by clk_prepare_unable and
> clk_disable_unprepare to avoid common clock framework warnings.
on the whole serie

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

> 
> Best Regards,
> Boris
> 
> Changes since v3:
>  - move usb clock config patches out of this series
>  - move clk_prepare/unprepare calls out of critical sections (ssc and
>    mci drivers)
>  - remove already applied spi clk_prepare patch 
> 
> Changes since v2:
>  - add configuraton of usb clock in ohci and udc drivers
>  - add clk_prepare patch for usba udc driver
>  - add clk_prepare patch for spi driver
>  - remove already applied udc clk_prepare patch
> 
> Changes since v1:
>  - remove unneeded clk_unprepare in mci driver
>  - remove already applied patches (ehci, ohci, dma and serial)
> 
> Changes since common clk patch series:
>  - add clk_prepare_enable return check
>  - fix a deadlock in atmel-mci (missing spin_unlock)
>  - remove already applied patches (atmel-ssc and pwm-atmel-tcb)
> 
> Boris BREZILLON (5):
>   ARM: at91/tc/clocksource: replace clk_enable/disable with
>     clk_prepare_enable/disable_unprepare.
>   mmc: atmel-mci: prepare clk before calling enable
>   at91/avr32/atmel_lcdfb: prepare clk before calling enable
>   USB: gadget: atmel_usba: prepare clk before calling enable
>   ASoC: atmel-ssc: remove clk_disable_unprepare call from critical
>     section
> 
>  drivers/clocksource/tcb_clksrc.c    |   10 +++++-----
>  drivers/misc/atmel-ssc.c            |   11 ++++++++---
>  drivers/mmc/host/atmel-mci.c        |   34 +++++++++++++++++++++++++++-------
>  drivers/usb/gadget/atmel_usba_udc.c |   28 +++++++++++++++++++++-------
>  drivers/video/atmel_lcdfb.c         |    8 ++++----
>  5 files changed, 65 insertions(+), 26 deletions(-)
> 
> -- 
> 1.7.9.5
> 
