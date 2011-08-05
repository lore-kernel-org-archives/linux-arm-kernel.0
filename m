From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Aug 2011 10:21:38 +0100
Subject: [PATCH 01/12] ARM: Remove LATCH reference for time-acorn.c
In-Reply-To: <20110804134437.GB919@plexity.net>
References: <cover.1312455035.git.dsaxena@linaro.org>
	<20110804134437.GB919@plexity.net>
Message-ID: <20110805092138.GA20575@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 06:44:37AM -0700, Deepak Saxena wrote:
> As part of work to remove the global CLOCK_TICK_RATE
> symbol, this patch defines a sub-arch local value
> for use by the time-acorn.c file. This is only used
> when mach-rpc is built and the tick rate was taken
> from that sub-arch's timex.h header.
> 
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> ---
>  arch/arm/common/time-acorn.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/common/time-acorn.c b/arch/arm/common/time-acorn.c
> index deeed56..0cc3a0d 100644
> --- a/arch/arm/common/time-acorn.c
> +++ b/arch/arm/common/time-acorn.c
> @@ -24,6 +24,9 @@
>  
>  #include <asm/mach/time.h>
>  
> +#define ACORN_TICK_RATE         2000000
> +#define ACORN_TIMER_LATCH	((CLOCK_TICK_RATE + HZ/2) / HZ)

Shouldn't this be ACORN_TICK_RATE ?
