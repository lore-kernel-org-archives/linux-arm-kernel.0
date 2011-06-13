From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 13 Jun 2011 15:29:29 +0100
Subject: [PATCH 4/4] ARM: pmu: add platform_device_id table support
In-Reply-To: <1307957757-23001-5-git-send-email-mark.rutland@arm.com>
References: <4DEFA5E1.9010600@gmail.com>
	<1307957757-23001-5-git-send-email-mark.rutland@arm.com>
Message-ID: <20110613142929.GB18690@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 10:35:57AM +0100, Mark Rutland wrote:
> This patch adds support for platform_device_id tables, allowing new
> PMU types to be registered with the correct type, without requiring
> new platform_driver shims to provide the type.
> 
> Macros matching functionality of the of_device_id table macros are
> provided for convenience.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/kernel/pmu.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> index d34cf88..23c3af2 100644
> --- a/arch/arm/kernel/pmu.c
> +++ b/arch/arm/kernel/pmu.c
> @@ -62,9 +62,22 @@ static struct of_device_id armpmu_of_device_ids[] = {
>  	{},
>  };
>  
> +#define PLAT_MATCH_PMU(name, type) {	\
> +	.name = name,		\
> +	.driver_data = (void *) type,	\
> +}
> +
> +#define PLAT_MATCH_CPU(name)	PLAT_MATCH_PMU(name, ARM_PMU_DEVICE_CPU)
> +
> +static struct platform_device_id armpmu_plat_device_ids[] = {
> +	/* None for now */

I guess we could put "arm-pmu" in here but I'm not sure it's worth a 
respin.

The series looks nice though, feel free to add my Acked-by for them.

Acked-by: Jamie Iles <jamie@jamieiles.com>

Jamie
