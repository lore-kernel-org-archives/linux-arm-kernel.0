Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F1AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:19:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BF920880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oCNB/8HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BF920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iPUEEf8HqqVYzgQqf9nqnqFOZQxuUnD/TzQcn+R5Z9g=; b=oCNB/8HLSaSg3uwz/5/JzXVbl
	D9RtKWMGwhW8kU1ZW4/04/5dMxsTaocKk+rCCV03zq5+DBpXTa86dljSK60Z9uV2urXgRP643qBSM
	4JjITmgpk2U654n+1bpFL2PmrdJ4eDdXOtgEQowNHVmzuCK0PUu02CPbaMpCR8bufokqu21rnJiIw
	mZMejYf/yDONWQO4Uc6luyZC0505351SmY9LcHTKzVpXLeLkc0ky5SFNFg9oAd+nEoD1kZdal3CKA
	O698aNtJt8H8Fcgb772NI7bgYIowxk14/m4JyVFOi5j7nqpd9Hk8tEwLn9KUpL6ZNUoEa1uCSDxRf
	GtpgkLVMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSiE-0002JL-2E; Wed, 20 Feb 2019 14:19:02 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSi8-0002Hz-EP
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:19:00 +0000
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id E908A240003;
 Wed, 20 Feb 2019 14:18:53 +0000 (UTC)
Date: Wed, 20 Feb 2019 15:18:53 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mans Rullgard <mans@mansr.com>
Subject: Re: [PATCH v2] ARM: dts: sun7i: add pinctrl for missing uart mux
 options
Message-ID: <20190220141853.mrcfdhv6mfhtbqjv@flea>
References: <20190216182132.12895-1-mans@mansr.com>
 <20190220120717.30650-1-mans@mansr.com>
MIME-Version: 1.0
In-Reply-To: <20190220120717.30650-1-mans@mansr.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_061856_790252_A77D225B 
X-CRM114-Status: UNSURE (   9.40  )
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
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1649319567400724319=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1649319567400724319==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rq6dlezyfpcqtila"
Content-Disposition: inline


--rq6dlezyfpcqtila
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 12:07:17PM +0000, Mans Rullgard wrote:
> This adds pinctrl settings for various missing uart options.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rq6dlezyfpcqtila
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXG1hzQAKCRDj7w1vZxhR
xf0YAQDrfcoJToPpU4dM4p5TUdQkQGKLgSSQg1bt8p/2cKZvBQD7BPqKYyQKRweF
vu1PyV0qT7POUUo5ptq9/LF2hBFMaw0=
=+gW3
-----END PGP SIGNATURE-----

--rq6dlezyfpcqtila--


--===============1649319567400724319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1649319567400724319==--

