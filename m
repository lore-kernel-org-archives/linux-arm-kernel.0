From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 13 Jun 2011 16:33:08 +0400
Subject: [PATCH 4/4] ARM: pmu: add platform_device_id table support
In-Reply-To: <1307957757-23001-5-git-send-email-mark.rutland@arm.com>
References: <4DEFA5E1.9010600@gmail.com>
	<1307957757-23001-5-git-send-email-mark.rutland@arm.com>
Message-ID: <4DF60384.4050805@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-06-2011 13:35, Mark Rutland wrote:

> This patch adds support for platform_device_id tables, allowing new
> PMU types to be registered with the correct type, without requiring
> new platform_driver shims to provide the type.

> Macros matching functionality of the of_device_id table macros are
> provided for convenience.

> Cc: Jamie Iles<jamie@jamieiles.com>
> Cc: Will Deacon<will.deacon@arm.com>
> ---
>   arch/arm/kernel/pmu.c |   19 +++++++++++++++++++
>   1 files changed, 19 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> index d34cf88..23c3af2 100644
> --- a/arch/arm/kernel/pmu.c
> +++ b/arch/arm/kernel/pmu.c
[...]
> @@ -73,6 +86,11 @@ enum arm_pmu_type armpmu_device_type(struct platform_device *pdev)
>   		return (enum arm_pmu_type) of_id->data;
>   	}
>
> +	/* Provided by platform_device_id table */
> +	if ((pdev_id = platform_get_device_id(pdev))) {

    scripts/checkpatch.pl should warn about using = in the *if* statement...

> +		return (enum arm_pmu_type) pdev_id->driver_data;
> +	}

    scripts/checkpatch.pl should warn about unneeded {} here.
    Did you run your patch thru it?

WBR, Sergei
