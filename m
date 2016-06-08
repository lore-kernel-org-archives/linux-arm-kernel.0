From: shijie.huang@arm.com (Huang Shijie)
Date: Wed, 8 Jun 2016 13:49:05 +0800
Subject: [PATCH v13 10/10] kprobes: Add arm64 case in kprobe example module
In-Reply-To: <1464924384-15269-11-git-send-email-dave.long@linaro.org>
References: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
 <1464924384-15269-11-git-send-email-dave.long@linaro.org>
Message-ID: <20160608054903.GA8198@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 11:26:24PM -0400, David Long wrote:
> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> 
> Add info prints in sample kprobe handlers for ARM64
> 
> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> ---
>  samples/kprobes/kprobe_example.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index ed0ca0c..aad8e6f 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -46,6 +46,10 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
>  			" ex1 = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->pc, regs->ex1);
>  #endif
> +#ifdef CONFIG_ARM64
> +	pr_info("pre_handler: p->addr = 0x%p, pc = 0x%lx\n",
> +		p->addr, (long)regs->pc);
Please add the "p->symbol_name" for the log, just as the above line.

> +#endif
>  
>  	/* A dump_stack() here will give a stack backtrace */
>  	return 0;
> @@ -71,6 +75,10 @@ static void handler_post(struct kprobe *p, struct pt_regs *regs,
>  	printk(KERN_INFO "<%s> post_handler: p->addr = 0x%p, ex1 = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->ex1);
>  #endif
> +#ifdef CONFIG_ARM64
> +	pr_info("post_handler: p->addr = 0x%p, pc = 0x%lx\n",
> +		p->addr, (long)regs->pc);
> +#endif
>  }
Ditto.

thanks
Huang Shijie
