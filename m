Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC24C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:58:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2387821104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fi1Yr7Pt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="MKsKmtcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2387821104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=PjXJCdFeCZuBuy9p1Ubxy7BI4QwVV+shsxx0rVdJN88=; b=fi1
	Yr7PttnTqk2AIX1Y/AovoHlEiR9gXKeD2Nkju7r3Rto3yn+RlClnztd1GKkoDWw3XekUNcmJ7NlEU
	uiDCeuBRBAMsUr6zWm0TRf0uoFngLnP4iyAZLADLf+s+Zo8goMFklBBeYSdRV2jUUEKmsc3LfHma8
	FqrJ0AR81zdJLo2yVl6X2fE/MLCI5GQTdpz/FrvUA/ZbWFhApQRajLn3t7ZYG697QXT1ymmNTLHa7
	q1Ka5VOqOy/uybS/TCG2ZueXe8wjfqE8yonYVDaIww3LG6IWzgF3B8hGaWFOHyqiQpkLGX8Kv302n
	lAjzutMJVp9EA2eELyKT8Hu6g2Y4h9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXm6l-0001Yb-Mw; Fri, 14 Dec 2018 11:58:19 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXm5x-0000Tp-1y
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 11:57:33 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 63A3025BEEE;
 Fri, 14 Dec 2018 22:57:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544788622; bh=TBWDS+aSutTRIbhPftQS3+m1K5ao0ikORLBoGeEau6c=;
 h=From:To:Cc:Subject:Date:From;
 b=MKsKmtcqCnwUpOQHD7vT+KSiByDBa5QEy+YZ4QmJD9ZK8ggl0tjpTx4Q5Yl3n+anw
 npgqHxBarBL/+p7DiUeAoMG80Ex7I4p/mnxbzsccxCnGyeZ46WmTQX+sOMb54RLJuD
 h5OlN8U5KbqQzI1LcmcNnICezoraySHHgS4X3CVw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id C1B019403C3; Fri, 14 Dec 2018 12:57:00 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Fixes for v4.20
Date: Fri, 14 Dec 2018 12:56:59 +0100
Message-Id: <cover.1544705534.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_035729_930876_4C77D949 
X-CRM114-Status: GOOD (  11.50  )
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

Please consider these second round of Renesas ARM based SoC fixes for v4.20.

This pull request is based on the previous round of
such requests, tagged as renesas-fixes-for-v4.20,
which you have already accepted.


The following changes since commit eab53fdfd60a84b0cc514d4f1f5d79226c76df01:

  arm64: dts: renesas: condor: switch from EtherAVB to GEther (2018-11-05 15:08:44 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes2-for-v4.20

for you to fetch changes up to 6f61a2c8f1f6163c7e08c77c5f71df0427e4d2f6:

  arm64: dts: renesas: draak: Fix CVBS input (2018-12-13 13:47:30 +0100)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Fixes for v4.20

* R-Car D3 (r8a77995) SoC based Draak board
  - Correct CVBS input to allow probing of the VIN

----------------------------------------------------------------
Laurent Pinchart (1):
      arm64: dts: renesas: draak: Fix CVBS input

 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
