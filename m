Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592E6C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:22:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BAB20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hrcg1EVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BAB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=B6kj28c2WZWPN/1phO6X7n8COE1egK6GVwHpnz/gLNw=; b=hrc
	g1EVvWtLg/XA8H7T2WokrLqx1bDHOA/etUupzh0XEBK81Wdj77qDHagDiL9e/De4/pe6tJNmse4zi
	JV/NXqh5UQKbUdbKBJHEHao3FC7PR4laxopFZC0T/RFFvs46vHLnObABYWpMjAMczR7nkZtAPtnmG
	BbbLQAubWazl+clm1IDh+oyk9/QSCh869m5M20JwwZ9XbZMU/UJRjDil4IOtY/+AFlPFLexzRePFW
	B+aTIWXYTG8K8jFLyOhcCo6zfPl1kuDTMEd8ZEyossEWiekLY1rwEqfpSXNs2AKJMlQ7Qd/r0q656
	r8IwMKJV1/Q5yTPB1wpefbIE020XGew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVH1I-0004SQ-1i; Fri, 07 Dec 2018 14:22:20 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVH1E-0004Rn-M9
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:22:18 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6DDC720745; Fri,  7 Dec 2018 15:22:05 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3CE8F20723;
 Fri,  7 Dec 2018 15:22:05 +0100 (CET)
Date: Fri, 7 Dec 2018 15:22:05 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner arm64 defconfig changes for 4.21
Message-ID: <20181207142205.wa7hghejqteaj54f@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_062217_047397_557EA5EA 
X-CRM114-Status: UNSURE (   9.70  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5556089520743822051=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5556089520743822051==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a22ccqmtjj2bxifh"
Content-Disposition: inline


--a22ccqmtjj2bxifh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd, Kevin, Olof,

Here are a few defconfig changes for arm64 for the next merge window.

Thanks!
Maxime

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunx=
i-config64-for-4.21

for you to fetch changes up to 4f49b7344201616e327a5f94db0f534025ab814b:

  arm64: defconfig: Enable PWM_SUN4I (2018-11-13 14:06:40 +0100)

----------------------------------------------------------------
Allwinner arm64 defconfig for 4.21

A bunch of patches to improve the coverage of Allwinner drivers in the
arm64 defconfig, mostly targeted at adding display drivers support.

----------------------------------------------------------------
Jagan Teki (4):
      arm64: defconfig: Enable MFD_AXP20X_I2C
      arm64: defconfig: Enable DRM_SUN8I_MIXER
      arm64: defconfig: Enable DRM_SUN8I_DW_HDMI
      arm64: defconfig: Enable PWM_SUN4I

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--a22ccqmtjj2bxifh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAqCDQAKCRDj7w1vZxhR
xUYfAP9/ofCe5ZsBn7vCcqeSLrD4StbQWgr6KsbPMAWHQs/fyAD8CGIYJC5mt2s4
8ql3Mq8HIHKs0pO9AEZRppMaRfo9pwg=
=82fL
-----END PGP SIGNATURE-----

--a22ccqmtjj2bxifh--


--===============5556089520743822051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5556089520743822051==--

