Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033D4C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:34:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F582184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="co7yuSsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F582184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3NsoIYapGvlj3A+qioWpX3zU/tRsQ0n13zz15qurjTU=; b=co7yuSsHz7UsZw2OsxYDe0+8e
	8CgDZHW6CdUW2+okOkbQ/d5s2iVeAq6rr2RJvM/sYszA/6j2nGX0/670NaiCWNxPnrcNDAla5bSv8
	xDPldAe8vGB33bU/xG9866GuftmBzWx9xJ94WZ8L3Fvlewun0vp420L50k0MwfWnu4UL2fFzhORzC
	iz9uesvIpMvKy0dPWnTh28+CAuQ5Xe9OPVa1yBpATZj4NKAUeyvlAbJns8L9Hqc41JSeXOfruDZPB
	D5Lb/xXtePiuidKDx6KYPs0b5DYvv7QfRQw9bf32hZuyXq9hxqff8GHCNBswdY3gkB4ChPWuIa2QZ
	aB/WX0/8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTWC-0004BP-PR; Tue, 12 Feb 2019 08:34:16 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTW9-0004Aw-0f
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:34:15 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 7DF041BF212;
 Tue, 12 Feb 2019 08:34:03 +0000 (UTC)
Date: Tue, 12 Feb 2019 09:34:02 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCHv4] arm64: dts: allwinner: a64: teres-i: enable backlight
Message-ID: <20190212083402.tb43rxa6pkq3ctok@flea>
References: <20190209104018.6765-1-harald@ccbib.org>
MIME-Version: 1.0
In-Reply-To: <20190209104018.6765-1-harald@ccbib.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_003413_209981_56F281A9 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
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
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8969224904763226706=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8969224904763226706==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7kjgubf4vlob5jm6"
Content-Disposition: inline


--7kjgubf4vlob5jm6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 09, 2019 at 10:40:18AM +0000, Harald Geyer wrote:
> Enable pwm and add a pretty standard backlight node.
>=20
> The regulator is always on, but we include it anyway, because it is
> required by the binding document.
>=20
> Signed-off-by: Harald Geyer <harald@ccbib.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7kjgubf4vlob5jm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGKE+gAKCRDj7w1vZxhR
xcCDAQC47v1EPuWItskGR2u5Yl+vpn+uibN/ON1cWU5Bz+KL+AEAor2oGLUEtih2
AnUW1uqSNSaQJfuXJNncZaFydybfGQk=
=TMlC
-----END PGP SIGNATURE-----

--7kjgubf4vlob5jm6--


--===============8969224904763226706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8969224904763226706==--

