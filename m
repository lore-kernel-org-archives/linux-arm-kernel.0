From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Thu, 19 Feb 2015 23:18:56 +0900
Subject: [PATCH v5 6/6] kprobes: Add arm64 case in kprobe example module
In-Reply-To: <1424214701-4899-7-git-send-email-dave.long@linaro.org>
References: <1424214701-4899-1-git-send-email-dave.long@linaro.org>
 <1424214701-4899-7-git-send-email-dave.long@linaro.org>
Message-ID: <54E5F0D0.5030606@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2015/02/18 8:11), David Long wrote:
> From: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
> 
> Add info prints in sample kprobe handlers for ARM64
> 
> Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>

Looks good to me:)

Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Thanks!

> ---
>  samples/kprobes/kprobe_example.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index 366db1a..51d459c 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -42,6 +42,10 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
>  			" ex1 = 0x%lx\n",
>  		p->addr, regs->pc, regs->ex1);
>  #endif
> +#ifdef CONFIG_ARM64
> +	pr_info("pre_handler: p->addr = 0x%p, pc = 0x%lx\n",
> +		p->addr, (long)regs->pc);
> +#endif
>  
>  	/* A dump_stack() here will give a stack backtrace */
>  	return 0;
> @@ -67,6 +71,10 @@ static void handler_post(struct kprobe *p, struct pt_regs *regs,
>  	printk(KERN_INFO "post_handler: p->addr = 0x%p, ex1 = 0x%lx\n",
>  		p->addr, regs->ex1);
>  #endif
> +#ifdef CONFIG_ARM64
> +	pr_info("post_handler: p->addr = 0x%p, pc = 0x%lx\n",
> +		p->addr, (long)regs->pc);
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
