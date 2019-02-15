Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:32:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBE921920
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ozlDGNYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBE921920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=39sw9FgxM7m6f86qtuWVNEJFf1so95A8cWwoGy6GcjM=; b=ozlDGNYC9KlY3LAH5eljI/ZbT
	qgK6spT9b0b5R8Hr65Q1ikkCL41kM0nvh+PW1eSTIgw9B4k6324XtzInGdklbfO84FZ+kuKy61WNu
	NLAhof4AY9YqSl4Jv1lihGkvl9SGr/gRH7Ar/qAvoDKdzvqP8r3qZMMjwJ2vzhJGVS+0CzLkpsh9e
	wYSrIl/ViY9woO/G+33YRMNNhvGd5uDQ1eSHwQMNUtsNLn9oQZ8bH++zrLrbYaYyHnK8LaAtXPWq9
	Ak6nR6RpZaBEVSE2QFRw2xoAj8qiTic9DXEj6loX2pvunTbyZ9Bm9qTUXfyc8T83iBwgjEBDM8Qle
	vEp5pjQDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guiI5-0004tq-ON; Fri, 15 Feb 2019 18:32:49 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guiI2-0004sS-JP
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:32:48 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 0BF9E8043F; Fri, 15 Feb 2019 19:32:33 +0100 (CET)
Date: Fri, 15 Feb 2019 19:32:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/8] leds: Add support for AXP20X CHGLED
Message-ID: <20190215183239.GB3280@amd>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-2-stefan@olimex.com>
 <20190215155732.nmtshldcjk2qyhx4@flea>
MIME-Version: 1.0
In-Reply-To: <20190215155732.nmtshldcjk2qyhx4@flea>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_103246_793665_93C427E9 
X-CRM114-Status: GOOD (  20.30  )
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
 <devicetree@vger.kernel.org>, Stefan Mavrodiev <stefan@olimex.com>,
 "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS"
 <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Lee Jones <lee.jones@linaro.org>,
 "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============1108368515233363802=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1108368515233363802==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Fri, Feb 15, 2019 at 01:50:06PM +0200, Stefan Mavrodiev wrote:

> > +static ssize_t control_store(struct device *dev, struct device_attribu=
te *attr,
> > +			     const char *buf, size_t size)
> > +{
> > +	struct led_classdev *cdev =3D dev_get_drvdata(dev);
> > +	struct axp20x_led *priv =3D to_axp20x_led(cdev);
> > +	unsigned long val;
> > +	int ret;
> > +
> > +	ret =3D kstrtoul(buf, 0, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/**
> > +	 * Supported values are:
> > +	 *   - 0 : Manual control
> > +	 *   - 1 : Charger control
> > +	 */
=2E..
> > +static struct attribute *axp20x_led_attrs[] =3D {
> > +	&dev_attr_control.attr,
> > +	&dev_attr_mode.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(axp20x_led);
>=20
> I can't really say whether adding sysfs handles for this is the right
> thing to do, but if it is you should document the interface.

It is not. See "Add Intel Cherry Trail Whiskey Cove PMIC LEDs" thread
in the last few days.

> > +	if (!of_property_read_u8(np, "x-powers,charger-mode", &value)) {
> > +		priv->ctrl =3D AXP20X_CHGLED_CTRL_CHARGER;
> > +		priv->mode =3D (value < 2) ? value : 0;
> > +	} else {
> > +		priv->ctrl =3D AXP20X_CHGLED_CTRL_MANUAL;
> > +	}
>=20
> I'm not sure we want to make this a property of the device
> tree. Changing the device tree isn't an option for some users, so we
> need to make sure we can change it even if we can't change the device
> tree.

We want this to be configurable at run time. It can get default from
the device tree.

If we go for the "hardware" trigger, you'll get it for free.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxnBccACgkQMOfwapXb+vKlTgCgwIfqaui3iA1stvAe0/CTXIh8
KCIAn1R8vkC9KvroWOwgGcFWmxzzS7wT
=5x+c
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--


--===============1108368515233363802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1108368515233363802==--

