From: robert.richter@amd.com (Robert Richter)
Date: Wed, 6 Oct 2010 20:37:05 +0200
Subject: [PATCH 7/7] sh: Annotate oprofile_arch_exit() with __exit marker
In-Reply-To: <4426d17460dc88dcb3d6e3af1b91af4db83785ae.1286222593.git.matt@console-pimps.org>
References: <cover.1286222593.git.matt@console-pimps.org>
	<4426d17460dc88dcb3d6e3af1b91af4db83785ae.1286222593.git.matt@console-pimps.org>
Message-ID: <20101006183705.GX13563@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.10.10 16:44:25, Matt Fleming wrote:
> In order to avoid a section mismatch we need to annotate
> oprofile_arch_exit() with an __exit marker.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Looks good.

-Robert

> ---
>  arch/sh/oprofile/common.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/sh/oprofile/common.c b/arch/sh/oprofile/common.c
> index 449f842..93033d8 100644
> --- a/arch/sh/oprofile/common.c
> +++ b/arch/sh/oprofile/common.c
> @@ -29,7 +29,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
>  	return oprofile_perf_init(ops);
>  }
>  
> -void oprofile_arch_exit(void)
> +void __exit oprofile_arch_exit(void)
>  {
>  	oprofile_perf_exit();
>  }
> -- 
> 1.7.1
> 
> 

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
