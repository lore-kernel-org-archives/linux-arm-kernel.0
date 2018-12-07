Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7370AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:35:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444F120837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BNH0IQ5f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rknlvflY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444F120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=MYQZ40X7/KBnS94rcuUH1xDquv/uFFDn+6EJeGEMcZ4=; b=BNH
	0IQ5fX697h6Taga6oI9llVO1m2ScmH5SfQ8ElteQHtNKUbUUT6gY6HV6cwRiUpHE4f/kxBSsuZEVk
	pkLLH7epZGLSlWaYl06EAl8VwLyhwlwcqwCwi2UwDJkmsRclhAtTviafTL+o5mimDpxouJ4ZxJyOL
	uwttp1pwaAe59OByTv5KxXxMHjuoJnOBo5137UsD2TEJX6yz+bgVEksC1uojvNmb58B+8rKXNmbay
	rV8Zef2OMfq+ETJ8/2I6fdlOw7DZ1FINMehYSh+dcyTUBkH0N8CpI5rTBuz234xRqaOIavIGrv9rk
	CbGJPW6aT9A1qhAL7wjAswSXQkiQ9Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHE6-00034k-3n; Fri, 07 Dec 2018 14:35:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHE4-0002vG-4T
 for linux-arm-kernel@bombadil.infradead.org; Fri, 07 Dec 2018 14:35:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j7ExLn28PbNoFWc5G8Nv3eIZ7+hdeaaFwHH5i9x55Gc=; b=rknlvflY2Ntxock2poqiGZZqvF
 hFGGPY30htW/P8YwCkFo8ntxl3jlGtDBigciWhntXHR4dOcZ5shZMuPLx/lF+/soi+t3XcR+3GZ3G
 hruIFm73ZPW2WlsSEHHlJneVBCc+GwTEHz84p8NrUyUZ+8vZnvAVb8SpwU0iNZa4caCEFmDXc/SWS
 fR+4n+W+o4WeDnllKgcxhX4adNobbtMBPpoyCERzXV+gEib2nDUb4Cgnzf88U06IjMD0kQJyN8pNG
 QqlA1dcJih/XcTWDS7bVlOosLqkm2BG73btn5VnyYdbUrqJK2hz0uXl9xYfG//hMkkNlc1O8lMpIe
 cisUp0tg==;
Received: from mail.bootlin.com ([62.4.15.54])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVH99-0004tb-5u
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:30:28 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6500220CC3; Fri,  7 Dec 2018 15:30:15 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3904D20886;
 Fri,  7 Dec 2018 15:30:15 +0100 (CET)
Date: Fri, 7 Dec 2018 15:30:15 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner drivers changes for 4.21
Message-ID: <20181207143015.qemj5ny36hyv2kug@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_143027_224965_BB6E0F02 
X-CRM114-Status: GOOD (  12.28  )
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
Content-Type: multipart/mixed; boundary="===============4816176239675637140=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4816176239675637140==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n7m4x4o42d3n4b46"
Content-Disposition: inline


--n7m4x4o42d3n4b46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd, Kevin, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunx=
i-drivers-for-4.21

for you to fetch changes up to d44d37cb27df5501de0693fb03803e244653713c:

  dt-bindings: sram: sunxi: Add compatible for the A64 SRAM C1 (2018-12-05 =
12:03:47 +0100)

----------------------------------------------------------------
Allwinner drivers changes for 4.21

Those patches are all about our SRAM driver, to enable new SoCs: the
F1c100s, the H5 and the A64 C1 SRAM, that is used by the video decoding
engine.

----------------------------------------------------------------
Mesih Kilinc (1):
      dt-bindings: sram: Add Allwinner suniv F1C100s

Paul Kocialkowski (4):
      soc: sunxi: sram: Enable EMAC clock access for H3 variant
      soc: sunxi: sram: Add support for the H5 SoC system control
      dt-bindings: sram: sunxi: Add bindings for the H5 with SRAM C1
      dt-bindings: sram: sunxi: Add compatible for the A64 SRAM C1

Yangtao Li (1):
      soc: sunxi: Change to use DEFINE_SHOW_ATTRIBUTE macro

 .../devicetree/bindings/sram/sunxi-sram.txt        |  9 +++++++++
 drivers/soc/sunxi/sunxi_sram.c                     | 22 ++++++++++--------=
----
 2 files changed, 19 insertions(+), 12 deletions(-)

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--n7m4x4o42d3n4b46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAqD9wAKCRDj7w1vZxhR
xR5PAQCA968G5Pguzd5E1msphGEAhCzE2fnCmICLMU2CG8EWzAD+Pq5/Vqgv0XQB
Z6L4CrRaVo82Cy/RWfe4tQYUe2zEzgU=
=G9AA
-----END PGP SIGNATURE-----

--n7m4x4o42d3n4b46--


--===============4816176239675637140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4816176239675637140==--

