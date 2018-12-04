Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4238FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:32:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E4C2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g9ZWMe0O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="LLAbixH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E4C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1S2nmjwmUAT1E8C0yObB4CAgdaZUzGTm0//GF/EzAPY=; b=g9ZWMe0OotLe/Y
	CZkcdGop4n2KaizaZc2Bksmq2hNagVK5gw1gDvVCOzKoadXj39yg7mJLj7BzBKkQqDF+f9ebnMtGk
	CX8foCyCJNNLcsvoj1c3NtiEX3GbvS1cpKHnPW6Q/v1eNMCFBVwsa+XEW1/OR4+4VeT7ynI+Bk/9L
	5NG1+ofUuUv7UCw+APOzwHhkW4mYmL/7MybUwnIWOi2mdZE0hAW7Qg0Q2+G5bPWxK1LC8VlasJ1hC
	KZRGP7gLLIr+9Nkxot3WllEawXOUSem7U84qgdeLP8t90cGFTPNqP3gZH/rfZ/J91DfGRJn2JLh9V
	fzYAUMj8TRTKqxHgNmRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUAo6-0000Qi-DS; Tue, 04 Dec 2018 13:32:10 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUAo1-0000PC-V0
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 13:32:08 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id A38C14123E;
 Tue,  4 Dec 2018 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1543930305; bh=ldexgRcihljy2ISdtKfo2kOz51Vogrv0PSAZrsAAt8Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LLAbixH/xZcZkDjfEgnCSSzpCni+UXiaqSqlLTRn3hvsPFcarbLJc3uowjkz4Yd+Z
 IxjtYRZxZmU0cWUs1v/9FPEZsyUgu5N2p8jkGWj/rek5Ej7nLEaKsNac/7oUH3YnVF
 AYGbXqlhYNken2b2omGF3g9MA6BSck6ENMFT1TcM88ulgaEjX35qPEJXpH4L4qm9il
 E00RuiwM8SaXGi4F9f6c7MIpKNprVwZ/LCD/7X8TwhMuNBclNy3EIWBdIUWa/AlRPP
 oBDoh/G69rAWqfvB4jwxGJcgLLw2D4G2/RTP4z69mZnpD2VFurvoqTHBRILmRysxl/
 EgJAuEvuqg51A==
Date: Tue, 4 Dec 2018 13:31:44 +0000
From: Priit Laes <plaes@plaes.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 06/14] regulator: axp20x: add software based soft_start
 for AXP209 LDO3
Message-ID: <20181204133144.eqd3dk3jgqm4fbk4@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <41cb1b4dac3a15595c89fa962b78d3f68f370021.1543245984.git-series.plaes@plaes.org>
 <20181127093619.72ensythkx2mhdf5@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181127093619.72ensythkx2mhdf5@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_053206_274389_B521C712 
X-CRM114-Status: GOOD (  26.99  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 10:36:19AM +0100, Maxime Ripard wrote:
> On Mon, Nov 26, 2018 at 05:27:47PM +0200, Priit Laes wrote:
> > From: Olliver Schinagl <oliver@schinagl.nl>
> > =

> > In the past, there have been words on various lists that if LDO3 is
> > disabled in u-boot, but enabled in the DTS, the axp209 driver would
> > fail to continue/hang. Several enable/disable patches have been
> > issues to devicetree's in both the kernel and u-boot to address
> > this issue.
> > =

> > What really happened however, was that the AXP209 shuts down without
> > a notice and without setting an interrupt. This is caused when LDO3
> > gets overloaded, for example with large capacitors on the LDO3 output.
> > =

> > Normally, we would expect that AXP209 would source 200 mA as per
> > datasheet and set and trigger an interrupt when being overloaded.
> > For some reason however, this does not happen.
> > =

> > As a work-around, we use the soft-start constraint of the regulator
> > node to first bring up the LDO3 to the lowest possible voltage and
> > then enable the LDO. After that, we can set the requested voltage
> > as usual.
> > =

> > Combining this setting with the regulator-ramp-delay allows LDO3 to
> > enable voltage slowly and staggered, potentially reducing overall
> > inrush current.
> > =

> > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> >  drivers/regulator/axp20x-regulator.c | 57 ++++++++++++++++++++++++++++-
> >  1 file changed, 56 insertions(+), 1 deletion(-)
> > =

> > diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/a=
xp20x-regulator.c
> > index 1d9fa62..e8a895b 100644
> > --- a/drivers/regulator/axp20x-regulator.c
> > +++ b/drivers/regulator/axp20x-regulator.c
> > @@ -14,6 +14,7 @@
> >   */
> >  =

> >  #include <linux/bitops.h>
> > +#include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/init.h>
> >  #include <linux/mfd/axp20x.h>
> > @@ -23,6 +24,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/driver.h>
> > +#include <linux/regulator/machine.h>
> >  #include <linux/regulator/of_regulator.h>
> >  =

> >  #define AXP20X_GPIO0_FUNC_MASK		GENMASK(3, 0)
> > @@ -430,6 +432,59 @@ static int axp20x_set_ramp_delay(struct regulator_=
dev *rdev, int ramp)
> >  	return regmap_update_bits(axp20x->regmap, reg, mask, cfg);
> >  }
> >  =

> > +static int axp20x_regulator_enable_regmap(struct regulator_dev *rdev)
> > +{
> > +	struct axp20x_dev *axp20x =3D rdev_get_drvdata(rdev);
> > +	const struct regulator_desc *desc =3D rdev->desc;
> > +
> > +	if (!rdev)
> > +		return -EINVAL;
> > +
> > +	switch (axp20x->variant) {
> > +	case AXP209_ID:
> > +		if ((desc->id =3D=3D AXP20X_LDO3) &&
> > +		    rdev->constraints && rdev->constraints->soft_start) {
> > +			int v_out;
> > +			int ret;
> > +
> > +			/*
> > +			 * On some boards, the LDO3 can be overloaded when
> > +			 * turning on, causing the entire PMIC to shutdown
> > +			 * without warning. Turning it on at the minimal voltage
> > +			 * and then setting the voltage to the requested value
> > +			 * works reliably.
> > +			 */
> > +			if (regulator_is_enabled_regmap(rdev))
> > +				break;
> > +
> > +			v_out =3D regulator_get_voltage_sel_regmap(rdev);
> > +			if (v_out < 0)
> > +				return v_out;
> > +
> > +			if (v_out =3D=3D 0)
> > +				break;
> > +
> > +			ret =3D regulator_set_voltage_sel_regmap(rdev, 0x00);
> > +			/*
> > +			 * A small pause is needed between
> > +			 * setting the voltage and enabling the LDO to give the
> > +			 * internal state machine time to process the request.
> > +			 */
> > +			usleep_range(1000, 5000);
> > +			ret |=3D regulator_enable_regmap(rdev);
> > +			ret |=3D regulator_set_voltage_sel_regmap(rdev, v_out);
> > +
> > +			return ret;
> > +		}
> > +		break;
> > +	default:
> > +		/* No quirks */
> > +		break;
> > +	}
> > +
> > +	return regulator_enable_regmap(rdev);
> > +};
> > +
> =

> This is some pretty generic code, and could be useful to some other
> users. I guess a generic function would be better for this.

Yes, makes sense. Although, should we then also distinguish between
regulators which support soft-start in hardware and devices which emulate
it by delay, like in this case?


P=E4ikest,
Priit


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
