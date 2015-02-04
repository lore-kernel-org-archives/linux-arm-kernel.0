From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Wed, 04 Feb 2015 12:17:21 +0900
Subject: [PATCH] SAMPLES: kprobe_example: Make it print something on ARM.
In-Reply-To: <1423018585-4005-1-git-send-email-long.wanglong@huawei.com>
References: <1423018585-4005-1-git-send-email-long.wanglong@huawei.com>
Message-ID: <54D18F41.4070207@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2015/02/04 11:56), Wang Long wrote:
> This KProbes example is a little useless if it doesn't print anything.
> For ARM print similar messages to those produced on x86 and PPC.

BTW, I guess similar update required for s390, doesn't it?

> 
> Signed-off-by: Wang Long <long.wanglong@huawei.com>

Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Thank you!

> ---
>  samples/kprobes/kprobe_example.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index 366db1a..eba9f1a 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -42,6 +42,11 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
>  			" ex1 = 0x%lx\n",
>  		p->addr, regs->pc, regs->ex1);
>  #endif
> +#ifdef CONFIG_ARM
> +	printk(KERN_INFO "pre_handler: p->addr = 0x%p, ARM_pc = 0x%lx,"
> +			" ARM_cpsr = 0x%lx\n",
> +		p->addr, regs->ARM_pc, regs->ARM_cpsr);
> +#endif
>  
>  	/* A dump_stack() here will give a stack backtrace */
>  	return 0;
> @@ -67,6 +72,10 @@ static void handler_post(struct kprobe *p, struct pt_regs *regs,
>  	printk(KERN_INFO "post_handler: p->addr = 0x%p, ex1 = 0x%lx\n",
>  		p->addr, regs->ex1);
>  #endif
> +#ifdef CONFIG_ARM
> +	printk(KERN_INFO "post_handler: p->addr = 0x%p, ARM_cpsr = 0x%lx\n",
> +		p->addr, regs->ARM_cpsr);
> +#endif
>  }
>  
>  /*
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
