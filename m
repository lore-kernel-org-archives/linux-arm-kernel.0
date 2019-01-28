Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69CDC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:29:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768AF20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="USzakpFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768AF20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=fRcZNlh8U0Qq748CaPBntjKcdfZLPfoPF88FqTXe/Xo=; b=USzakpFfebTB8m
	ca6eFTtXdPVgyfZdkpzOkq7z23VQnJP2/AQIJ5tJWvbixffMP/qqSVxRiYahjaIvm6Axq6Rspr13K
	217ak7UalwKS864PEUNXH0cuaaILKXIQVXfvHKFoBxVIROJPJHbxliKoaQEHtCvRVZE5LP1+HHimi
	yRnZ8nD6Vlfb3s7KWWLP70lSuyIqqxzUl0vEqZMKaKRFp1w++zql/Cj0X/liYiQ6bk+HXNEHrOmr4
	oRujrwYWvSS4XzEwTQOnBGFVKjFDWYTe1z7CnUKRcqRDlOCB9UGlF5mCDJ0kN9WBpM/9fcEdCZp/u
	8jiHwnlhHD5CzNJDyHOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnwfj-0002O8-Td; Mon, 28 Jan 2019 02:29:15 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnwff-0002Nq-M7
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 02:29:13 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 6FAB05FCDF; Mon, 28 Jan 2019 10:29:10 +0800 (CST)
Date: Mon, 28 Jan 2019 10:29:10 +0800
From: Chen-Yu Tsai <wens@csie.org>
To: arm@kernel.org
Subject: [GIT PULL 3/3] Allwinner DT64 Changes for v5.1
Message-ID: <20190128022910.GA6772@wens.csie.org>
MIME-Version: 1.0
In-Reply-To: <20190128021635.GA30661@wens.csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_182911_848154_1557E3E3 
X-CRM114-Status: UNSURE (   9.15  )
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
Content-Type: multipart/mixed; boundary="===============1058684695178285367=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1058684695178285367==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunx=
i-dt64-for-5.1

for you to fetch changes up to 55ec26d6a4241363fa94f15377ebd8f1116fbfd7:

  arm64: dts: allwinner: a64: Enable A64 timer workaround (2019-01-24 18:23=
:26 +0800)

----------------------------------------------------------------
Allwinner DT64 changes for 5.1

A few small improvements for the A64 this cycle:

  - ARM PMU added
  - Allwinner ARM architected timer workaround enabled
    This works around timer value wrapping found in the Allwinner
    implementation of the ARM architected timer.

----------------------------------------------------------------
Harald Geyer (1):
      arm64: dts: allwinner: a64: Add PMU node

Jonathan Neusch=E7=93=A3fer (1):
      arm64: dts: allwinner: a64: Fix a typo

Samuel Holland (1):
      arm64: dts: allwinner: a64: Enable A64 timer workaround

 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi        | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nN1m/hhnkhOWjtHOJpUIZwPJDAFAlxOaPYACgkQOJpUIZwP
JDDpRRAAyApxa7o0RPVo7y4oA67r+317yXCv2v8glqGm/xwUfIuHj11LcfsxoOoZ
OssymZmZcfjTlVcGUKvyg7jFrVsSpN/uGV6WmN+LI+18RoSppAgyR5vmgd7J2ojN
YqW1OgUTdXDXXrFqEXALFrxZRztXIhJq6oacLc9XJH0RgLanuFUD4w1s5toj47PJ
5fldLzBuSTYsZi84WsxbFg1RU6J3B1PQzmqpaI6iLf+E0TxEKZE5lJhDvJWuLOaY
s4sJvxSTEaMsXn4w0PwO552+fTQKeMB80Ft37mQMuTB+foWi6Qs5NltuCl61vU2z
7SHciGui1kq/M1m4W849Dp8NCKVkGgaouCFittX51tYfx373opu/Z6L6W9EkkPGq
ifpvTnSzXo+7pgl7vCOiIBOTsaQlcToW7HoP2Gtc+85+NLahV62VQAk0GN0hAkBe
dWvGExFL+bhpn22jj2WYwOk9GzZuf23qPU5clQk2S21ZHU8UO0dd/p24tqWAkUIN
OihKY/froawsyWTLa3tKsYt6ohP+/iGADEh1EQicvpYEP++H2FVevLVBkybSRfBZ
CUJrVGA1zm44PVg2IwE/MSUv68icC2WcsDaM0ZEJTsDVv6TWTF/YpN7/DZ/aMfLL
2t/l9QPO7+NVV4i2xOXid+5Ry3/qnG+YMFA3ioC31ww2I4yOLwM=
=Zguf
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--


--===============1058684695178285367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1058684695178285367==--

