Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D652C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:13:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596512192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ile1r5tP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0hQsKfTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596512192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hVeYAGkG8YOACi1K8iJbVGlFLOFToSX4+0+4BI7Ia0s=; b=Ile1r5tP2BdIC2waagNDJwUKr
	jvsa+dgYN4yybiA8VVbeFUS5PSWsLU623QuVInSoA91b5/7QEuoiW+fwZ6cW8pWgxZc/dPZJUIU3c
	BJWHViCTAjyY/7IbOwNSnOELb/dl8DdgLM+/FcS2kq2kANYA+CvIwYkaVtG+2GGRqUCB2Qbmn1Y81
	Ra02hlXMfGj/7J9HDUfFUsTc7fr68aO9VUcdQQHuM2HUMqZv+l0SP549uMUCn8clVQn06NeGyy5eF
	nQiF8YHsPkjVneQMOcAgJg8PbYPr/9ZXXoTkjjjdPgp77V9JuMQf875w6j32JKiAwmVvNK8qiTBzy
	zzoUe52SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueF0-00075P-Vg; Fri, 15 Feb 2019 14:13:22 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueEz-000752-AF
 for linux-arm-kernel@bombadil.infradead.org; Fri, 15 Feb 2019 14:13:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uSkxX4HD9wRNqP9N0Xp0VUwh8qNMlMLIO3mvOB/AlKY=; b=0hQsKfTw5raYMPmfD04uGUmEm
 l5BDSFzicLVbBP8oirlc0IMOVupN5GSQdyOdmfu658N3XwAR0FbdqxAhtKXVPIplSHNpTbcG5a/wF
 MHmfYbTFsn7z/5csBJj5NPKQMU5Mb6yyfjK/B34dxiUqKeOp+Qnpc54e4pS1AS1A2Sm0nPH048ETc
 atNHJTs519YXVAhZ/30c2i7hOqU659ziIn/9zYCTCz4CxOsr0wa22TBJZZ2IBSp9x0jHNezHvUiYB
 irNyWjuczMUyu7X4qszxfWYTdfLqm8AmbqjR4wR7CLfqcz8ofIGRcKyVXJgMcAD4F/A7ix4+e8/fX
 LJkfVag0g==;
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueEv-00058a-PQ
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:13:19 +0000
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 21CC724000E;
 Fri, 15 Feb 2019 14:12:44 +0000 (UTC)
Date: Fri, 15 Feb 2019 15:12:44 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v3 0/8] drm/sun4i: dsi: Add burst mode support
Message-ID: <20190215141244.5jrrqkykna6enbtp@flea>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_091317_935987_10B2077A 
X-CRM114-Status: GOOD (  12.43  )
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
Cc: bbrezillon@kernel.org, dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8709504760930897282=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8709504760930897282==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7z64yynb7vmc57zv"
Content-Disposition: inline


--7z64yynb7vmc57zv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 03:41:21PM +0100, Maxime Ripard wrote:
> Hi,
>=20
> Here is a series implementing the burst mode support for DSI.
>=20
> It's been tested on an A33 board with the panel supported on the last
> patch, which should remove all quirks due to a different SoC from the
> equation.

I should have sent that mail yesterday, but patches 1-4 and 6-7 were
merged. Patch 5 was discarded since it was not consistent with the
rest of the driver, and 8 had some comments.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7z64yynb7vmc57zv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGbI3AAKCRDj7w1vZxhR
xZhSAQDOUEbEuRKbbMOWQfb9seF5itixvyxQwgLf3llGIBB6lgEA/2zcSptDLLoj
M/4BMrxXM8XeRnXVrhCVmqkI7yUMGgg=
=TlP2
-----END PGP SIGNATURE-----

--7z64yynb7vmc57zv--


--===============8709504760930897282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8709504760930897282==--

