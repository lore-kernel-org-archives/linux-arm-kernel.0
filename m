From: zhang.lyra@gmail.com (Lyra Zhang)
Date: Thu, 4 Dec 2014 20:37:56 +0800
Subject: [PATCH] arm64/include/asm: Fixed a warning about 'struct pt_regs'
In-Reply-To: <1417692197-18518-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1417692197-18518-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <CAAfSe-umuaCJ947FtiTWjQSjfwHPiwg9ZEine+=vbdGg2EK8qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, All

I'm sorry that this is an accident from our IT-service, because they
all use M$ software, and didn't familiar with git send-email.
You can ignore this email.
.
Please forgive that persons who are only able to use M$ products.


Thanks,
Chunyan


2014-12-04 19:23 GMT+08:00 Chunyan Zhang <chunyan.zhang@spreadtrum.com>:
> If I include asm/irq.h on the top of my code, and set ARCH=arm64,
> I'll get a compile warning, details are below:
> warning: ?struct pt_regs?
> declared inside parameter list [enabled by default]
>
> This patch is suggested by Arnd, see:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308270.html
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  arch/arm64/include/asm/irq.h |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index e1f7ecd..acedc7e 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -3,6 +3,8 @@
>
>  #include <asm-generic/irq.h>
>
> +struct pt_regs;
> +
>  extern void (*handle_arch_irq)(struct pt_regs *);
>  extern void migrate_irqs(void);
>  extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
