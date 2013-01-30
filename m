From: davidb@codeaurora.org (David Brown)
Date: Wed, 30 Jan 2013 13:33:51 -0800
Subject: [PATCH] ARM:mach-msm: seting tail NUL after strncpy
In-Reply-To: <5108A913.6080304@asianux.com> (Chen Gang's message of "Wed, 30
 Jan 2013 13:01:07 +0800")
References: <5108A913.6080304@asianux.com>
Message-ID: <8ya4nhywe2o.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chen Gang <gang.chen@asianux.com> writes:

>   temp need NUL terminated, or next ptr may cause issue.
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/mach-msm/clock-debug.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-msm/clock-debug.c
> b/arch/arm/mach-msm/clock-debug.c
> index 4886404..bdca900 100644
> --- a/arch/arm/mach-msm/clock-debug.c
> +++ b/arch/arm/mach-msm/clock-debug.c
> @@ -105,6 +105,8 @@ int __init clock_debug_add(struct clk *clock)
>  		return -ENOMEM;
>
>  	strncpy(temp, clock->dbg_name, ARRAY_SIZE(temp)-1);
> +	temp[ARRAY_SIZE(temp)-1] = '\0';
> +
>  	for (ptr = temp; *ptr; ptr++)

I believe that Stephen Boyd is putting some significant work into this
code.  Stephen, can you see if this bug is still in your current
version of the code, and make sure that it is fixed there?

Thanks,
David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
