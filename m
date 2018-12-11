Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C703AC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:46:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959652086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nR+NPwhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959652086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y5N0ZuLSVol9+MxfYIZIIPJa1QY+MIVgx8sezj9rG3s=; b=nR+NPwhYYt69QfxaB0fAD90zU
	U5ZOo289F5bNXCORUbCZs2AwXyUqildSQ/geBi9oRToCaLJ+s8qbE53oX2yC2dob2y7XfGHvdbMnl
	wa1qXDUyxeaGIFV5szcZN5VfLTiXEoeGvtrRQCrh8QNiM9vbmfLYJLVFhdXp/spsLhF2WV7HVKzZd
	kfpcc0FZiWaQX/I9AxAPqAJhcBG/oXq+NDzlicDa+qAygIh8vTWQrj0ZkpMCPZ2f9L6t7N0t/4Nex
	xYEwgf59uliTmyNXdPWl7YwCgxvlYpYQc5jJmwDd/B0fbk0xjkUGjx2AMnT/8VaTZdNbagRcZMe5Y
	BQ4XoJpuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWpr8-0001L3-7q; Tue, 11 Dec 2018 21:46:18 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWpqV-0000j1-IQ; Tue, 11 Dec 2018 21:46:02 +0000
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
 by pokefinder.org (Postfix) with ESMTPSA id 5ED834C0E8F;
 Tue, 11 Dec 2018 22:45:28 +0100 (CET)
Date: Tue, 11 Dec 2018 22:45:27 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c
 controller
Message-ID: <20181211214527.GA5660@kunai>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
 <8a6a204b28523e5a181f9e85dda18fade76a26a3.camel@baylibre.com>
 <b2bceaf4-92ce-92a4-c382-713d29ae3b70@amlogic.com>
 <20181211203652.rogajl4ajwu7cs6f@ninjato>
 <7hsgz3u4fu.fsf@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <7hsgz3u4fu.fsf@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_134540_555205_85F5F526 
X-CRM114-Status: GOOD (  10.96  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Hanjie Lin <hanjie.lin@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 Jian Hu <jian.hu@amlogic.com>, linux-i2c@vger.kernel.org,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: multipart/mixed; boundary="===============5168370876090922614=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5168370876090922614==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> I am okay if it is reasonable below in file
> >> arch/arm64/boot/dts/amlogic/meson-g12a.dtsi. I2c controller node just =
uses
> >> axg's compatible.
> >>=20
> >> 			i2c0: i2c@1f000 {
> >> 				compatible =3D "amlogic,meson-axg-i2c";
> >
> > Actually, you should have
> >
> > 	compatible =3D "amlogic,meson-g12a-i2c", "amlogic,meson-axg-i2c";
> >
> > in the DT to have support for future SoC specific additions. And then,
> > patch 1 is needed.
> >
> > Or do you handle this differently? I'd think this is DT standard.
>=20
> It's a DT standard *if* there are actual hardware differences.  In this
> case, the IP block is identical, so there are no driver changes.
>=20
> We prefer to add a new compatible if and when there are actual
> driver/hardware changes.

OK, fine with me. I just hope for you guys that there really is no
change in the IP block, otherwise you need to update DTs later.


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQL/IACgkQFA3kzBSg
KbbXFg//SIq2lU0nge0Dh0BSX8NJGPF/ETdhp8hcEKs5kManXc/Kd+rLlNJC7y84
AMSGX9pIK899f51uMMgI6AbzNGimTk8Y2nghiHLyq6tum6QeFdOIjDJOC3lICUhx
z7L+BEZ6hFNJPBZRSCRlio3dag2k8qHhM5ah6Xu6i7mH+g1JrNi6gFyrZsNv8hFy
3Hg/bL7DwZXQJFknp0tsOglXiJThOz7VDx460zqn5cyl2PRvSaRvhZ67Yzg9I7Sz
TQIW+KLj/hv2JApKkJtlYFHit+p3ZZvb/JfaGfO2FsKnBL6WJQJT6dLwPiK1guG7
wSmp3eOqAlgeI3NMNqmAy2SfYqZn3IoVsuNy9us5+hkshxwsgOxkoT1Vvde3o19b
c42k8bolyzyvdKDGbl1UuahvQLB3pdYvDa1kCzO63BlW6slMVsjhcYuK0yP7AW7F
4SSumOdaFrd3azSi7pl5eG21J19U45sSxWow9oMRuw9yW9JHDiB5mIKt4dLTIym/
mAbfHswdxtRDepqmM2UyLRN5RX6bJA8aefum/2jdNg98dbiUHMX8akHqbS//eiOX
xBZcptougATsy9JIVcw25PSpg0NTUM4udScSsKyptNTFkFoE6PyF7ln67R8M3R2n
uTW6i946iQ/olPGPhN/yCWg3AoD9mAdaxEOIcGZ3ekgA94NbgUc=
=J9xG
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--


--===============5168370876090922614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5168370876090922614==--

