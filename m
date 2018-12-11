Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4449BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:15:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E06820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n33UV9zU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uClpNe9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E06820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c9a4ae1kBqt4HnzZOusQmRg0OJlFgFG4y0BZxLkVfMw=; b=n33UV9zUOKKfsx
	nPl0oQlEdov11lXKmUVcLntBlcCwU1LbSSQdIAq+4Qx4fhen0CVbVVny83q5/X42CRZEuscCqhSGC
	CFcRw6sp/6P2iaH6Bcf5AzhhN7HQKwGg4bRE3pOxPw0XlXQMxlq08v3wriXOX+SsBmmM3ZPcWe0Bq
	dHhFfiC0+/uGB6Oc7yuX8i/4CLbej6YIV09+XEm24wt8wNwxvSYO55eXOc2WKh28UhfJm6FgJEv21
	da5yS4bu/L9JaqH3gw6W9PO77RKkvhRX/9a5YrR4oz+DFR42S/bVXb1jF3LKfnNnKPoX5iRnjVR25
	qOTCAhL/XgDmK/Sx6SLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhsk-0004VI-Cq; Tue, 11 Dec 2018 13:15:26 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhsf-0004UI-CU
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:15:24 +0000
Received: by mail-wm1-x341.google.com with SMTP id y139so2146247wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 05:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dphSfbsjSZj33H3I+CK/0LfW2iFi3OYhO56M6vIsI50=;
 b=uClpNe9asttjvszCUsiV39H8Kgodo4oqJgCRPMw+72bAyVpIDkAi3sXtXLQP2MJFY/
 zNdOnmADxjZicTFHZksyLXmUhHdmI3/MRDWzPzcqyQabE6ZO/BDKuJoOQ4f4aoc+DNvv
 WA/fPVRnfXq43ih4iGYL/9l+JQHDr7Fe+6FDgjxoonBGtI93cJGh1oDSqcj7h9m1bxEH
 QOm3YbeBcHOZSFaxMXQ15T9+K+eBuWLh08A7FFsAwDBHHKskoPTdhY3cvU8b7J3Cx2sX
 vsd6VL4whnBcnOtJLNqkQBEj9WR/XZN3ouTRzRUO9n4+hF7XWXuiBLOShI8xkt6Q+DyN
 Gw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dphSfbsjSZj33H3I+CK/0LfW2iFi3OYhO56M6vIsI50=;
 b=WVwGdXL4I1nwn5IZ9r2skEc/mjJUH6+KKo+wZUcmpv22yAER+/e1rmNMWHKXbheKiq
 ARXWOairLughvFckHI7miyZ9xhnFI+x2czAyeIWY5XrZh6dBF4Vsl+s29II8e94F0YHy
 o/WFBkHoq62idJhiP3bGUYG8elwmLzmOsMuyaO/LdCV3uXYN39kemtXSI8vo6vLdcm6G
 B9olvcRTIkRLYddquM4yFgPVcqvdgEVoEkjLzc2oWtokRPx8OnKrel+fl7ZAi3sHhKRR
 kpI4pstYmFO9b6uIUeLzmMrkaFAcGcoDrRJvW7dI/icBj3kHd/RgRH3HnJ+Mvw9wKSC7
 Rwfg==
X-Gm-Message-State: AA+aEWZAW4eE7Y1cvu5u8jBl6jmK6nL9PMRnoMJdKR1m9Nbl8uF6vZe1
 LeSCWyRru70xlnHcNlIsAA/r7LLDbpAgbT5nJ7I=
X-Google-Smtp-Source: AFSGD/Ub6247rZwplT7MfSNoqPP6WOkVdPxpyXyIXLPWhmqCoOQzWXcvFwkKfkgiqpPSoifQfbsJJU670NPvet2pIVo=
X-Received: by 2002:a1c:58ce:: with SMTP id m197mr2375364wmb.31.1544534109240; 
 Tue, 11 Dec 2018 05:15:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
 <2bfe47f173fe72a30b0036dcdeebc2123962ff33.1544466940.git-series.plaes@plaes.org>
In-Reply-To: <2bfe47f173fe72a30b0036dcdeebc2123962ff33.1544466940.git-series.plaes@plaes.org>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 12 Dec 2018 00:14:57 +1100
Message-ID: <CAGRGNgX2d4u0HP2xLxcGhH2QkN-GdYZf4iKV_XAn53A8z0y8JQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/8] regulator: axp20x: add support for
 set_ramp_delay for AXP209
To: Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_051521_450831_C9B86EC2 
X-CRM114-Status: GOOD (  23.07  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Mark Brown <broonie@kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Lee Jones <lee.jones@linaro.org>, "Mailing List,
 Arm" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Priit and Olliver,

On Tue, Dec 11, 2018 at 5:42 AM Priit Laes <plaes@plaes.org> wrote:
>
> From: Olliver Schinagl <oliver@schinagl.nl>
>
> The AXP209 supports ramping up voltages on several regulators such as
> DCDC2 and LDO3.
>
> This patch adds preliminary support for the regulator-ramp-delay property
> for these 2 regulators. Note that the voltage ramp only works when
> regulator is already enabled. E.g. when going from say 0.7 V to 3.6 V.
>
> When turning on the regulator, no voltage ramp is performed in hardware.
>
> What this means, is that if the bootloader brings up the voltage at 0.7 V,
> the ramp delay property is properly applied. If however, the bootloader
> leaves the power off, no ramp delay is applied when the power is
> enabled by the regulator framework.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/regulator/axp20x-regulator.c | 85 +++++++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 9a2db28..1d9fa62 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -346,6 +357,79 @@
>                 .ops            = &axp20x_ops_range,                            \
>         }
>
> +static const int axp209_dcdc2_ldo3_slew_rates[] = {
> +       1600,
> +        800,
> +};
> +
> +static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
> +{
> +       struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
> +       const struct regulator_desc *desc = rdev->desc;
> +       u8 reg, mask, enable, cfg = 0xff;
> +       const int *slew_rates;
> +       int rate_count = 0;
> +
> +       if (!rdev)
> +               return -EINVAL;
> +
> +       switch (axp20x->variant) {
> +       case AXP209_ID:
> +               if (desc->id == AXP20X_DCDC2) {

Is slew_rates supposed to be set here?

> +                       rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
> +                       reg = AXP20X_DCDC2_LDO3_V_RAMP;
> +                       mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
> +                              AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
> +                       enable = (ramp > 0) ?
> +                                AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN :
> +                                !AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN;
> +                       break;
> +               }
> +
> +               if (desc->id == AXP20X_LDO3) {
> +                       slew_rates = axp209_dcdc2_ldo3_slew_rates;
> +                       rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
> +                       reg = AXP20X_DCDC2_LDO3_V_RAMP;
> +                       mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
> +                              AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
> +                       enable = (ramp > 0) ?
> +                                AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN :
> +                                !AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN;
> +                       break;
> +               }
> +
> +               if (rate_count > 0)
> +                       break;

You could save one to two tests by combining the above three if statements, i.e.

if (DCDC2) {
    // set DCDC2 stuff

    break;
} else if (LDO3) {
    // set LDO3 stuff

    break;
}

As written, the rate_count > 0 test will never be true as every block
that sets rate_count breaks out of the switch block.

You could then calculate rate_count below the switch block.

> +
> +               /* fall through */
> +       default:
> +               /* Not supported for this regulator */
> +               return -ENOTSUPP;
> +       }
> +
> +       if (ramp == 0) {
> +               cfg = enable;
> +       } else {
> +               int i;
> +
> +               for (i = 0; i < rate_count; i++) {
> +                       if (ramp <= slew_rates[i])
> +                               cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
> +                       else
> +                               break;
> +               }
> +
> +               if (cfg == 0xff) {
> +                       dev_err(axp20x->dev, "unsupported ramp value %d", ramp);
> +                       return -EINVAL;
> +               }
> +
> +               cfg |= enable;
> +       }
> +
> +       return regmap_update_bits(axp20x->regmap, reg, mask, cfg);
> +}
> +



-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
