Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB21C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:57:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EAB2192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ERS3TaHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EAB2192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z0vUdar7gz+1nPfbtnXEeSu6Q3tZLn/vnApif7LfbME=; b=ERS3TaHh/x2aqHSHMaUUZHJMO
	XbAEVFADxPDCwnHGZ+szGir6GL+cLqKL2/c/CJi2OOiFfY/M8pg4M7xWDd41Ow/m8274OG7oiBuVY
	AzMVLdzAkq9QreCwD2VYVbh9iEG/kQpQDQKf8EINnJN/+chLhy8rjXX/LQ62l+xOuPS3HHoblL1NS
	sq8/X3cCVfwP89pi7UwBUGxIp+YYEJI9dfzR1SJH+5qfl/9j1L14x4E0qYEsuChjZ65JE+YgxnTnC
	l47I5OO6O9wEhNewe9C1QfXTYfXTjHvGLGr2ng/heGKHFplE2Bey5sSn5Z/YmyrCCSoOhSD6oQf8E
	TvhYLHqIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufs0-0000v8-BH; Fri, 15 Feb 2019 15:57:44 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufrw-0000uQ-Ec
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:57:42 +0000
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id E04AA24001A;
 Fri, 15 Feb 2019 15:57:32 +0000 (UTC)
Date: Fri, 15 Feb 2019 16:57:32 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Stefan Mavrodiev <stefan@olimex.com>
Subject: Re: [PATCH v2 1/8] leds: Add support for AXP20X CHGLED
Message-ID: <20190215155732.nmtshldcjk2qyhx4@flea>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-2-stefan@olimex.com>
MIME-Version: 1.0
In-Reply-To: <20190215115013.11098-2-stefan@olimex.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075740_786789_0DDB3B1F 
X-CRM114-Status: GOOD (  20.64  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS"
 <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee.jones@linaro.org>,
 "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============9213263184153969245=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============9213263184153969245==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s6rnltusscnwmgci"
Content-Disposition: inline


--s6rnltusscnwmgci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Thanks for working on this.

On Fri, Feb 15, 2019 at 01:50:06PM +0200, Stefan Mavrodiev wrote:
> +static ssize_t control_show(struct device *dev, struct device_attribute =
*attr,
> +			    char *buf)
> +{
> +	struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +	struct axp20x_led *priv =3D to_axp20x_led(cdev);
> +
> +	return sprintf(buf, "%u\n", priv->ctrl);
> +}
> +
> +static ssize_t control_store(struct device *dev, struct device_attribute=
 *attr,
> +			     const char *buf, size_t size)
> +{
> +	struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +	struct axp20x_led *priv =3D to_axp20x_led(cdev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	/**
> +	 * Supported values are:
> +	 *   - 0 : Manual control
> +	 *   - 1 : Charger control
> +	 */
> +	if (val > 1)
> +		return -EINVAL;
> +
> +	priv->ctrl =3D val;
> +
> +	return axp20x_led_setup(priv) ? : size;
> +}
> +static DEVICE_ATTR_RW(control);
> +
> +static ssize_t mode_show(struct device *dev, struct device_attribute *at=
tr,
> +			 char *buf)
> +{
> +	struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +	struct axp20x_led *priv =3D to_axp20x_led(cdev);
> +
> +	return sprintf(buf, "%u\n", priv->mode);
> +}
> +
> +static ssize_t mode_store(struct device *dev, struct device_attribute *a=
ttr,
> +			  const char *buf, size_t size)
> +{
> +	struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +	struct axp20x_led *priv =3D to_axp20x_led(cdev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +	/**
> +	 * Supported values are:
> +	 *   - 0 : Mode A
> +	 *   - 1 : Mode B
> +	 */
> +	if (val > 1)
> +		return -EINVAL;
> +
> +	priv->mode =3D val;
> +
> +	return axp20x_led_setup(priv) ? : size;
> +}
> +static DEVICE_ATTR_RW(mode);
> +
> +static struct attribute *axp20x_led_attrs[] =3D {
> +	&dev_attr_control.attr,
> +	&dev_attr_mode.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(axp20x_led);

I can't really say whether adding sysfs handles for this is the right
thing to do, but if it is you should document the interface.

> +	if (!of_property_read_u8(np, "x-powers,charger-mode", &value)) {
> +		priv->ctrl =3D AXP20X_CHGLED_CTRL_CHARGER;
> +		priv->mode =3D (value < 2) ? value : 0;
> +	} else {
> +		priv->ctrl =3D AXP20X_CHGLED_CTRL_MANUAL;
> +	}

I'm not sure we want to make this a property of the device
tree. Changing the device tree isn't an option for some users, so we
need to make sure we can change it even if we can't change the device
tree.

A kernel module is one option, but the other reviewers might have some
alternatives.

> +	str =3D of_get_property(np, "default-state", NULL);
> +	if (str) {
> +		if (!strcmp(str, "keep")) {
> +			ret =3D axp20x_led_brightness_get(&priv->cdev);
> +			if (ret < 0)
> +				return ret;
> +			priv->cdev.brightness =3D ret;
> +		} else if (!strcmp(str, "on")) {
> +			ret =3D axp20x_led_brightness_set_blocking(&priv->cdev,
> +								 LED_FULL);
> +		} else  {
> +			ret =3D axp20x_led_brightness_set_blocking(&priv->cdev,
> +								 LED_OFF);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id axp20x_led_of_match[] =3D {
> +	{ .compatible =3D "x-powers,axp20x-led" },

Having a wildcard in the compatible isn't great, since it doesn't
really allow you to identify which part it is you're actually using,
and that wildcard might become inconsistent at some point.

You'd better use axp209-led (but the name of the driver is fine).

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, axp20x_led_of_match);
> +
> +static int axp20x_led_probe(struct platform_device *pdev)
> +{
> +	struct axp20x_led *priv;
> +	int ret;
> +
> +	if (!of_device_is_available(pdev->dev.of_node))
> +		return -ENODEV;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(struct axp20x_led),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->axp20x =3D dev_get_drvdata(pdev->dev.parent);
> +	if (!priv->axp20x) {
> +		dev_err(&pdev->dev, "Failed to get parent data\n");
> +		return -ENXIO;
> +	}
> +
> +	mutex_init(&priv->lock);
> +
> +	priv->cdev.brightness_set_blocking =3D axp20x_led_brightness_set_blocki=
ng;
> +	priv->cdev.brightness_get =3D axp20x_led_brightness_get;
> +	priv->cdev.groups =3D axp20x_led_groups;
> +
> +	ret =3D axp20x_led_parse_dt(priv, pdev->dev.of_node);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to set parameters\n");
> +		return ret;
> +	}
> +
> +	/**
> +	 * For some reason in AXP209 the bit that controls CHGLED is with
> +	 * inverted logic compared to all other PMICs.
> +	 * If the PMIC is actually AXP209, set inverted flag and later use it
> +	 * when configuring the LED.
> +	 */
> +	if (priv->axp20x->variant =3D=3D AXP209_ID)
> +		priv->ctrl_inverted =3D 1;

This should be matched on the compatible.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--s6rnltusscnwmgci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGbhbAAKCRDj7w1vZxhR
xf8nAQCoVhXm4+oiKNXqfXQdtlEZLP44Z8I8IyLvwk7LkJ8aXAD+PiQA1alhYoiN
+cq1w6+gSml19dmkaPFhyqKP3BGZ7w8=
=fl9M
-----END PGP SIGNATURE-----

--s6rnltusscnwmgci--


--===============9213263184153969245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9213263184153969245==--

