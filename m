From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 23 Feb 2012 19:18:28 +0530
Subject: [PATCH 2/6] ARM: OMAP4 PM: Add IO Daisychain support
In-Reply-To: <1330003320-17400-3-git-send-email-t-kristo@ti.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
 <1330003320-17400-3-git-send-email-t-kristo@ti.com>
Message-ID: <CAMQu2gxWYVPMBkj0oD=Cj5r1O+X4Y-Lgpntsvc+Jxj3X6XyviQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 6:51 PM, Tero Kristo <t-kristo@ti.com> wrote:
> From: Rajendra Nayak <rnayak@ti.com>
>
> patch adds IO Daisychain support for OMAP4 as per section 3.9.4 in OMAP4430
> Public TRM.
>
A brief about IO daisy in changelog would be good apart from TRM reference.

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> ?arch/arm/mach-omap2/prm44xx.c | ? 32 ++++++++++++++++++++++++++++++++
> ?arch/arm/mach-omap2/prm44xx.h | ? ?1 +
> ?2 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> index 33dd655..1557647 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -230,6 +230,41 @@ void omap44xx_prm_restore_irqen(u32 *saved_mask)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
> ?}
>
> +/**
> + * Maximum time(us) it takes to output the signal WUCLKOUT of the last pad of
> + * the I/O ring after asserting WUCLKIN high
> + */
> +#define MAX_IOPAD_LATCH_TIME 1000
> +
Is the 1000 us/ms ?
Is that documented or arbitrary chosen ?

Rest of the change looks good to me.

regards
santosh
