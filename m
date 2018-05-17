From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Thu, 17 May 2018 09:57:50 +0900
Subject: [PATCH] media: helene: fix tuning frequency of satellite
In-Reply-To: <CAK3bHNUVqd2GODY3k4fzWwtZkZZKMH5Qxs+oiWCODcU9gdYK0A@mail.gmail.com>
References: <20180516084111.28618-1-suzuki.katsuhiro@socionext.com>
 <CAK3bHNUVqd2GODY3k4fzWwtZkZZKMH5Qxs+oiWCODcU9gdYK0A@mail.gmail.com>
Message-ID: <000601d3ed7a$145a94b0$3d0fbe10$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Abylay,

> -----Original Message-----
> From: Abylay Ospan <aospan@netup.ru>
> Sent: Wednesday, May 16, 2018 7:56 PM
> To: Suzuki, Katsuhiro/?? ?? <suzuki.katsuhiro@socionext.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>; linux-media
> <linux-media@vger.kernel.org>; Masami Hiramatsu <masami.hiramatsu@linaro.org>;
> Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH] media: helene: fix tuning frequency of satellite
> 
> True.
> I'm curious but how did it worked before ...
> Which hardware (dvb adapter) are you using ?
> 

I'm using evaluation boards of my company. So it's not exist in market...
Tuner module is SONY SUT-PJ series for ISDB-S/ISDB-T (not for DVB).

Regards,
--
Katsuhiro Suzuki


> 2018-05-16 4:41 GMT-04:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com
> <mailto:suzuki.katsuhiro@socionext.com> >:
> 
> 
> 	This patch fixes tuning frequency of satellite to kHz. That as same
> 	as terrestrial one.
> 
> 	Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com
> <mailto:suzuki.katsuhiro@socionext.com> >
> 	---
> 	 drivers/media/dvb-frontends/helene.c | 2 +-
> 	 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 	diff --git a/drivers/media/dvb-frontends/helene.c
> b/drivers/media/dvb-frontends/helene.c
> 	index 04033f0c278b..0a4f312c4368 100644
> 	--- a/drivers/media/dvb-frontends/helene.c
> 	+++ b/drivers/media/dvb-frontends/helene.c
> 	@@ -523,7 +523,7 @@ static int helene_set_params_s(struct dvb_frontend *fe)
> 	        enum helene_tv_system_t tv_system;
> 	        struct dtv_frontend_properties *p = &fe->dtv_property_cache;
> 	        struct helene_priv *priv = fe->tuner_priv;
> 	-       int frequencykHz = p->frequency;
> 	+       int frequencykHz = p->frequency / 1000;
> 	        uint32_t frequency4kHz = 0;
> 	        u32 symbol_rate = p->symbol_rate/1000;
> 
> 	--
> 	2.17.0
> 
> 
> 
> 
> 
> 
> --
> 
> Abylay Ospan,
> NetUP Inc.
> http://www.netup.tv <http://www.netup.tv/>
