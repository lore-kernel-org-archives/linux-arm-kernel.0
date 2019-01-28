Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDD2C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:27:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0AA21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cptIGHDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0AA21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=TV+8ASNC3MGsAWqtQHk3eIliYaDCWL1lxPqZS9/g618=; b=cptIGHDiNzdrth
	EGJbW/Y5HDoSL03VahUNsrgJ4YgBpLvOXhr4MDSbwGmNwocjBCW7hrEjnHISt+2u7ZwfQJRpkEi7/
	1+0viicg/DbWSxTXETgdYoyv2avCrqk7Qdk5v7OK6u5ZEXa1amXdPKSptqEetXvNTv9kNjr7eGnKh
	8SgWN3T3TCxSGbkALeDMTEnoF1WGjhcYZ3j2HF9AiXAz7DMldjl43DCos9Bn38mpVSRyxadOPvSGg
	3/II3LAEJFzF3aFx3Cv9HHfms9NcveNqjgeiilEmEP48Qo13DKNYjUH0ZX30thWD9xzBnWh3SB9JZ
	sjqfjSJqpiQOxOou6oJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnweQ-00022P-FC; Mon, 28 Jan 2019 02:27:54 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnweM-000226-RQ
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 02:27:52 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id E9F0A5FCDF; Mon, 28 Jan 2019 10:27:48 +0800 (CST)
Date: Mon, 28 Jan 2019 10:27:48 +0800
From: Chen-Yu Tsai <wens@csie.org>
To: arm@kernel.org
Subject: [GIT PULL 2/3] Allwinner DT Changes for v5.1
Message-ID: <20190128022748.GA4728@wens.csie.org>
MIME-Version: 1.0
In-Reply-To: <20190128021635.GA30661@wens.csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_182751_142419_CD5D170B 
X-CRM114-Status: GOOD (  11.31  )
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
Content-Type: multipart/mixed; boundary="===============5741015705199833122=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5741015705199833122==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-5.1

for you to fetch changes up to 55533921301e83162584f87fe571545056d03e09:

  ARM: dts: sun8i-a23-q8: Set compatible string for LCD panel (2019-01-25 10:43:20 +0100)

----------------------------------------------------------------
Allwinner DT changes for 5.1

As usual, this is a random assortment of changes:

  - ARM PMU is enabled on the A10
  - The first usage of the PIO pinbank regulator supplies added,
    for the Bananapi
  - Broadcom-based Bluetooth enabled on the Bananapi M2 Magic and M2
    Ultra, using the serdev bindings
  - Video codec added for the A10
  - Display pipeline for the A23 added and enabled for the generic Q8
    tablets

----------------------------------------------------------------
Chen-Yu Tsai (10):
      ARM: dts: sun8i: r40: Add pinmux settings for UART3 on PG pingroup
      ARM: dts: sun8i: r40: Add pinmux setting for CLK_OUT_A
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix WiFi regulator definitions
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Add Bluetooth device node
      ARM: dts: sunxi: bananapi-m2-plus: Add Bluetooth device node
      ARM: dts: sun8i-a23-a33: Move NAND controller device node to sort by address
      ARM: dts: sun8i-a33: Move display pipeline nodes to a23/a33 common dtsi
      ARM: dts: sun8i-a23: Add compatible strings to display pipeline device nodes
      ARM: dts: sun8i-q8-common: Enable display pipeline with RGB LCD panel
      ARM: dts: sun8i-a23-q8: Set compatible string for LCD panel

Harald Geyer (1):
      ARM: dts: sun4i-a10: Add PMU node

Maxime Ripard (1):
      ARM: dts: sun7i: bananapi: Add GPIO banks regulators

Paul Kocialkowski (2):
      ARM: dts: sun4i: Add support for the C1 SRAM region with the SRAM controller
      ARM: dts: sun4i-a10: Add Video Engine and reserved memory nodes

 arch/arm/boot/dts/sun4i-a10.dtsi                  |  44 +++++
 arch/arm/boot/dts/sun7i-a20-bananapi.dts          |   5 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi              | 175 +++++++++++++++++--
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts         |   4 +
 arch/arm/boot/dts/sun8i-a23.dtsi                  |  20 +++
 arch/arm/boot/dts/sun8i-a33.dtsi                  | 194 +++++-----------------
 arch/arm/boot/dts/sun8i-q8-common.dtsi            |  37 +++++
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts |  41 +++++
 arch/arm/boot/dts/sun8i-r40.dtsi                  |  15 ++
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi     |  16 +-
 10 files changed, 379 insertions(+), 172 deletions(-)

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nN1m/hhnkhOWjtHOJpUIZwPJDAFAlxOaKQACgkQOJpUIZwP
JDARvhAAkknIw4z3PmMsQ0xZXCnA+zh16y/TJj+gAUCKOvMzwxtjXtU/VrvSchdx
8sA/P9qDLv19Il8IMJgkDaC8v3xrIfw3daZnwS/gr59xlWSHTTO8LUldMKD1++/N
gutjNFas7FurlwDfGfp1ZLyE0pa2JorrPATvCT5WapAZzsgnqgR27lSQbxchFMpo
ypuHHI+JBEY2/P5cXpZ0UjiCfrlU4PKQoIibVYwtJR1YzDgVanZNEa1SR/M3rA0t
bDcXF4nKDN+biSuBy65W4C+uCr/zpCm/djBIp2zKY4+aQPS4ZkmEGtttEdxi8YSf
ZHW6RQoqSwj3tiW5YeguOdq4gDkUrCWsmDPsZGuqmehFasXXZzExMR3cWay6x2fg
kYOXoRcJjUanSTuzSqil8dtPKYddKqpNfVt31bchLG8OrRo4EOIT7mekHWqtfw2y
ZYSDzhK0NlpbG6QHSyEbhg5VrDJ387DvYdCxMlvgYi5Ohjilkxun3RIJGqBVgK+/
i3Fp3qy+yaefoCJPx8RBQlw/Td1nfQqCP8WBJ243MyOelrbJ0hHMM5rZWcm0+iPY
lwzTsfosqwiiPquihjE0m0x1dnMKuHDBY7TTVoLz70wvIhjuG09YZFSyjUpvj90a
cl2q0Ar2hAMJ3VzbOdd8s/mDw0AodN8mrRZ3BGv2pZHAAY9IU5k=
=rs9J
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


--===============5741015705199833122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5741015705199833122==--

