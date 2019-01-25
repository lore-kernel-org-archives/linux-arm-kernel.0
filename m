Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E163C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:43:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2F6218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="noXcGqJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2F6218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n8PfTea8d4ZmdLHhF/TZCbBjKYY7bIilgHM+a5VmtJA=; b=noXcGqJi0Wo5dr8VDc3iPv4Ok
	eo7Vj153EfWoT1d8tAml3EoGlz3i0uumMrXTWiT5rSJpkhGqXC1BctI79mDKAQfU+8YoGy4UUP0P0
	7hUgyocEYMRAl4T6IzgUexv1iFY2Db28QNTGEGxlZXZ+wBVNBK1b76xGa2LOHe0dDmp1z6fEF4Qbo
	XfT/Kqxwj8jUnrF1tSsviw1ysCpy3bh3rGqEuWOTXujzqnH6ewF3wPRlavyS43/3lrfk8Z7nxeWqk
	Mu1oq5vw4jl+LA/WDY0/KIWLvupmM79Lrl2HVt4HNc6M21prRljsOvtrbUtWrj8WBZvU5w60oYP+D
	Xd2sioELA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn3dv-0000pR-FC; Fri, 25 Jan 2019 15:43:43 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn3ds-0000p6-Mz
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 15:43:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5602420742; Fri, 25 Jan 2019 16:43:39 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id C457320748;
 Fri, 25 Jan 2019 16:43:02 +0100 (CET)
Date: Fri, 25 Jan 2019 16:43:03 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v7 3/5] arm64: dts: allwinner: a64: Add A64 CSI controller
Message-ID: <20190125154303.jmqscmxlezufzeij@flea>
References: <20190124180736.28408-1-jagan@amarulasolutions.com>
 <20190124180736.28408-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20190124180736.28408-4-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_074340_881302_FFE2BB45 
X-CRM114-Status: UNSURE (   8.89  )
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
 Michael Trimarchi <michael@amarulasolutions.com>, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============6991097991806877539=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6991097991806877539==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6fijsh4v6r45dej4"
Content-Disposition: inline


--6fijsh4v6r45dej4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 11:37:34PM +0530, Jagan Teki wrote:
> Add dts node details for Allwinner A64 CSI controller.
>=20
> A64 CSI has similar features as like in H3, but the CSI_SCLK
> need to update it to 300MHz than default clock rate.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6fijsh4v6r45dej4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEsuhwAKCRDj7w1vZxhR
xRERAP47wV0ErHsxQW8JMI85Y4tnI/ZvEhOc1rYC3Ao9r7MMggD/QQx9bE6fetwV
b+DQqyDgYr5DcBULwi9d7C4Y+tmJ5Ao=
=1Qhm
-----END PGP SIGNATURE-----

--6fijsh4v6r45dej4--


--===============6991097991806877539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6991097991806877539==--

