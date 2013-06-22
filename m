From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 22 Jun 2013 15:46:41 +0200
Subject: [PATCH v6 4/8] ARM: Add .init_platform() callback to machine
 descriptor
In-Reply-To: <1371774924-9224-5-git-send-email-tomasz.figa@gmail.com>
References: <1371774924-9224-1-git-send-email-tomasz.figa@gmail.com>
 <1371774924-9224-5-git-send-email-tomasz.figa@gmail.com>
Message-ID: <2503927.uZIubvXWLh@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Friday 21 of June 2013 02:35:20 Tomasz Figa wrote:
> Most ARM platforms have parts that should be initialized as early as
> possible, which usually means as soon as memory management (kmalloc,
> ioremap) starts to work,
> 
> However, currently there is no appropriate callback in machine_desc
> struct to use for such initialization and platforms tend to stuff things
> up .init_irq() and .init_time() callbacks.
> 
> Since all the DT-based platforms are going towards generic IRQ and time
> initialization (using irqchip_init and clocksource_of_init) and current
> code assumes that if custom callbacks are not provided in machine_desc
> then generic ones should be used, this problem has become a bit more
> inconvenient.
> 
> This patch tries to solve this issue by introducing new callback called
> .init_platform(), where any custom low level initialization of platform
> can be done safely.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/include/asm/mach/arch.h | 1 +
>  arch/arm/kernel/irq.c            | 3 +++
>  2 files changed, 4 insertions(+)

Please disregard this patch when applying the series (if that happens).

Best regards,
Tomasz
