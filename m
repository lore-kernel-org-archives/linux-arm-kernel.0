From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 31 Aug 2016 09:04:57 +0200
Subject: [PATCH 1/2] perf_event: remove unused DEBUG_PERF_USE_VMALLOC
In-Reply-To: <20160830140834.6d1edf7abd9d95c02dae7820@arm.com>
References: <20160830140834.6d1edf7abd9d95c02dae7820@arm.com>
Message-ID: <20160831070457.GY10138@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 02:08:34PM -0500, Kim Phillips wrote:
> This 'DEBUG'-prefixed version of PERF_USE_VMALLOC is not used anywhere.
> It appears to be leftovers from commit 906010b "perf_event: Provide
> vmalloc() based mmap() backing" that introduced it.
> 
> Not sure what commit cb30711 "perf_event: Don't allow vmalloc() backed
> perf on powerpc" was trying to do with it either.
> 
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  init/Kconfig | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index cac3f09..934a61f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1707,19 +1707,6 @@ config PERF_EVENTS
>  
>  	  Say Y if unsure.
>  
> -config DEBUG_PERF_USE_VMALLOC
> -	default n
> -	bool "Debug: use vmalloc to back perf mmap() buffers"
> -	depends on PERF_EVENTS && DEBUG_KERNEL && !PPC
> -	select PERF_USE_VMALLOC

^^^^^


It forces the use of vmalloc backed pages for the ring-buffer so that we
can test that code on x86, which otherwise doesn't use it.
