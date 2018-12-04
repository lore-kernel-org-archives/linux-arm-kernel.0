Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:12:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0917F20666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ojr8djTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0917F20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j+M+SWjvnSiYHsyZkuhrVqd2D4zVspXhk8nkhJWpnX8=; b=ojr8djTqw+q7fZLzTp0TFhtZL
	TaKXDeFkLZ1Lg1jY0yxc+PjoRa8jJ+RYfrkDlhQho96F7Q+ODdE0L5oSflr1LrNsHvKlTj55fMF/o
	s6HZmoAECWGQmEOQqawQFhckTFppikoMpRothAiqEfuL4eG9NMUzI8TroaxE/ar/0DJUlYhCbXPJp
	WLo0q28m55Xzk+MzeIbU08h8bGv8SVe/LWfAfpiY2FY7lA5j1LRMUaqWG1B7NLBPw/UEcnR3u3Wcz
	q4Q1W5WMA39wQWEj75VR8QZ+h4gjzYYh2XLkuTRDGNkXZ1N9r+oB1TKVJ48oRUsost6QdJBLGIPbU
	VvMfQYVUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6km-0000C5-G3; Tue, 04 Dec 2018 09:12:28 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6kj-0000AC-ES
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:12:26 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 41E6120A66; Tue,  4 Dec 2018 10:12:14 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 0E08A20723;
 Tue,  4 Dec 2018 10:12:04 +0100 (CET)
Date: Tue, 4 Dec 2018 10:12:04 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11
Message-ID: <20181204091204.jtzk5gf2clumjwiq@flea>
References: <20181204090457.15597-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20181204090457.15597-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_011225_615909_DDC60CF1 
X-CRM114-Status: UNSURE (   9.89  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4654578300571813643=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4654578300571813643==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ntukseib6hpdpxly"
Content-Disposition: inline


--ntukseib6hpdpxly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 05:04:57PM +0800, Chen-Yu Tsai wrote:
> Pin PH11 is used on various A83T board to detect a change in the OTG
> port's ID pin, as in when an OTG host cable is plugged in.
>=20
> The incorrect offset meant the gpiochip/irqchip was activating the wrong
> pin for interrupts.
>=20
> Fixes: 4730f33f0d82 ("pinctrl: sunxi: add allwinner A83T PIO controller s=
upport")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ntukseib6hpdpxly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAZE5AAKCRDj7w1vZxhR
xXA2AQCPFSIvJF22brGFxdzkEfvHrhtpFPzoHoLkoheaIv9R/AD/Rc/ipWK1MMF5
jlxe58eaPCjXuyKYlx9iEdfyF7/CRA8=
=b4P4
-----END PGP SIGNATURE-----

--ntukseib6hpdpxly--


--===============4654578300571813643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4654578300571813643==--

