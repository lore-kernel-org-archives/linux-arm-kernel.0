Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87569C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:17:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567E9218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d7QmvyaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567E9218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AV8i9Fq+V8Hd7JNBnyseNAyljduW7Q9WOXCBszMZBf4=; b=d7QmvyaVVypoYfvQWntX7nljr
	+B/h25Q08rnTC5GkB66edfXFUr/Avg6QsDOTuWisSnCphMnjKNXJajglKnxy21RbzLQ5lg1W8/f9y
	+fZpQUWovYkiQ+84xQFBp4paAaH6dNfHKE0Kps2jlSaVUOdEj6Uo3wESbfqtg383gn3Y3SCPkpaVa
	Uz3YIy3PUGMzKFI5ljanWTl3VC17o46vnk2IGgNTMJUy1AHpTUUkZhUE58HtumTQOFxv4CuAHSXHm
	VQLbqmo8SL+oKVHZcLcXVX6drrQKl4C9x8QrVDgBzQN+ROquBXTUoRYCVmnUckxzKoG6jb4qBbXQu
	cHO9FXddA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grM90-00013y-9e; Wed, 06 Feb 2019 12:17:34 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grM8u-00010M-5k
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 12:17:31 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 06B2D60003;
 Wed,  6 Feb 2019 12:17:18 +0000 (UTC)
Date: Wed, 6 Feb 2019 13:17:18 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/9] pinctrl: sunxi: Support I/O bias voltage setting on
 A80
Message-ID: <20190206121718.3yqbirt5l3qwneco@flea>
References: <20190206033239.3619-1-wens@csie.org>
 <20190206033239.3619-2-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190206033239.3619-2-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_041728_542643_67C83178 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5420925390165886925=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5420925390165886925==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p6xjb2ugcpauju6t"
Content-Disposition: inline


--p6xjb2ugcpauju6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 11:32:31AM +0800, Chen-Yu Tsai wrote:
> The A80 SoC has configuration registers for I/O bias voltage. Incorrect
> settings would make the affected peripherals inoperable in some cases,
> such as Ethernet RGMII signals biased at 2.5V with the settings still
> at 3.3V. However low speed signals such as MDIO on the same group of
> pins seem to be unaffected.
>=20
> Previously there was no way to know what the actual voltage used was,
> short of hard-coding a value in the device tree. With the new pin bank
> regulator supply support in place, the driver can now query the
> regulator for its voltage, and if it's valid (as opposed to being the
> dummy regulator), set the bias voltage setting accordingly.
>=20
> Add a quirk to denote the presence of the configuration registers, and
> a function to set the correct setting based on the voltage read back
> from the regulator.
>=20
> This is only done when the regulator is first acquired and enabled.
> While it would be nice to have a notifier on the regulator so that when
> the voltage changes, the driver can update the setting, in practice no
> board currently supports dynamic changing of the I/O voltages.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--p6xjb2ugcpauju6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrQTgAKCRDj7w1vZxhR
xflmAQDo9Z2Ucw2a5VIK7U4G/w5Xp43v5+NAyHQEt8A/U2QeQwEAlkjlIgausgbj
BAzCfh7mVPw+N3cAja1pOC78yhRs7wk=
=QGuC
-----END PGP SIGNATURE-----

--p6xjb2ugcpauju6t--


--===============5420925390165886925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5420925390165886925==--

