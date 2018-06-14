From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Thu, 14 Jun 2018 16:27:31 +0900
Subject: [RESEND PATCH] media: helene: fix tuning frequency of satellite
In-Reply-To: <20180529010640.18604-1-suzuki.katsuhiro@socionext.com>
References: <20180529010640.18604-1-suzuki.katsuhiro@socionext.com>
Message-ID: <00c701d403b1$28015e20$78041a60$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

This patch is wrong, I got a mistake.

DTV_FREQUENCY for satellite delivery systems, the frequency is in 'kHz' not 'Hz',
so original code is correct. 

Please forget this patch. Sorry for confusing...


Regards,
--
Katsuhiro Suzuki

> -----Original Message-----
> From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Sent: Tuesday, May 29, 2018 10:07 AM
> To: Abylay Ospan <aospan@netup.ru>; Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org>; linux-media at vger.kernel.org
> Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>; Jassi Brar
> <jaswinder.singh@linaro.org>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; Suzuki, Katsuhiro/?? ??
> <suzuki.katsuhiro@socionext.com>
> Subject: [RESEND PATCH] media: helene: fix tuning frequency of satellite
> 
> This patch fixes tuning frequency of satellite to kHz. That as same
> as terrestrial one.
> 
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---
>  drivers/media/dvb-frontends/helene.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-frontends/helene.c
> b/drivers/media/dvb-frontends/helene.c
> index 04033f0c278b..0a4f312c4368 100644
> --- a/drivers/media/dvb-frontends/helene.c
> +++ b/drivers/media/dvb-frontends/helene.c
> @@ -523,7 +523,7 @@ static int helene_set_params_s(struct dvb_frontend *fe)
>  	enum helene_tv_system_t tv_system;
>  	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
>  	struct helene_priv *priv = fe->tuner_priv;
> -	int frequencykHz = p->frequency;
> +	int frequencykHz = p->frequency / 1000;
>  	uint32_t frequency4kHz = 0;
>  	u32 symbol_rate = p->symbol_rate/1000;
> 
> --
> 2.17.0
