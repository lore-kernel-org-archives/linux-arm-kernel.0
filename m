Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22874C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7122086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HniHn9XO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="BKjpZ/3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7122086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+bcrw8C7yqKAti2eT/y/jKvlwwNqP/djxDvgbGQZkoA=; b=HniHn9XOs+uweM
	Rh8fEN9MkwWMfD2njv/COrwqueeWnBmc8lBVb6i2E4d0HD6LXWQ6X/5XVx3x5ikolT2P9SkcFKJmb
	vxuxutOxgadZVYmukJ4EbfGD0G16QwuIS3/zTPL8O9PnZrVDfuHsAJfAGGQLKxHfzcv563qIS1lzE
	CqwxJhiUpGQT50NYMgVGamvCpQbljfX2XnYmi1yGsQXCUuT2k6RMO3Q1mwUi5ks7p7cmFGdV0Li8A
	NJ5GQgVGzeVMGIap1kD0CrlApoQYcGY3l+57xlQN1PTl/iVXDKKdE+Y/mC2Uxkn6OJHvfnos/+Vnb
	hZY9P2xU4P6mJ02hhCAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX2Ic-0007ck-HE; Wed, 12 Dec 2018 11:03:30 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX2IY-0007UH-C0
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:03:28 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 11B5B4002F;
 Wed, 12 Dec 2018 11:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544612561; bh=+m/J/LdEoB7yH5+0QKj58UFvsrQ/4y3ZgsEYLt8GLLU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BKjpZ/3VdeqxA5BcXQ96MHI+NXYHzMmoD4RQdZgEYmkz+hakWnSg9RjKqWsYdf5To
 yPcwwsGgw+tvIwdWle3Cg9M86hid2SW1GHLbJRO/2/cIwIbkOnp9g4jhquHltWojSs
 Km8ENaH68YM7Ctv05EOFN0S5C6HnxUkeyC3Oc9dSa1g0Nt+YJCDCvChgiuwoVT8G5l
 hnX4uyf/Ks6dpsQQ89PpU8FyyXE7uVAQD1mMx1cZHMom2/IxdZ4HY8craDlJZ2x7Vl
 S0UzNDlhYbnooEN45F4C1sK66sKQeoJv/DdTn+MhHfCMJDI9e6yi+hIZxD91qHXE+r
 uODAwqAxt0mpQ==
Date: Wed, 12 Dec 2018 11:02:40 +0000
From: Priit Laes <plaes@plaes.org>
To: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/8] regulator: axp20x: add support for
 set_ramp_delay for AXP209
Message-ID: <20181212110239.uizmnldvluf4dlng@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
 <2bfe47f173fe72a30b0036dcdeebc2123962ff33.1544466940.git-series.plaes@plaes.org>
 <CAGRGNgX2d4u0HP2xLxcGhH2QkN-GdYZf4iKV_XAn53A8z0y8JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGRGNgX2d4u0HP2xLxcGhH2QkN-GdYZf4iKV_XAn53A8z0y8JQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_030326_686841_0B17196F 
X-CRM114-Status: GOOD (  26.06  )
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
 devicetree <devicetree@vger.kernel.org>, Olliver Schinagl <oliver@schinagl.nl>,
 Mark Brown <broonie@kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 12:14:57AM +1100, Julian Calaby wrote:
> Hi Priit and Olliver,
> 
> On Tue, Dec 11, 2018 at 5:42 AM Priit Laes <plaes@plaes.org> wrote:
> >
> > From: Olliver Schinagl <oliver@schinagl.nl>
> >
> > The AXP209 supports ramping up voltages on several regulators such as
> > DCDC2 and LDO3.
> >
> > This patch adds preliminary support for the regulator-ramp-delay property
> > for these 2 regulators. Note that the voltage ramp only works when
> > regulator is already enabled. E.g. when going from say 0.7 V to 3.6 V.
> >
> > When turning on the regulator, no voltage ramp is performed in hardware.
> >
> > What this means, is that if the bootloader brings up the voltage at 0.7 V,
> > the ramp delay property is properly applied. If however, the bootloader
> > leaves the power off, no ramp delay is applied when the power is
> > enabled by the regulator framework.
> >
> > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> >  drivers/regulator/axp20x-regulator.c | 85 +++++++++++++++++++++++++++++-
> >  1 file changed, 85 insertions(+)
> >
> > diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> > index 9a2db28..1d9fa62 100644
> > --- a/drivers/regulator/axp20x-regulator.c
> > +++ b/drivers/regulator/axp20x-regulator.c
> > @@ -346,6 +357,79 @@
> >                 .ops            = &axp20x_ops_range,                            \
> >         }
> >
> > +static const int axp209_dcdc2_ldo3_slew_rates[] = {
> > +       1600,
> > +        800,
> > +};
> > +
> > +static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
> > +{
> > +       struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
> > +       const struct regulator_desc *desc = rdev->desc;
> > +       u8 reg, mask, enable, cfg = 0xff;
> > +       const int *slew_rates;
> > +       int rate_count = 0;
> > +
> > +       if (!rdev)
> > +               return -EINVAL;
> > +
> > +       switch (axp20x->variant) {
> > +       case AXP209_ID:
> > +               if (desc->id == AXP20X_DCDC2) {
> 
> Is slew_rates supposed to be set here?

Yes, nice catch.
> 
> > +                       rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
> > +                       reg = AXP20X_DCDC2_LDO3_V_RAMP;
> > +                       mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
> > +                              AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
> > +                       enable = (ramp > 0) ?
> > +                                AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN :
> > +                                !AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN;
> > +                       break;
> > +               }
> > +
> > +               if (desc->id == AXP20X_LDO3) {
> > +                       slew_rates = axp209_dcdc2_ldo3_slew_rates;
> > +                       rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
> > +                       reg = AXP20X_DCDC2_LDO3_V_RAMP;
> > +                       mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
> > +                              AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
> > +                       enable = (ramp > 0) ?
> > +                                AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN :
> > +                                !AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN;
> > +                       break;
> > +               }
> > +
> > +               if (rate_count > 0)
> > +                       break;
> 
> You could save one to two tests by combining the above three if statements, i.e.
> 
> if (DCDC2) {
>     // set DCDC2 stuff
> 
>     break;
> } else if (LDO3) {
>     // set LDO3 stuff
> 
>     break;
> }

OK, will look into it.
> 
> As written, the rate_count > 0 test will never be true as every block
> that sets rate_count breaks out of the switch block.

Yes, it is somewhat superfluous, as each regulator which supports ramping
should break out of the switch itself.

> You could then calculate rate_count below the switch block.
>
> > +
> > +               /* fall through */
> > +       default:
> > +               /* Not supported for this regulator */
> > +               return -ENOTSUPP;
> > +       }
> > +
> > +       if (ramp == 0) {
> > +               cfg = enable;
> > +       } else {
> > +               int i;
> > +
> > +               for (i = 0; i < rate_count; i++) {
> > +                       if (ramp <= slew_rates[i])
> > +                               cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
> > +                       else
> > +                               break;
> > +               }
> > +
> > +               if (cfg == 0xff) {
> > +                       dev_err(axp20x->dev, "unsupported ramp value %d", ramp);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               cfg |= enable;
> > +       }
> > +
> > +       return regmap_update_bits(axp20x->regmap, reg, mask, cfg);
> > +}
> > +
> 
> 
> 
> -- 
> Julian Calaby
> 
> Email: julian.calaby@gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
