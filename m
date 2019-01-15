Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BBAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:55:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F2E20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IpsSRPPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F2E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e47YNRxRlButIx0uhOHY+GZeA8y1PbCQCNzDGtiNNX8=; b=IpsSRPPJk4XBeqp/2OhzkXQAT
	4C1eLxh4lyBy15EqtQnKF+g6DMs83TxIhDJK+cQ0egcYoA4P1gEsrpYGVSC516l0FNjqzcllDTnm3
	AcUQa0Tb94XYq5stF7uLzfwch7L2+DZUg0hNv1+vJhPCUcn2Qbt19ui0QA7y9+42WloIJbfUE0etA
	FqBI1HwJ+gghySbjA5vlkhuYNnTFhfGS4GJVLqxe1WCrluudYPB1I3HSK1Jnkyprsr8rDDwkXqIeV
	N37UCSppTJ0FwSt0qRzaetMkAoQhWasTF8hzsM3NIh6O5eIUtRhiEmypi3X8tAJjIrK1lXMInK2/k
	JhlXb9osQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjWfe-0002HS-Lp; Tue, 15 Jan 2019 21:54:54 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjWfa-0002GW-K5
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 21:54:52 +0000
Received: from localhost (p54B332B9.dip0.t-ipconnect.de [84.179.50.185])
 by pokefinder.org (Postfix) with ESMTPSA id 997D02C9D2D;
 Tue, 15 Jan 2019 22:54:45 +0100 (CET)
Date: Tue, 15 Jan 2019 22:54:45 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v5 1/2] i2c: imx: notify about real errors on dma
 i2c_imx_dma_request
Message-ID: <20190115215445.rjfio7i6sx62qfh5@ninjato>
References: <20190109055650.32259-1-o.rempel@pengutronix.de>
 <20190109055650.32259-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20190109055650.32259-2-o.rempel@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_135450_806624_2B97B16D 
X-CRM114-Status: UNSURE (   8.93  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
Content-Type: multipart/mixed; boundary="===============4377716257774821401=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4377716257774821401==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="adxe6fxfy6ffefo3"
Content-Disposition: inline


--adxe6fxfy6ffefo3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 06:56:49AM +0100, Oleksij Rempel wrote:
> At least on i.MX5x, the DMA events for I2C and SDHC use the same channel
> and there can only be a single user. So in this case there should be no
> message emitted that looks like an error if the I2C device doesn't have
> an assigned DMA channel. In contrast real problems that were only
> emitted at debug level before should be described at a higher level
> to be better visible and so understandable.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to for-next, thanks!


--adxe6fxfy6ffefo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+VqQACgkQFA3kzBSg
KbZYzg/8DX24pwd269Tj7OwNPC1q6F9JhXMMeOaHtaCGHTGv/+DgHszzNjM5GjlP
K7QWmsBHV3voq7ARex2Lpg61DA7jj7VEzYmObya5/Qg7uTF46GV6g/ZdjlWUoXjx
HCUcy55NTRkkELXqGSVZ4nbWtPpr4hGQvze/+lW2x71Wcv8fH9p25zVoW4IkK/uQ
ohk90VCkFQsWtGvaLE+EE+Bt682VYtd84TftdxYBhzPqY//UZ1+eUJ7005A9SzvN
UKZNC5HV00KTa0jAvSvc1ZN1Gwt8LxNfrIbThAqdaOxIIyseMvW9W1BaiMbC/gQD
9xIDcNo9n3goma0/kAR329Q682NWNRLJbBsc0t7g5EjeWL7+xlD4sCbbOI1Ps/Sp
6rm5i+8uxfyRIQIMWNJtp5sbV4gs5gtstqVW5EVEjsLfw4QLyTdCFTJEw1+zbuQS
DEiWfOPQH2gBpO+gg/HG7I0AgwwMeLQHyDSDSWcUVIJq9G6VBL91sMMa/mIdM0ia
cl48mjLAebXonnzL0afpLi6u0sEUiWh1VpM6WRHltNwEjLT09/rw4FDDnoxsdlYz
ceEKwzCvwlf2RSQXyKQC6RsuUTzBRVcfgIE4h8L5kzwkCJ/x+nOiB3EFQ/HIJk5E
m/rrKjGWf/G6P6YUsBCOPKF3F3x64Qv3o8qvUVyU6lxhXwNBt9k=
=GeoI
-----END PGP SIGNATURE-----

--adxe6fxfy6ffefo3--


--===============4377716257774821401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4377716257774821401==--

