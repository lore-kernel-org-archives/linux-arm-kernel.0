Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EC6C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:38:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B65F2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MUiLgdnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B65F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pVnHJmaFuDW+8N57pjxgbIyLGH4CRaebW837MiI0k1M=; b=MUiLgdnOSyjFysw/JP4aFWig3
	h2xNEYaMDVVgpPVkcaf4BtZz/JwKn7s4XIJEmAdaYwcVPPjMYbQTcFtJZeB7ocdZ5EpxbsDbT6ZOX
	LDmkCAmTF8OIRtuHkRzF5m6l0e0JBuuKwNOEXp2vvN8wrGzASt/ANKnKy1ED6h/xGX04apwxeQ15r
	OqLR/T++VdOR+BSw0KJvOKTx29TOgsumCbRlp8Xi1YvCwdHKIf9/Oq/05sd4WUIrbwywFDzPm/vMP
	RzcqDBkb4W6QOt8RMaWiuiIhOpk0E0VSUTlR7VtUSHNRWeWz3fvy5fA7gjcfPhWzIypiDrUHWwruO
	SuaaWOb8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlch-00043m-CJ; Mon, 03 Dec 2018 10:38:43 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlca-0003sc-G0
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:38:40 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CD0CD20CFB; Mon,  3 Dec 2018 11:38:24 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 95F2720786;
 Mon,  3 Dec 2018 11:38:14 +0100 (CET)
Date: Mon, 3 Dec 2018 11:38:14 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Hao Zhang <hao5781286@gmail.com>
Subject: Re: [PATCH v3 6/6] ARM: PWM: add allwinner sun8i R40/T3/V40 PWM
 support.
Message-ID: <20181203103814.go7f6pftigmpb7md@flea>
References: <20181125162319.GA5422@arx-s1>
 <20181127080733.4e6rljjta3azf2rf@flea>
 <CAJeuY7-U=EF_FCe2jmBB-Otuemp_rcMPs=g7ipPi=YP4qy5mtg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJeuY7-U=EF_FCe2jmBB-Otuemp_rcMPs=g7ipPi=YP4qy5mtg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_023837_198658_9FC93AD7 
X-CRM114-Status: GOOD (  24.92  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
 sboyd@kernel.org, mturquette@baylibre.com, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, wens@csie.org,
 robh+dt@kernel.org, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7558774922776101472=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7558774922776101472==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jarscmyeczx74665"
Content-Disposition: inline


--jarscmyeczx74665
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 01, 2018 at 11:23:40PM +0800, Hao Zhang wrote:
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index 504d252..6105ac8 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -426,7 +426,7 @@ config PWM_STMPE
> > >         expanders.
> > >
> > >  config PWM_SUN4I
> > > -     tristate "Allwinner PWM support"
> > > +     tristate "Allwinner SUN4I PWM support"
> >
> > That should be a separate patch.
> >
> > (also, your patch series don't seem to have the threading properly
> > configured, you might want to fix that.)
>
> Do you mean i should fix it like this ?
> config sunxi pwm
> |
> |---->config PWM_SUN4I
> |---->config PWM_SUN8I_R40

No, I meant for your mails, sorry. Each patch should be sent in reply
to your cover letter, and they are all sent as separate mails, which
makes it hard to track.

I'm not sure how you're sending your patches, but using git send-email
this would be using --no-chain-reply-to --thread if I remember well.

> > >  config PWM_TEGRA
> > >       tristate "NVIDIA Tegra PWM support"
> > >       depends on ARCH_TEGRA
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index 9c676a0..32c8d2d 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_STM32)             +=3D pwm-stm32.o
> > >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> > >  obj-$(CONFIG_PWM_STMPE)              +=3D pwm-stmpe.o
> > >  obj-$(CONFIG_PWM_SUN4I)              +=3D pwm-sun4i.o
> > > +obj-$(CONFIG_PWM_SUN8I)              +=3D pwm-sun8i.o
> > >  obj-$(CONFIG_PWM_TEGRA)              +=3D pwm-tegra.o
> > >  obj-$(CONFIG_PWM_TIECAP)     +=3D pwm-tiecap.o
> > >  obj-$(CONFIG_PWM_TIEHRPWM)   +=3D pwm-tiehrpwm.o
> > > diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
> > > new file mode 100644
> > > index 0000000..d8597e4
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-sun8i.c
> > > @@ -0,0 +1,418 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +// Copyright (C) 2018 Hao Zhang <hao5781286@gmail.com>
> > > +
> > > +#include <linux/bitops.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/time.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#define PWM_IRQ_ENABLE_REG   0x0000
> > > +#define PCIE(ch)             BIT(ch)
> > > +
> > > +#define PWM_IRQ_STATUS_REG   0x0004
> > > +#define PIS(ch)                      BIT(ch)
> > > +
> > > +#define CAPTURE_IRQ_ENABLE_REG       0x0010
> > > +#define CRIE(ch)             BIT((ch) * 2)
> > > +#define CFIE(ch)             BIT((ch) * 2 + 1)
> > > +
> > > +#define CAPTURE_IRQ_STATUS_REG       0x0014
> > > +#define CRIS(ch)             BIT((ch) * 2)
> > > +#define CFIS(ch)             BIT((ch) * 2 + 1)
> > > +
> > > +#define CLK_CFG_REG(ch)              (0x0020 + ((ch) >> 1) * 4)
> > > +#define CLK_SRC_SEL          GENMASK(8, 7)
> > > +#define CLK_SRC_BYPASS_SEC   BIT(6)
> > > +#define CLK_SRC_BYPASS_FIR   BIT(5)
> > > +#define CLK_GATING           BIT(4)
> > > +#define CLK_DIV_M            GENMASK(3, 0)
> > > +
> > > +#define PWM_DZ_CTR_REG(ch)   (0x0030 + ((ch) >> 1) * 4)
> > > +#define PWM_DZ_INTV          GENMASK(15, 8)
> > > +#define PWM_DZ_EN            BIT(0)
> > > +
> > > +#define PWM_ENABLE_REG               0x0040
> > > +#define PWM_EN(ch)           BIT(ch)
> > > +
> > > +#define CAPTURE_ENABLE_REG   0x0044
> > > +#define CAP_EN(ch)           BIT(ch)
> > > +
> > > +#define PWM_CTR_REG(ch)              (0x0060 + (ch) * 0x20)
> > > +#define PWM_PERIOD_RDY               BIT(11)
> > > +#define PWM_PUL_START                BIT(10)
> > > +#define PWM_MODE             BIT(9)
> > > +#define PWM_ACT_STA          BIT(8)
> > > +#define PWM_PRESCAL_K                GENMASK(7, 0)
> > > +
> > > +#define PWM_PERIOD_REG(ch)   (0x0064 + (ch) * 0x20)
> > > +#define PWM_ENTIRE_CYCLE     GENMASK(31, 16)
> > > +#define PWM_ACT_CYCLE                GENMASK(15, 0)
> > > +
> > > +#define PWM_CNT_REG(ch)              (0x0068 + (ch) * 0x20)
> > > +#define PWM_CNT_VAL          GENMASK(15, 0)
> > > +
> > > +#define CAPTURE_CTR_REG(ch)  (0x006c + (ch) * 0x20)
> > > +#define CAPTURE_CRLF         BIT(2)
> > > +#define CAPTURE_CFLF         BIT(1)
> > > +#define CAPINV                       BIT(0)
> > > +
> > > +#define CAPTURE_RISE_REG(ch) (0x0070 + (ch) * 0x20)
> > > +#define CAPTURE_CRLR         GENMASK(15, 0)
> > > +
> > > +#define CAPTURE_FALL_REG(ch) (0x0074 + (ch) * 0x20)
> > > +#define CAPTURE_CFLR         GENMASK(15, 0)
> > > +
> > > +struct sun8i_pwm_chip {
> > > +     struct pwm_chip chip;
> > > +     struct clk *clk;
> > > +     void __iomem *base;
> > > +     const struct sun8i_pwm_data *data;
> > > +     struct regmap *regmap;
> > > +};
> > > +
> > > +static struct sun8i_pwm_chip *to_sun8i_pwm_chip(struct pwm_chip *chi=
p)
> > > +{
> > > +     return container_of(chip, struct sun8i_pwm_chip, chip);
> > > +}
> > > +
> > > +static u32 sun8i_pwm_read(struct sun8i_pwm_chip *sun8i_pwm,
> > > +                       unsigned long offset)
> > > +{
> > > +     u32 val;
> > > +
> > > +     regmap_read(sun8i_pwm->regmap, offset, &val);
> > > +     return val;
> > > +}
> > > +
> > > +static void sun8i_pwm_set_bit(struct sun8i_pwm_chip *sun8i_pwm,
> > > +                           unsigned long reg, u32 bit)
> > > +{
> > > +     regmap_update_bits(sun8i_pwm->regmap, reg, bit, bit);
> > > +}
> > > +
> > > +static void sun8i_pwm_clear_bit(struct sun8i_pwm_chip *sun8i_pwm,
> > > +                             unsigned long reg, u32 bit)
> > > +{
> > > +     regmap_update_bits(sun8i_pwm->regmap, reg, bit, 0);
> > > +}
> > > +
> > > +static void sun8i_pwm_set_value(struct sun8i_pwm_chip *sun8i_pwm,
> > > +                             unsigned long reg, u32 mask, u32 val)
> > > +{
> > > +     regmap_update_bits(sun8i_pwm->regmap, reg, mask, val);
> > > +}
> > > +
> > > +static void sun8i_pwm_set_polarity(struct sun8i_pwm_chip *chip, u32 =
ch,
> > > +                                enum pwm_polarity polarity)
> > > +{
> > > +     if (polarity =3D=3D PWM_POLARITY_NORMAL)
> > > +             sun8i_pwm_set_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
> > > +     else
> > > +             sun8i_pwm_clear_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
> > > +}
> > > +
> > > +static int sun8i_pwm_config(struct sun8i_pwm_chip *sun8i_pwm, u8 ch,
> > > +                         struct pwm_state *state)
> > > +{
> > > +     u64 clk_rate, clk_div, val;
> > > +     u16 prescaler =3D 0;
> > > +     u16 div_id =3D 0;
> > > +     struct clk *clk;
> > > +     bool is_clk;
> > > +     int ret;
> > > +
> > > +     clk_rate =3D clk_get_rate(sun8i_pwm->clk);
> > > +
> > > +     /* check period and select clock source */
> > > +     val =3D state->period * clk_rate;
> > > +     do_div(val, NSEC_PER_SEC);
> > > +     is_clk =3D devm_clk_name_match(sun8i_pwm->clk, "mux-0");
> > > +     if (val <=3D 1 && is_clk) {
> > > +             clk =3D devm_clk_get(sun8i_pwm->chip.dev, "mux-1");
> > > +             if (IS_ERR(clk)) {
> > > +                     dev_err(sun8i_pwm->chip.dev,
> > > +                             "Period expects a larger value\n");
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             clk_rate =3D clk_get_rate(clk);
> > > +             val =3D state->period * clk_rate;
> > > +             do_div(val, NSEC_PER_SEC);
> > > +             if (val <=3D 1) {
> > > +                     dev_err(sun8i_pwm->chip.dev,
> > > +                             "Period expects a larger value\n");
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             /* change clock source to "mux-1" */
> > > +             clk_disable_unprepare(sun8i_pwm->clk);
> > > +             devm_clk_put(sun8i_pwm->chip.dev, sun8i_pwm->clk);
> > > +             sun8i_pwm->clk =3D clk;
> > > +
> > > +             ret =3D clk_prepare_enable(sun8i_pwm->clk);
> > > +             if (ret) {
> > > +                     dev_err(sun8i_pwm->chip.dev,
> > > +                             "Failed to enable PWM clock\n");
> > > +                     return ret;
> > > +             }
> > > +
> > > +     } else {
> > > +             dev_err(sun8i_pwm->chip.dev,
> > > +                     "Period expects a larger value\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     is_clk =3D devm_clk_name_match(sun8i_pwm->clk, "mux-0");
> > > +     if (is_clk)
> > > +             sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
> > > +                                 CLK_SRC_SEL, 0 << 7);
> > > +     else
> > > +             sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
> > > +                                 CLK_SRC_SEL, 1 << 7);
> > > +
> > > +     dev_info(sun8i_pwm->chip.dev, "clock source freq:%lldHz\n", clk=
_rate);
> >
> > This is pretty much reimplementing the clock framework. I guess you'd
> > be better off just modeling this clock as a clock registered in the
> > framework. It will take care by itself of the combination of muxing
> > and rate, and making sure the parent clocks are properly enabled when
> > needed.
>
> Do you mean i should move it to ccu clock framwork?

You don't need to move it anywhere, you can declare a clock in a
driver, without being in drivers/clk. We're doing that in the DRM or
the RTC drivers for example.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jarscmyeczx74665
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAUHlgAKCRDj7w1vZxhR
xSEZAP9s8GQnJF+F077xd0Pq69DcSkeNw88GOn6HtaBuoeDbZQD/YuWukaV1aKg7
LURT/DdEqaEHNz9Mw07ocPZNgPG+SQU=
=P+LB
-----END PGP SIGNATURE-----

--jarscmyeczx74665--


--===============7558774922776101472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7558774922776101472==--

