Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C6EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:58:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A303520848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UMmKBkzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A303520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QkOf66CUoFxjaugfoVxPkXpAK4YLTSb7x+oRcBaTRzQ=; b=UMmKBkzbUDELo/fbs/DOoQy4w
	Bm26Qj7ikI02e1giRIsnPc11hIrQkiynvoNCbTwn+T+McAw2jvAa2OfVplXQ4/ZW4lhcvvHMsVp9Q
	xXswGmPF1fMpFFx2pjK3fBlsIFmx8Ft4ZblszjbzNpP9ND7+LJLZq/q6wFu8tdwpp2EiskPOg6ojr
	jwADfSjhWMlFKpzvmlKunppk1zHU7x/R7TdcQpj2687gl1eajulLeBa7n59JMPP75g0ahVwB7JE00
	6h7idSubKJeewRcxgyp8IuDm0xsciXZCQkl6u/xJbXMNd7iB03zPbdm23yw1ogEHzEp+07waJCpHz
	oChuu3F9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTk43-0001aS-BU; Mon, 03 Dec 2018 08:58:51 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTk40-0001Ti-E9
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:58:49 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 3EEF220CFD; Mon,  3 Dec 2018 09:58:37 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 1088D2039F;
 Mon,  3 Dec 2018 09:58:27 +0100 (CET)
Date: Mon, 3 Dec 2018 09:58:27 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [PATCH v6 14/17] dt-bindings: sram: Add Allwinner suniv F1C100s
Message-ID: <20181203085827.ytu25vahyomrbk2f@flea>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
 <0b60c924d30ce3e04325214789de2c5b0403a056.1543781680.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <0b60c924d30ce3e04325214789de2c5b0403a056.1543781680.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_005848_609224_EFD46E96 
X-CRM114-Status: GOOD (  10.17  )
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
Content-Type: multipart/mixed; boundary="===============6848821247312705878=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6848821247312705878==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fzgdrbtgggpcxae2"
Content-Disposition: inline


--fzgdrbtgggpcxae2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2018 at 11:23:48PM +0300, Mesih Kilinc wrote:
> The suniv ARMv5 F1C100s chip has similar sram controller to sun4i A10.
> Add compatible string for it.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fzgdrbtgggpcxae2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXATwMwAKCRDj7w1vZxhR
xdSoAP4/HPXU3Q61NogkhzLHf2yDoRjUAkg8CuS2L52tW0OzuwEA+KBPQe++ZqGv
rs+mcOAAv916/2YgTUOS+YbPUKP7dQg=
=PsyZ
-----END PGP SIGNATURE-----

--fzgdrbtgggpcxae2--


--===============6848821247312705878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6848821247312705878==--

