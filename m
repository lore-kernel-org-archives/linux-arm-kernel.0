From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 18 May 2012 12:33:16 +0530
Subject: [PATCH] ARM: OMAP2+: fix gpmc request_irq
In-Reply-To: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
Message-ID: <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Afzal who has been doing quite a bit of GMPC work recently.

On Fri, May 18, 2012 at 10:13 AM, Ming Lei <ming.lei@canonical.com> wrote:
> The IRQ52 on OMAP2+ is not a shared interrupt line. If IRQF_SHARED
> is passed to request_irq and dev_id is set as NULL, request_irq will
> return -EINVAL.
>
GPMC IRQ line can shared between the multiple devices you
connect on it.

> This patch just removes the flag of IRQF_SHARED to make the irq
> registration successful.
>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
> ?arch/arm/mach-omap2/gpmc.c | ? ?2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
>
Are you sure it fails ?
I just tried booting OMAP4 with 3.4-rc4 and don't see the irq
failure error message. What I am missing ?

Regards
Santosh
