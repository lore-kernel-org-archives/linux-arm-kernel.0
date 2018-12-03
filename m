Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B1BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:02:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593A320848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GVp1MN6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593A320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5cAWQPDEw5jikZq7MM66ztFXAfNvOMF9TA7aEOpCpXQ=; b=GVp1MN6YKfvJ6heM+CX/yBoGA
	LKBMhLJD7nPYOf/anSzEUc+dvdZjBSAqBq43S5VE2mb9YjUag9uMW6xryWoUg/fKwIsLAOBwDJXep
	FWAyLwdgPYBeMDlBqFwumDYbYmkPMTkRtfzQ1iHchE3F1/303RxwBoz2bzZ54Jz0qSwMzke7yDtfS
	NGdEWAax0MfnUZETq3EED9a5BpdzliE4YJ70SMoGLIIztF2wA2VRNT01FAFBJ+0+4GNhImAjArrIE
	IzlIIWij06w/qLg6sojhM2EnVwhoEMf//PG2FfokhDRJBu/l2DFHHbByULWlUxK/f8j+dzL/wBXHk
	HdJuDfHoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTk72-00040J-86; Mon, 03 Dec 2018 09:01:56 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTk6v-0003uQ-Ie
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:01:54 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1F50F20D04; Mon,  3 Dec 2018 10:01:38 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id E61042071D;
 Mon,  3 Dec 2018 10:01:27 +0100 (CET)
Date: Mon, 3 Dec 2018 10:01:27 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [PATCH v6 16/17] ARM: dts: suniv: add initial DTSI file for
 F1C100s
Message-ID: <20181203090127.enxxh5ah7eehbql7@flea>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
 <dafe3e548064535cfc32934c079b53a5c45fcd48.1543781680.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <dafe3e548064535cfc32934c079b53a5c45fcd48.1543781680.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_010149_748998_2C4A3E48 
X-CRM114-Status: GOOD (  10.99  )
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
Content-Type: multipart/mixed; boundary="===============3606474150509331532=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3606474150509331532==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cgoydzqpbnyatpx4"
Content-Disposition: inline


--cgoydzqpbnyatpx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2018 at 11:23:50PM +0300, Mesih Kilinc wrote:
> F1C100s is one product with the suniv die, which has a 32MiB co-packaged
> DDR1 DRAM chip. As we have the support for suniv pin controller and CCU n=
ow, add a
> initial DTSI for it.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--cgoydzqpbnyatpx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXATw5wAKCRDj7w1vZxhR
xTinAQCcvx9yH5QtdxwWWx2Y2rIxoGwcqOqhRAbBM4zBC8QANQEAsvPbl/1xiHTe
xelD3041rB+42b7lFYxJsQEYmJWADwU=
=6ZNq
-----END PGP SIGNATURE-----

--cgoydzqpbnyatpx4--


--===============3606474150509331532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3606474150509331532==--

