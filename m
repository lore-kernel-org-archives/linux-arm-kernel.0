Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A868C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:12:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6909D2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gx22KCuu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="j5ZbslkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6909D2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=+ccWsGpKwtz69OkTbg1mw2cOETJfQb8LM8Fiqad6Fbk=; b=Gx2
	2KCuuq/HTDTI7hrIIycva7Hy5Kq1VFZ1RHS+dHvlbT+m3Q3dQ+TZjruArNk5LxTJSnUDz8keYrPo5
	d3QxqT9fd5riVm8Pm2lp7gByyCL1hvGrj9Qr7uaU+vjnhVlqlnAr8OL7dAVJPLEg9KXT5dGJz4a3B
	qzlVxJd2S0FbBkd4S38hH5f7jr8ul7Wz34uPPJIFWDvQkerj65whkJhEfdD+THREyb/9gFCLZMtjX
	GdmysR0wZBPOfnaKt18Gzp3EZun4nRVUp5Qv1uXNB6ulE8zYmLcwsCGjABBFUp64lYQuo6nBzP2oK
	BTjdsd3M7uk/kRaRzBnUiA2JCWyDvtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgfj-0000AB-MG; Thu, 24 Jan 2019 15:12:03 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgfg-00009e-63
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:12:02 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 1E5A925B769;
 Fri, 25 Jan 2019 02:11:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342716; bh=4mcnUUvAhGKR3MnntaA01oAco2nxFEtKi5r6Z5fVDeU=;
 h=From:To:Cc:Subject:Date:From;
 b=j5ZbslkHxf5kJks8zVpLCaXB4i/MyAIH6RdsR+JtwMQZvAL3L1xjtPmUb56zDBgsm
 8+3QD0lVJqKcrqh+YwkelJqyxiAvyEUCHVC8ih0QEsU7DPLIR98TA+WT5iQcuD/zJY
 pV0y/J5f6RzQ340TDFCDprfW8zq3C4F/wEID/AiI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 499EA940471; Thu, 24 Jan 2019 16:11:54 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Fixes for v5.0
Date: Thu, 24 Jan 2019 16:11:52 +0100
Message-Id: <cover.1548165440.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071200_425631_DAFF2E09 
X-CRM114-Status: GOOD (  10.88  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Simon Horman <horms+renesas@verge.net.au>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC fixes for v5.0.

This pull request is based on the previous round of
such requests, tagged as renesas-fixes-for-v5.0,
which you have already accepted.


The following changes since commit a64597227d0de5610407fcc95dc835745a53f5d0:

  soc: renesas: r8a774c0-sysc: Fix initialization order of 3DG-{A,B} (2019-01-07 14:51:51 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes2-for-v5.0

for you to fetch changes up to 05c8478abd485507c25aa565afab604af8d8fe46:

  arm64: dts: renesas: r8a77965: Enable DMA for SCIF2 (2019-01-17 14:22:23 +0100)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Fixes for v5.0

Enable DMA for SCIF2 on R-Car M3-W (r8a7796) and M3-n (r8a77965), and
(RZ/G2M) r8a774a1 SoCs.

This is was omitted from patches enabling DMA for other SCIF devices on the
same SoCs due to missing documentation.  However, it is regarded as a fix
as arguably those patches claim to add this feature.

Per-SoC patches are provided to ease backporting of this fix as the kernel
version to be fixed is different for each SoC.

----------------------------------------------------------------
Geert Uytterhoeven (3):
      arm64: dts: renesas: r8a774a1: Enable DMA for SCIF2
      arm64: dts: renesas: r8a7796: Enable DMA for SCIF2
      arm64: dts: renesas: r8a77965: Enable DMA for SCIF2

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 3 +++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 3 +++
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 3 +++
 3 files changed, 9 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
