Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB66C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:57:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C4720881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dPr7Kw85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C4720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iPAT1Vl5/zlFr+Z6d+LzZm5RTBounr/gImbmgExmgiU=; b=dPr7Kw85wQdN/HZP6uIt6eZqD
	Gh5eLUTBwCO972B0NWJch5r3AIBnn/Z+GDtg+vhIMV3tuJ0mQlM+/gRwUhMEJIbZslPNFQo97xRhM
	uVQR86qs9DeS9XGnNGDOPWACwMAJf6grdSjOWP587NRn85swkCSNSrUpl7K/KiIj+vZ24/Ex6/7Rd
	beZTgLmjHm3f+NRPpg+awQIlxRL8yR8Nusgyv9OlKoMHwNUwliUckVkD27ivSLghA4XSMH9cIXTTJ
	+BvtQMry2Rjv8hVDqaE1gHNQn1VzjJ9bJ2dSI+xhDdJ19Bx+l4soisfhKfN9ZFaLs79o7LgaRTx4e
	Q1OUYjUAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTk2o-0000rp-RJ; Mon, 03 Dec 2018 08:57:34 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTk2j-0000GM-UP
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:57:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CB2D320CFA; Mon,  3 Dec 2018 09:57:18 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9BC2B20CFC;
 Mon,  3 Dec 2018 09:57:08 +0100 (CET)
Date: Mon, 3 Dec 2018 09:57:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [PATCH v6 02/17] dt-bindings: arm: Add new Allwinner ARMv5
 F1C100s SoC
Message-ID: <20181203085708.fblw4z66p2vyr52c@flea>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
 <6fa3cf509379a0888388821eef3e322c014df5b8.1543781680.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6fa3cf509379a0888388821eef3e322c014df5b8.1543781680.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_005730_248173_3A40948D 
X-CRM114-Status: UNSURE (   9.38  )
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
Cc: devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-gpio@vger.kernel.org,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============2110420121994066820=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2110420121994066820==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lvx2wzkx735lsbsm"
Content-Disposition: inline


--lvx2wzkx735lsbsm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2018 at 11:23:36PM +0300, Mesih Kilinc wrote:
> Add new Allwinner ARMv5 F1C100s SoC's compatible string
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applie,d thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lvx2wzkx735lsbsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXATv5AAKCRDj7w1vZxhR
xeKkAP4nP2LHd79lDnjSbWhyCewym9BMqFwQYracNOL6ykFMEQEA9voSEEOLXQCK
dYdkKam4CIoFiYR6QxeEyV+0BNlbHw0=
=D+kO
-----END PGP SIGNATURE-----

--lvx2wzkx735lsbsm--


--===============2110420121994066820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2110420121994066820==--

