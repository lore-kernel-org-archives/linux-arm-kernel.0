Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18993C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:59:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D708121871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f50eU6Rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D708121871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9px5dHgiWVuZsAPwCbIZMJirWdX/QvQuv17rH0eOhaA=; b=f50
	eU6Rz4MMiISKwio85Is0zDTmYrp5gl8q13oPzSsQzcPiqbM82YtFzxCTREZc1iF/11kjXTcwj9XXy
	sSX90vUoYR+vu1X0swFTvrSVCHqJD4nKt7fSyEmVM0n2sDuvCBHd2DLBou62TJ6V9W7tAtow2Dnt/
	Jl45U1snKjojKZUzUKG2lTGHtf4GPnMYKPFdgwZX06xg5TKexKgXQqLd+EE6Zl9EXMhh8G/Vthb1X
	3Wub5b+X8DcsQM256p+SWy5eBAdnxVIPwTbO4pvi++uQ0EUJlTkRSe1uKFHIsT4Lux49Ijj4Rv3d+
	jWPRSMStHLJgogInMMXM36MfjBGLjlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYd6-00031P-Bm; Wed, 19 Dec 2018 09:59:04 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYd3-00030D-0H
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 09:59:02 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id E9B935FB45; Wed, 19 Dec 2018 17:58:47 +0800 (CST)
Date: Wed, 19 Dec 2018 17:58:47 +0800
From: Chen-Yu Tsai <wens@csie.org>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.21 - round 2
Message-ID: <20181219095847.GA6281@wens.csie.org>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_015901_237026_7B2150B5 
X-CRM114-Status: GOOD (  11.24  )
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
Content-Type: multipart/mixed; boundary="===============2754026876037989706=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2754026876037989706==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd, Olof,

This is a late pull request for 4.21. There's only one patch, as shown
in the tag's body. Like the arm32 DT PR, the patch from a series that
had been posted over a month ago, and the driver bits were merged today.
We'd like to have it included for 4.21.


Regards
ChenYu


The following changes since commit 44ff3cafcd7f413e7710a58ac40cfdc3a9380097:

  arm64: dts: allwinner: a64: Fix up RTC device node and clock references (2018-12-07 10:23:39 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.21-2

for you to fetch changes up to c266a2b4407af7a6fc39f449782aa5c0be48be5a:

  arm64: dts: allwinner: a64: bananapi-m64: Add Bluetooth device node (2018-12-19 17:22:41 +0800)

----------------------------------------------------------------
Allwinner arm64 DT changes for 4.21 - round 2

Bluetooth using a Broadcom (now Cypress) chip connected to an UART on
the Bananapi M64 is enabled using serdev and the updated bindings for
Broadcom Bluetooth. The patch series had been sitting on the mailing
lists for a month, and the driver bits were just merged on 2018/12/19.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      arm64: dts: allwinner: a64: bananapi-m64: Add Bluetooth device node

 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nN1m/hhnkhOWjtHOJpUIZwPJDAFAlwaFlUACgkQOJpUIZwP
JDAbWA//a1wI2PLdZ4wmDd/ljPRIgRGJVkH8e+g5Pz9EEwaUBLESsumk44uCTCo1
3xsJv7e+zVx3SdfoEhOfkc/sNAbnexLVdj0vzmFLZ8gzKl0vtxP8ysZMwetYkW9h
lAmb4u89UhseE/DQoRRpAhQ9ZgWgeb8ltkDPLLOTtpolv19CUV3U2D+rIzr5R4UP
73+ji8PQEaEpEe8E+1PYpVG02xNq45iMV+dPg+cjptLuQeOjZ7YXF0KruEH+p3z+
dIF4VM0NEX10RfZO85SQzRIh0rcJX0HMQUd8XrU57IAB1Tjo1nyJsTaUsB5ybJ/+
hNdPAZJD97Rbyxo2bn/68FB7Uy63XjEeF/skS0DMl/iM3rUyXehFAAMSptATcCCV
YIuXIZ+cirS1HXLEY1SXFWncj4JyL/PYX4JVUURtOF+tCyD3YtOv25Vaz63UpxwF
4iUITI8Ugeiuf5F2g5+/Q3JR3FRhJ7NaiFLwgKeWYKHIaN7yfX0FoWlUzNC+MhJE
WXnk/SZcfWbLC1IJEGnMJA1ZShO1p9nB7TCaSEhcj7CvgeyJhhsmynW0F32pVf46
deU5+qvDkyE3hQPMtsCWylnubd1cvYMQ/vxM2lyE7dzcB8EByg7ZZeADgsZBDSQb
NqE/BB24V2bwei5g27d84wZQcv9NA5/5SncefKPYyjwv8m8BtV0=
=lUpX
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--


--===============2754026876037989706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2754026876037989706==--

