Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5899CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:49:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8B0218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WNXJIUJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8B0218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xm8Acwilhpdj2kJkx40Ykl52oI/yhM1WfdAxYiM/EIo=; b=WNXJIUJSpkq69Ak7gCDcxYfB6
	IWPQOrqksFp8sp7KTT+DKZHAl2lWHknG5Ncxh7BBX6kUFQL4HoQNZkLU48zJeMUKJa+T800EUVO5m
	HbWFe7h5InsAm1w5ah6rSh6+jXA7Srtzwuus/2fzRmD2haGcVXar6/N+Mx50Lv8XJgf22b7fto2/Y
	U1luq+j6beuuSxVmxo+i/RYRj59WYKsjGob5z012SkRnYm7fwFhgkoB5YGr86YRddpZVgeyvUBPeo
	C0hGlbD0og6toN0cwEqLhoxFeKVlj6XJuCBScbchBJN8z7u79Q5zK5RK2q1pi4A3mavHlRDTCvYZX
	WbTnM6skw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guiY9-0004wz-4G; Fri, 15 Feb 2019 18:49:25 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guiY4-0004vl-TS
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:49:22 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 626A180441; Fri, 15 Feb 2019 19:49:10 +0100 (CET)
Date: Fri, 15 Feb 2019 19:49:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Stefan Mavrodiev <stefan@olimex.com>
Subject: Re: [PATCH v2 5/8] arm64: dts: allwinner: Enable AXP803 CHGLED for
 Olimex boards
Message-ID: <20190215184916.GA17897@amd>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-6-stefan@olimex.com>
MIME-Version: 1.0
In-Reply-To: <20190215115013.11098-6-stefan@olimex.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_104921_105791_2EA5D1D6 
X-CRM114-Status: GOOD (  15.44  )
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
 <devicetree@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS"
 <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Lee Jones <lee.jones@linaro.org>,
 "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============5162768994177074506=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5162768994177074506==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-02-15 13:50:10, Stefan Mavrodiev wrote:
> Teres-I and A64-OLinuXino commes with populated LED connected
> to AXP803. So to be used as battery indication, pass the LED control
> to the charger itself in mode 0 ( FULL while charging, OFF no battery
> or completed).
>=20
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 6 ++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts   | 6 ++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arc=
h/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> index f7a4bccaa5d4..7d6930319fba 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> @@ -177,6 +177,12 @@
> =20
>  #include "axp803.dtsi"
> =20
> +&axp_led {
> +	label =3D "a64-olinuxino:yellow:chgled";

There's little chance userspace will recognize this led.

Can you make it "platform:yellow:charging" and fix it for other
boards, too?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxnCawACgkQMOfwapXb+vLEAwCfUcSllFtWon2qQkW9JcK3hfq4
aMsAoKwCglaZGvwLk+NVMgYjCe18FLZf
=ftHA
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


--===============5162768994177074506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5162768994177074506==--

