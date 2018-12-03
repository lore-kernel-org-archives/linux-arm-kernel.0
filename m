Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B7EC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:57:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312BB2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hMOtV5GN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312BB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NQt4yiyMLtDP9FiraD6AMOBLaqiQf+2VN/rnIOCjbUM=; b=hMOtV5GNqkGt9m9ElKzanSd+Y
	RIuI8V+DCgaiphjnG2Mkn9B5H7ffOJ0p3P64ww63B8ayXu9W3ZEvTYWzY6G0SVdU9bM79p1/Cklu4
	Z3R/yhq1G04ln/KvVtsH9On/WIXeopXezLbBKZSvli1OFYEZPFoN0V5CVGrO/XOTJfXsGDRY1ELAM
	S9CzUE06SCw37FmI9ZKRPELd00lQKFoVIZmk7dE0GlSIZFLRckV8OQPnGCSBtw7YRAm0/nuIaw9wc
	VYUEvlXWRc4cqNc/e7WZLDlkSPacIrN8Sk4eh94IOjzbl4mAYKWgbjiwO37AK5RXaBsD+T4WGvYa0
	TqolRM7yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTk2Y-0000ES-Go; Mon, 03 Dec 2018 08:57:18 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTk2V-0000Av-2D
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:57:16 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id D45E820CFA; Mon,  3 Dec 2018 09:57:03 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id A069B206A1;
 Mon,  3 Dec 2018 09:56:53 +0100 (CET)
Date: Mon, 3 Dec 2018 09:56:53 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [PATCH v6 01/17] ARM: Check ARCH_MULTI_V7 to differentiate
 ARMv5/v7 Allwinner SoCs
Message-ID: <20181203085653.jw7jkr6tzssfjzvq@flea>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
 <1a4e6f2b1d6aa5a079e2afb5d1ddf39f830eb8be.1543781680.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1a4e6f2b1d6aa5a079e2afb5d1ddf39f830eb8be.1543781680.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_005715_237721_F9F06A58 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-gpio@vger.kernel.org,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============7384719808668527443=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7384719808668527443==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m6z5g2vlrpry4m4d"
Content-Disposition: inline


--m6z5g2vlrpry4m4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2018 at 11:23:35PM +0300, Mesih Kilinc wrote:
> Allwinner also has some ARMv5 SoCs.
>=20
> In order to add support for them, check ARM_MULTI_V7 before enabling
> ARMv7 SoC's. Add help text for ARCH_SUNXI menuconfig.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--m6z5g2vlrpry4m4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXATv1QAKCRDj7w1vZxhR
xVipAP9MNsHCDfPhUEf+qFnDSKxfQ8TnBrOmUxMtZ1z0vKxDZwD9FZhhiuHw4CKa
8lkgGagAWCO2fBmZ+ZWrPC7ntInRxAs=
=bRqt
-----END PGP SIGNATURE-----

--m6z5g2vlrpry4m4d--


--===============7384719808668527443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7384719808668527443==--

