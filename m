From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 21 Jul 2017 17:03:01 +0100
Subject: [PATCH] firmware: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-21-robh@kernel.org>
References: <20170718214339.7774-21-robh@kernel.org>
Message-ID: <6445babc-73d3-005c-8b83-22290c5d8bab@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/07/17 22:43, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/firmware/arm_scpi.c | 2 +-
>  drivers/firmware/psci.c     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index 8043e51de897..59190c374696 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c
> @@ -965,7 +965,7 @@ static int scpi_probe(struct platform_device *pdev)
> 
>  	count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
>  	if (count < 0) {
> -		dev_err(dev, "no mboxes property in '%s'\n", np->full_name);
> +		dev_err(dev, "no mboxes property in '%pOF'\n", np);
>  		return -ENODEV;
>  	}
> 

(For the SCPI part)
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

I assume you will ask ARM-SoC guys to pick this up. Let us know if you
think otherwise.

-- 
Regards,
Sudeep
