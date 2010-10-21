From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 21 Oct 2010 21:47:46 +0400
Subject: [PATCH] ARM: SAMSUNG: Add the missed s3c_gpio_getpull() API
In-Reply-To: <1287648286-7202-1-git-send-email-kgene.kim@samsung.com>
References: <1287648286-7202-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <4CC07CC2.50206@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 21-10-2010 12:04, Kukjin Kim wrote:

> From: Daein Moon<moon9124@samsung.com>

> This patch adds the s3c_gpio_getpull() API that has been missed in the
> plat-samsung/gpio-config.c and actullay there is its extern declaration
> in plat/gpio-cfg.h.

> Signed-off-by: Daein Moon<moon9124@samsung.com>
> Cc: Ben Dooks<ben-linux@fluff.org>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> ---
> NOTE:
> - already issued about this

>   arch/arm/plat-samsung/gpio-config.c                |   19 +++++++++++++++++++
>   .../plat-samsung/include/plat/gpio-cfg-helpers.h   |    6 ++++++
>   2 files changed, 25 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
> index 8a37211..b732b77 100644
> --- a/arch/arm/plat-samsung/gpio-config.c
> +++ b/arch/arm/plat-samsung/gpio-config.c
[...]
> diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
> index 3e21c75..c417f85 100644
> --- a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
> +++ b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
> @@ -42,6 +42,12 @@ static inline int s3c_gpio_do_setpull(struct s3c_gpio_chip *chip,
>   	return (chip->config->set_pull)(chip, off, pull);
>   }
>
> +static inline unsigned s3c_gpio_do_getpull(struct s3c_gpio_chip *chip,
> +					   unsigned int off)
> +{
> +	return (chip->config->get_pull)(chip, off);

    Parens are not necessary here.

> +}
> +

WBR, Sergei
