Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22400C2F43D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:43:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FBE20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aErJ609D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FBE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VQ1HiQB8rJua9sq/PFlqzArLmtIV7pn72Yjm7zFO/mo=; b=aErJ609D5c52roNki5IVmfUaQ
	/+mTNlCyNxaUTU/Q9Vgdlm9Pc45Lv6h8WuMl0I9lgEN8kEXAfkDjGMHwtXpEx7LcgneLCJrAt7Qe0
	nsikd+wYg/lCM/7hWVjRG6iYjBR3ytHXc/7dncn8Y2x56cEMk7Wo59MMx9jEhs0VUml0SAZhLt6Ue
	PwWAcCl3IPjJnt+OvHEZH4gy9N8qALrUSsBtB5Am0xHmNOizg3LNLekuCtVanmC3X6APw+pzx/3hh
	VEX0k9p4CK4A2fZh0vDf+NxrzDr2riQxZWH5KAmHC0M5o9kIQi0laNd3JmEG/246mRBzIRdt4PkIi
	E54O+fbEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbjq-0007ao-AA; Mon, 21 Jan 2019 15:43:50 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbjg-0007Se-G8
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:43:44 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 37DD320BA8; Mon, 21 Jan 2019 16:43:38 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id E945620A7D;
 Mon, 21 Jan 2019 16:43:27 +0100 (CET)
Date: Mon, 21 Jan 2019 16:43:28 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v4 6/9] drm/bridge: cdns: Separate DSI and D-PHY
 configuration
Message-ID: <20190121154328.ydvz4fr5l77do3eh@flea>
References: <cover.5d91ef683e3f432342f536e0f2fe239dbcebcb3e.1547026369.git-series.maxime.ripard@bootlin.com>
 <df619f059617d85c00efa146884e295240a07ae7.1547026369.git-series.maxime.ripard@bootlin.com>
 <20190117133338.GA114153@art_vandelay>
MIME-Version: 1.0
In-Reply-To: <20190117133338.GA114153@art_vandelay>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_074341_278338_79B82F0D 
X-CRM114-Status: GOOD (  11.73  )
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
Cc: Archit Taneja <architt@codeaurora.org>, Rafal Ciepiela <rafalc@cadence.com>,
 Krzysztof Witos <kwitos@cadence.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============5699603719387506802=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5699603719387506802==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l6imrxbzhtg7biw4"
Content-Disposition: inline


--l6imrxbzhtg7biw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 08:33:38AM -0500, Sean Paul wrote:
> > @@ -768,49 +769,90 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
> > =20
> >  		dsi_cfg->hsa =3D dpi_to_dsi_timing(tmp, bpp,
> >  						 DSI_HSA_FRAME_OVERHEAD);
> > -		dsi_htotal +=3D dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
> > -		dsi_hss_hsa_hse_hbp +=3D dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
> >  	}
> > =20
> >  	dsi_cfg->hact =3D dpi_to_dsi_timing(mode_valid_check ?
> >  					  mode->hdisplay : mode->crtc_hdisplay,
> >  					  bpp, 0);
> > -	dsi_htotal +=3D dsi_cfg->hact;
> > +	dsi_cfg->hfp =3D dpi_to_dsi_timing(mode_to_dpi_hfp(mode), bpp,
> > +					 DSI_HFP_FRAME_OVERHEAD);
>=20
> We're throwing away the mode_valid_check switch here to flip between crtc=
_h*
> value and h* value. Is that intentional? We're using it above for hdispla=
y, so
> it's a bit confusing.

ah, right, thanks for spotting this.

I'll resend a version with those changes, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--l6imrxbzhtg7biw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEXooAAKCRDj7w1vZxhR
xZvQAP9c5WpWI5x2NUr+cpn0bnmw6vFHt4EsPXnMArrGqiPwFgEAlu2Dw7n4C1H9
K0jkBgL1lQj7MoT8wU2DNLJ2gXtN1AQ=
=fa+Q
-----END PGP SIGNATURE-----

--l6imrxbzhtg7biw4--


--===============5699603719387506802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5699603719387506802==--

