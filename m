From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 17 May 2013 10:28:23 +0800
Subject: [Bug] ARM 'perf' regression by commit a43cb95d5
In-Reply-To: <CACVXFVPjo2dQpYPpqZS8GC8UPNzB5HLURpYm6-g1FOBbSUjDyA@mail.gmail.com>
References: <CACVXFVPjo2dQpYPpqZS8GC8UPNzB5HLURpYm6-g1FOBbSUjDyA@mail.gmail.com>
Message-ID: <CACVXFVPYsF3z6GajSeTSq6r0jbLrPWeGf9=0ckqC+uprF7wOiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 10:16 AM, Ming Lei <ming.lei@canonical.com> wrote:
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index f219703..89bc3a4 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -225,7 +225,7 @@ void __show_regs(struct pt_regs *regs)
>         unsigned long flags;
>         char buf[64];
>
> -       show_regs_print_info(KERN_DEFAULT);
> +       //show_regs_print_info(KERN_DEFAULT);

Forget to mention, __show_regs() isn't run under both cases.

Thanks,
--
Ming Lei
