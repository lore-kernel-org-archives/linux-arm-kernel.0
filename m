Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435D5C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:06:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157CC214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EOCPIhNC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rzNymi3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157CC214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jk07s4KnanYWP2BEkt7NDxf76EuTI2yj3Anpl3Xx++A=; b=EOCPIhNCTWCGN0wVoaeKB69v6
	zHmxlUc3HgQLjTahpH0uAvSFczHdZTQNSmQdTveEt1g+G1ppc3qN/MURL7vNk2Tz8sS1HUN7Wdbvb
	YS3ASsl9cnR1HBCDEMUsrO7DSZilWYkrsFiL1Rf0x0S8hDdvyxIios+CtfDwFr0x1VaBBHjM6FwC7
	o1/YGydMFxneQPzp/FAgfgWqW7wRIrYFNE7s3/LfbN+3Irtn7oji7X9+pdXYuuab3Ztg8l1U8ZXYc
	XsnpAMqZOLZJH892eB79Gac7ynpkqpyt8HG63EosYUi2DAfYc+FTFMFabNQ48NPtstJMugNOhyf9G
	rqKQKXu5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtXla-0005EE-Nf; Tue, 12 Feb 2019 13:06:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtXlZ-0005E7-73
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 13:06:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sdAntnYeh2hau4WuM5TEZ6ABOtZKe5IE4wL3N9m4pxg=; b=rzNymi3rpVRLpnxgtEKRxbA+o
 NfhPPnC2hKtDgXRdahW3ivn+EoK85OLys96+0K6saGSridW06Gf1ubmY6g/VqQsIa9R7i4I3Z2O4Z
 /WeQ3Lf06AN2OmB5hIl/vChgO6hS/RtbciMxUD0cEe6zxE1FgyjQgPInIrkhpO7L+1LRnrASc9pNR
 YZz4NqAmSfUAC+hyMDQXjxUNP9VUNq0scjX9EVoXjn2JCtt9jI1ggvUEzMSP3YsOPfHWNLSjLWwtm
 mkZzvdz140Ypw7XAX7SMjT4JSrTmWjhfjwS6xhmkFmfC23Gj1KhGEQTQBe100/uA3kdzWPEwqqZS2
 15U8kVc8g==;
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtXlV-0004Wj-Ue
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 13:06:23 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id EF47840007;
 Tue, 12 Feb 2019 13:05:48 +0000 (UTC)
Date: Tue, 12 Feb 2019 14:05:48 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v3 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
Message-ID: <20190212130548.tytlxmbu4q6qgzzq@flea>
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <562aefcd53a1a30d034e97f177096d70fb705f2b.1549895062.git-series.maxime.ripard@bootlin.com>
 <716ae1ff-8e62-c723-5b5a-0b018cf6af6a@xs4all.nl>
 <db7a762a-8bc3-0391-036b-1fda2e445023@xs4all.nl>
MIME-Version: 1.0
In-Reply-To: <db7a762a-8bc3-0391-036b-1fda2e445023@xs4all.nl>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_080622_158483_6A2ED0A2 
X-CRM114-Status: GOOD (  17.04  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, acourbot@chromium.org,
 jonas@kwiboo.se, jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com, tfiga@chromium.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, hans.verkuil@cisco.com,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sakari.ailus@linux.intel.com, Guenter Roeck <groeck@chromium.org>,
 nicolas.dufresne@collabora.com, ezequiel@collabora.com, posciak@chromium.org,
 linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============2254562972659385816=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2254562972659385816==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="clsemqi6dbr7yjrh"
Content-Disposition: inline


--clsemqi6dbr7yjrh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 11, 2019 at 04:21:47PM +0100, Hans Verkuil wrote:
> > I think the API should be designed with 4k video in mind. So if some of
> > these constants would be too small when dealing with 4k (even if the
> > current HW doesn't support this yet), then these constants would have to
> > be increased.
> >=20
> > And yes, I know 8k video is starting to appear, but I think it is OK
> > that additional control(s) would be needed to support 8k.
>=20
> Hmm, 4k (and up) is much more likely to use HEVC. So perhaps designing th=
is
> for 4k is overkill.
>=20
> Does anyone know if H.264 is used for 4k video at all? If not (or if very
> rare), then just ignore this.

I don't know the state of it right now, but until quite recently
youtube at least was encoding their 4k videos in both VP9 and
H264. They might have moved to h265 since, but considering 4k doesn't
seem unreasonable.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--clsemqi6dbr7yjrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGLErAAKCRDj7w1vZxhR
xRi+AP0cIus7devJ8uO36+2F7paAjyP641RBIlsIga+cRq4/uAD/THY1UkMAZAlE
enuxa3pQVkeOdOKYeXuY8p9qrRG8ng8=
=ZOBQ
-----END PGP SIGNATURE-----

--clsemqi6dbr7yjrh--


--===============2254562972659385816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2254562972659385816==--

