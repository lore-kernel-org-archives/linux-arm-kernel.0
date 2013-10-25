From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Oct 2013 16:24:28 +0100
Subject: [PATCH RFC 6/6] kprobes: Add cases for arm and arm64 in sample
 module
In-Reply-To: <1382008671-4515-7-git-send-email-sandeepa.prabhu@linaro.org>
References: <1382008671-4515-1-git-send-email-sandeepa.prabhu@linaro.org>
 <1382008671-4515-7-git-send-email-sandeepa.prabhu@linaro.org>
Message-ID: <20131025152428.GD10673@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 12:17:51PM +0100, Sandeepa Prabhu wrote:
> Add info prints in sample kprobe handlers for ARM and ARM64
> architecture.
> 
> Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
> ---
>  samples/kprobes/kprobe_example.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index 366db1a..0521246 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -42,6 +42,14 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
>  			" ex1 = 0x%lx\n",
>  		p->addr, regs->pc, regs->ex1);
>  #endif
> +#ifdef CONFIG_ARM
> +	printk(KERN_INFO "pre_handler: p->addr = 0x%p, pc = 0x%lx\n",
> +			p->addr, regs->ARM_pc);
> +#endif
> +#ifdef CONFIG_ARM64
> +	printk(KERN_INFO "pre_handler: p->addr = 0x%p, pc = 0x%lx\n",
> +		p->addr, (long)regs->pc);
> +#endif

Huh? Why can't you combine these two together and either unconditionall cast
to long, or use void * and %p?

Will
