From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Apr 2015 23:17:06 +0200
Subject: [RFC PATCH 3/5] arm64: introduce CPU_OF_TABLES for cpu ops
 selection
In-Reply-To: <1428601031-5366-4-git-send-email-galak@codeaurora.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <1428601031-5366-4-git-send-email-galak@codeaurora.org>
Message-ID: <3133453.Cys8lc6CAy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 April 2015 12:37:09 Kumar Gala wrote:
> @@ -67,4 +67,9 @@ extern const struct cpu_operations *cpu_ops[NR_CPUS];
>  int __init cpu_read_ops(struct device_node *dn, int cpu);
>  void __init cpu_read_bootcpu_ops(void);
>  
> +#define CPU_METHOD_OF_DECLARE(name, __ops)                             \
> +       static const struct cpu_operations *__cpu_method_table_##name   \
> +       __used __section(__cpu_method_of_table)                         \
> +       = __ops;
> +
>  #endif /* ifndef __ASM_CPU_OPS_H */
> 

I'd rather not add this, to avoid giving the appearance that platforms
can just add another one here.

	Arnd
