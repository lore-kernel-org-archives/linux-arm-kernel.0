From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Aug 2014 17:11:28 +0100
Subject: [PATCH 3/9] arm64: Remove unneeded extern keyword
In-Reply-To: <1e9885b2581bae7e296b59411b26e03ba44a43e5.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
 <1e9885b2581bae7e296b59411b26e03ba44a43e5.1408736066.git.geoff@infradead.org>
Message-ID: <20140826161128.GE4078@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Fri, Aug 22, 2014 at 08:49:16PM +0100, Geoff Levand wrote:
> Function prototypes are never definitions, so remove any 'extern' keyword
> from the funcion prototypes in cpu_ops.h. Fixes warnings emited by
> checkpatch.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Looks sane to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/cpu_ops.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
> index d7b4b38..150ce63 100644
> --- a/arch/arm64/include/asm/cpu_ops.h
> +++ b/arch/arm64/include/asm/cpu_ops.h
> @@ -61,7 +61,7 @@ struct cpu_operations {
>  };
>  
>  extern const struct cpu_operations *cpu_ops[NR_CPUS];
> -extern int __init cpu_read_ops(struct device_node *dn, int cpu);
> -extern void __init cpu_read_bootcpu_ops(void);
> +int __init cpu_read_ops(struct device_node *dn, int cpu);
> +void __init cpu_read_bootcpu_ops(void);
>  
>  #endif /* ifndef __ASM_CPU_OPS_H */
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
