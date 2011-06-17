From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 17 Jun 2011 23:07:59 +0800
Subject: [PATCH] collie: don't read GPSR
In-Reply-To: <1308319892-13057-1-git-send-email-dbaryshkov@gmail.com>
References: <1308319892-13057-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <BANLkTikgNuovqVax-KdYjx1FM3kGCH4dDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Would it be better to switch to use gpio_* API instead of manipulating
GPxR directly?

On Fri, Jun 17, 2011 at 10:11 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> On StrongARM GPSR is write-only according to docs, so don't read from
> it. Just set the required GPIO.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> ?arch/arm/mach-sa1100/collie.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
> index f28025e..3f32ba2 100644
> --- a/arch/arm/mach-sa1100/collie.c
> +++ b/arch/arm/mach-sa1100/collie.c
> @@ -339,7 +339,7 @@ static void __init collie_init(void)
>
> ? ? ? ?PCFR = PCFR_OPDE;
>
> - ? ? ? GPSR |= _COLLIE_GPIO_UCB1x00_RESET;
> + ? ? ? GPSR = _COLLIE_GPIO_UCB1x00_RESET;
>
>
> ? ? ? ?platform_scoop_config = &collie_pcmcia_config;
> --
> 1.7.5.3
>
>
