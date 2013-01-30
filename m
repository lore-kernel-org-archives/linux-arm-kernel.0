From: bjorn@mork.no (=?utf-8?Q?Bj=C3=B8rn_Mork?=)
Date: Wed, 30 Jan 2013 10:19:16 +0100
Subject: [PATCH] ARM:mach-msm: seting tail NUL after strncpy
In-Reply-To: <5108A913.6080304@asianux.com> (Chen Gang's message of "Wed, 30
 Jan 2013 13:01:07 +0800")
References: <5108A913.6080304@asianux.com>
Message-ID: <87pq0nni3v.fsf@nemi.mork.no>
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
>  		*ptr = tolower(*ptr);

Maybe use strlcpy() instead?


Bj?rn
