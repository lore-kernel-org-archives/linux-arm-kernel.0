From: robert.richter@amd.com (Robert Richter)
Date: Thu, 16 Sep 2010 14:46:56 +0200
Subject: [PATCH 2/6] ARM: oprofile: Rename op_arm to oprofile_perf
In-Reply-To: <61369979994f435ba2ac62f06717644d722ee002.1284357372.git.matt@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
	<61369979994f435ba2ac62f06717644d722ee002.1284357372.git.matt@console-pimps.org>
Message-ID: <20100916124656.GY13563@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.09.10 02:07:33, Matt Fleming wrote:
> In preparation for moving the generic functions out of this file, give
> the functions more general names (e.g. remove "arm" from the names).
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---
>  arch/arm/oprofile/common.c |   68 ++++++++++++++++++++++----------------------
>  1 files changed, 34 insertions(+), 34 deletions(-)

>  static struct platform_driver oprofile_driver = {
>  	.driver		= {
> -		.name		= "arm-oprofile",
> +		.name		= "perf-oprofile",

This should be "oprofile-perf" instead, otherwise the driver belongs
to perf.

-Robert

>  	},
> -	.resume		= op_arm_resume,
> -	.suspend	= op_arm_suspend,
> +	.resume		= oprofile_perf_resume,
> +	.suspend	= oprofile_perf_suspend,
>  };

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
