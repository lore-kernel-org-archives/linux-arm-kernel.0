Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D78220672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aMK/qmgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D78220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RXZ9BWkTSWQFGWoV6wWo/0bV8IK6c8qk2eS3rEIgn8k=; b=aMK/qmgZstrNv4SOu9h1K1umi
	B+wPy1dALjsJvBgfGZG6dCWwmJy3ayTP+sgzLfQCO7i16GcesrjRdCnm7X1qLD0nABcF/0PjsJpGQ
	F4SS38BSp07Eiqoojy4hu9EPBRGeTj3j8wbMqFMy+4doiOSN1joWiF38RdYQSeD8gxu9wPPqZeDAc
	MytW/CnyQvukmhKtdx/yuoWrX4DBLMD4WYvPG9QvFtqHbaXRxByPNueiupn9vTsYx9K5G5IsZTcg0
	azSeeKsdBO1IXcRpH2UX1gyRdo1RaGbpW0qYe/5WxZN0PHz08WHqqQJY/lqKEeeUSLni6VLPqVZ7v
	Zy6Vust4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTk8Y-0004LJ-KC; Mon, 03 Dec 2018 09:03:30 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTk8V-0004KH-Le
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:03:29 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 95AB82071D; Mon,  3 Dec 2018 10:03:16 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 5DD7C2039F;
 Mon,  3 Dec 2018 10:03:06 +0100 (CET)
Date: Mon, 3 Dec 2018 10:03:06 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [PATCH v6 17/17] ARM: suniv: f1c100s: add device tree for Lichee
 Pi Nano
Message-ID: <20181203090306.7e6mdjqzj7pmg4gv@flea>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
 <125b26f154ad1373179d67fcde30df056e883ac8.1543781680.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <125b26f154ad1373179d67fcde30df056e883ac8.1543781680.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_010327_845096_483CA039 
X-CRM114-Status: UNSURE (   9.93  )
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
Content-Type: multipart/mixed; boundary="===============1321496976003193730=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1321496976003193730==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qeuv22isdg5ditpp"
Content-Disposition: inline


--qeuv22isdg5ditpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2018 at 11:23:51PM +0300, Mesih Kilinc wrote:
> Lichee Pi Nano is a F1C100s board by Lichee Pi.
>=20
> Add initial device tree for it.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qeuv22isdg5ditpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXATxSgAKCRDj7w1vZxhR
xUp5AQC0GOpF9naIQ2RyuS8Cpunp777Upj+of5X35EZMQAiUIgD/QLkJX2cEBK0/
de9cOrVnRVdo2JH/sSofml48O95mjQI=
=PmRk
-----END PGP SIGNATURE-----

--qeuv22isdg5ditpp--


--===============1321496976003193730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1321496976003193730==--

