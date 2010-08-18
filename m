From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 18 Aug 2010 12:23:52 +0800
Subject: [PATCH] ARM: pxa/pwm: Make id const in pwm_probe()
In-Reply-To: <1281593908-30448-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1281593908-30448-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTin8DKw9q2mQfOWQAi77Ur5OWj+-CLHydBvkb6mz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/12 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> This fixes the compiler warning:
>
> ? ? ? ?arch/arm/plat-pxa/pwm.c: In function 'pwm_probe':
> ? ? ? ?arch/arm/plat-pxa/pwm.c:179: warning: initialization discards qualifiers from pointer target type
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied.

> ---
> ?arch/arm/plat-pxa/pwm.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/pwm.c b/arch/arm/plat-pxa/pwm.c
> index 0732c6c..ef32686 100644
> --- a/arch/arm/plat-pxa/pwm.c
> +++ b/arch/arm/plat-pxa/pwm.c
> @@ -176,7 +176,7 @@ static inline void __add_pwm(struct pwm_device *pwm)
>
> ?static int __devinit pwm_probe(struct platform_device *pdev)
> ?{
> - ? ? ? struct platform_device_id *id = platform_get_device_id(pdev);
> + ? ? ? const struct platform_device_id *id = platform_get_device_id(pdev);
> ? ? ? ?struct pwm_device *pwm, *secondary = NULL;
> ? ? ? ?struct resource *r;
> ? ? ? ?int ret = 0;
> --
> 1.7.1
>
>
