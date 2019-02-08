Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB194C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:45:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878D721919
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NputrGPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878D721919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zCZaW/qFM+cdVYxykwAEL5f/i8iYQdpID8FYljEmv2Q=; b=Npu
	trGPjGIY5090Oka09UhekQJWjLpnYY3iNxqyLFfiCK4uCaE7KbKLqpUvXAmCqsfsklv7YJCWI/mPz
	MdHry5jr+lCoTevuLIOyOKK+sjxXb93AtoToehOZyzlZI6wZrf1SuS9S/+ZeaSWJD9weEBUdNVtQM
	z9WSQvJmdtdp+PQwWHg3c1zog1awc8NkIElMyFoM7GZegyXJpY5uoOxaJrXqGGxuRNVRh4o5TTV9O
	D3xFYUw9LjWlBqcUubUlXEQNDZM+lLJTNuZa6q4EwP7KFO9ldeSFiLEwkXR1RMo9a+xsQ06Gmh9uP
	y6t2D5+oFf84IXNWtHXkQBeznsDYoCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3ex-00050z-CJ; Fri, 08 Feb 2019 10:45:27 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3et-0004zt-K8
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:45:25 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 743F4E0007;
 Fri,  8 Feb 2019 10:45:20 +0000 (UTC)
Date: Fri, 8 Feb 2019 11:45:19 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mike Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>
Subject: [GIT PULL] Allwinner clock fixes for 5.0
Message-ID: <20190208104519.2ix2ujxrpmhqrwlf@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_024523_817585_11111FDA 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8901965451058031588=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8901965451058031588==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="julhqle2jly444cf"
Content-Disposition: inline


--julhqle2jly444cf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike, Stephen,

Please pull the following PR for the current release.

Thanks!
Maxime

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunx=
i-clk-fixes-for-5.0

for you to fetch changes up to ee0b27a3a4da0b0ed2318aa092f8856896e9450b:

  clk: sunxi: A31: Fix wrong AHB gate number (2019-01-28 09:26:32 +0100)

----------------------------------------------------------------
Allwinner clock fixes for 5.0

Two fixes for clock indices, one for the A31 and one for the V3s.

----------------------------------------------------------------
Andre Przywara (1):
      clk: sunxi: A31: Fix wrong AHB gate number

Paul Kocialkowski (1):
      clk: sunxi-ng: v3s: Fix TCON reset de-assert bit

 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 4 ++--
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--julhqle2jly444cf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXF1dvwAKCRDj7w1vZxhR
xf16AQDglGUIK+zcZuYFIH4hLeUtnt+Y2wI/DWWnAtbFWQzsawD/Uct9NbHVu2w1
ck+Snf71+i6WKJHw4lkADHSOoCxOGw4=
=68jY
-----END PGP SIGNATURE-----

--julhqle2jly444cf--


--===============8901965451058031588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8901965451058031588==--

