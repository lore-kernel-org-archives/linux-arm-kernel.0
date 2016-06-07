From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Tue, 7 Jun 2016 19:12:57 +0900
Subject: [PATCH v13 10/10] kprobes: Add arm64 case in kprobe example module
In-Reply-To: <1464924384-15269-11-git-send-email-dave.long@linaro.org>
References: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
 <1464924384-15269-11-git-send-email-dave.long@linaro.org>
Message-ID: <20160607191257.cecd4ef5790851aaa956ffc1@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  2 Jun 2016 23:26:24 -0400
David Long <dave.long@linaro.org> wrote:

> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> 
> Add info prints in sample kprobe handlers for ARM64
> 

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

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
>  
>  /*
> -- 
> 2.5.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
