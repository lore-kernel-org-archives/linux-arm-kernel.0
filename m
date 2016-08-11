From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 11 Aug 2016 17:36:45 +0200
Subject: [PATCH v7 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
In-Reply-To: <20160811152538.GH13300@pathway.suse.cz>
References: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
 <1470672218-16059-5-git-send-email-cmetcalf@mellanox.com>
 <20160809124325.GG13300@pathway.suse.cz>
 <feaaca8f-cc09-5847-ea3f-d27052704d9b@mellanox.com>
 <20160811152538.GH13300@pathway.suse.cz>
Message-ID: <20160811153645.GX30192@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 05:25:38PM +0200, Petr Mladek wrote:
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index b77f5edb03b0..e31d50acd491 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -44,7 +44,7 @@ static inline void native_irq_enable(void)
>  	asm volatile("sti": : :"memory");
>  }
>  
> -static inline void native_safe_halt(void)
> +static inline __attribute__((__section__(".cpuidle.text"))) void native_safe_halt(void)
>  {
>  	asm volatile("sti; hlt": : :"memory");
>  }

An alternative is to use __always_inline I suppose.
