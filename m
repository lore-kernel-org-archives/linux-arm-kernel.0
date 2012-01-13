From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 16:43:36 +0000
Subject: [RFC PATCH 01/10] rtc: sa1100: include mach/irqs.h instead of
 asm/irq.h
In-Reply-To: <1326472451-9002-2-git-send-email-robherring2@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-2-git-send-email-robherring2@gmail.com>
Message-ID: <20120113164336.GA1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 10:34:02AM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Since asm/irq.h may not include mach/irqs.h, include mach/irqs.h directly.

Rather than doing this, we should be eliminating the need for these
old drivers to include mach/irqs.h at all.

Adding the resources to the platform device, and then using at least
the IRQ resource(s) would be a definite step forward (and a relatively
easy one to do.)

> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  drivers/rtc/rtc-sa1100.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
> index 4595d3e..144fa06 100644
> --- a/drivers/rtc/rtc-sa1100.c
> +++ b/drivers/rtc/rtc-sa1100.c
> @@ -33,7 +33,7 @@
>  #include <linux/io.h>
>  
>  #include <mach/hardware.h>
> -#include <asm/irq.h>
> +#include <mach/irqs.h>
>  
>  #define RTC_DEF_DIVIDER		(32768 - 1)
>  #define RTC_DEF_TRIM		0
> -- 
> 1.7.5.4
> 
