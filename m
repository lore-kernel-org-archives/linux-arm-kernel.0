From: shijie.huang@arm.com (Huang Shijie)
Date: Tue, 17 May 2016 17:57:33 +0800
Subject: [PATCH v12 10/10] kprobes: Add arm64 case in kprobe example module
In-Reply-To: <1461783185-9056-11-git-send-email-dave.long@linaro.org>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
 <1461783185-9056-11-git-send-email-dave.long@linaro.org>
Message-ID: <20160517095714.GA25167@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 02:53:05PM -0400, David Long wrote:
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
> index 727eb21..0c72b8a 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -42,6 +42,10 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
>  			" ex1 = 0x%lx\n",
>  		p->addr, regs->pc, regs->ex1);
>  #endif
> +#ifdef CONFIG_ARM64
> +	pr_info("pre_handler: p->addr = 0x%p, pc = 0x%lx\n",

I think you miss the KERN_INFO here.

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
ditto.
> +		p->addr, (long)regs->pc);
> +#endif
thanks
Huang Shijie
