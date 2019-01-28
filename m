Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAD1C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:26:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B06820C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GJhTrSUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B06820C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=JwjtCGItQy/bC4SmeKCD04NkXYNk1FMzDtB09fZH5pQ=; b=GJhTrSUC4Ksy9c
	sk9R4EjLRdDhcpuOoCHj6I5/iH3/MsTFOen6qQF/t7Y4ancNsYlILh4pdbydHCIBM7PXTHwhz+3is
	Yk04kRr4JNsjU8EBZwK4Gl+PSHQDTTcQhExXTO/NeV/OptrkOmkpoVnCNzmPqz1RPGlhu6nN6M3cn
	0FXcMHFMgSic06fGdHk6QePF/sROji1A9pFs+fD63S39fFsYFtKrKx7YRe9PEEn6etVLnxyvDECJb
	UWdNn5lNp7BCKGdNeXlKxYdiawj57mgYJn+ExvKsOEsj/kEW2O0Ac5h+vciAAOZXXFwvQwdacNJxu
	7r1QVReSVJeTtco+yXCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnwcc-0001l9-Ji; Mon, 28 Jan 2019 02:26:02 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnwcZ-0001kq-CT
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 02:26:01 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 0DC8A5FCDF; Mon, 28 Jan 2019 10:25:58 +0800 (CST)
Date: Mon, 28 Jan 2019 10:25:58 +0800
From: Chen-Yu Tsai <wens@csie.org>
To: arm@kernel.org
Subject: [GIT PULL 1/3] Allwinner Fixes for v5.0
Message-ID: <20190128022558.GA4564@wens.csie.org>
MIME-Version: 1.0
In-Reply-To: <20190128021635.GA30661@wens.csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_182559_646791_72CEBC3D 
X-CRM114-Status: GOOD (  13.54  )
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
Content-Type: multipart/mixed; boundary="===============4417244337718618358=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4417244337718618358==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-5.0

for you to fetch changes up to b1360dcfdaa1d55952e5ec8dd9d99f88965d7ac9:

  arm64: dts: allwinner: a64: Fix USB OTG regulator (2019-01-10 08:03:48 +0100)

----------------------------------------------------------------
Allwinner Fixes for 5.0

A couple of device tree fixes for the 5.0 cycle:

  - Add missing clock-output-names for the osc24M clock on sun6i/A31

    The Linux clock driver uses the device node as the clock name if
    the property is missing. The node name was changed in 5.0-rc1,
    breaking a subtle dependency in the sunxi-ng clock driver, and
    renders Linux unable to completely boot up.

  - Add alias for Ethernet controller on Beelink X2

    This allows the bootloader to assign a deterministically generated
    MAC address to it.

  - Add property to enable USB VBUS regulator on OrangePi Win

    The board had defined the constraints for the regulator, but was
    missing the property to actually enable it.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sun6i: Add clock-output-names to osc24M clock

Jernej Skrabec (2):
      ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2
      arm64: dts: allwinner: a64: Fix USB OTG regulator

Paul Kocialkowski (1):
      arm64: dts: allwinner: a64: Fix the video engine compatible

 arch/arm/boot/dts/sun6i-a31.dtsi                          | 1 +
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts                 | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi             | 2 +-
 4 files changed, 4 insertions(+), 2 deletions(-)

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nN1m/hhnkhOWjtHOJpUIZwPJDAFAlxOaDUACgkQOJpUIZwP
JDBA+w//b3JXKOZm41yj+rg1gpbp75r6otxDFsJnU9REd3D2CmkIbOc0Yd00IuWA
lNzrsV02iK4oN8yZ9H5iBxeJlBV/2/Q4sTWYCEF+bB5HkiiOwW0amVTaMAvIWfpZ
Zmn2MlNBbvdN9DMSudHaN514S6Rb1MiOqUHn+PNFuyhmF7e9cPnpy71sfmWWTtdZ
ginXV800EQiwpua9xDhh/khVDbnX8lc837O6MLSInhupkQdPE4CH9CGYOt8aevwI
E6ZCdyr2F3M/SIqWLe4xOkxHLBrdm4COz6F8XrnfzhC4Zzl0Gkt8QO6/+vj9P95x
xwk4dWpshoND9aZ8xLUOSSs4EvFpVpQPlSpWmFNbK8QNZH7kPTaXFFiXZPyQzOfC
FX7OhXk4H/iDfm5AqRJm8GyDAQ5SohqXZslb5CIa3IbnWBQU9QuCIRAPHw4hr2kR
3bgDs2oJxHb6LwuWv0O97tpDY7pDjj1vJ6r+wswMKLsC1CpkcuvAqj51hkFXhako
O3pR/bGVf/EBC3L5jd3mzY2kX/NHSiKVTInRSB06jezlGnu8/R2OM7syVIoOglhj
TMZSLGQFQu7kciglWL7jTXTpAINGUXSWacBEIr/TS+0KqVSiBbc/AgYJ40Xzd92j
cTbL0fona0/Us+yioyDnFZkin/L5ok0SDwk2JVgSz2M/bs6qrRo=
=0a1Q
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--


--===============4417244337718618358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4417244337718618358==--

