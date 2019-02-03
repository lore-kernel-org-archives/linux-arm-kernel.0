Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC97C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:44:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415342083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ibH3A44B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfBrajNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415342083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VT+sT3r/tcKF8pjT1+exCBRz5FaOcBDVjz0H6R2ZF58=; b=ibH3A44B5jabZr
	/TQpkvy9QMP5fKQKBoHsyQFmCnUhlCr/pUwYOznGooEW2ZCj9+wukwHLxdKq9jUW4uv9MVb2U2k0m
	z5AT+Q6/aICzrxZ0evW2r3cgyo13kYGx/pnU0/1u5hi3QSqIZX8WSGHGmaf4IzPWcZmvCuqcQEk9k
	h/pt+ykp7TqIFRjj4m/9Mh7dQGSup34PdSs+RsIGG57whlU6ILPCc9LCMvd1/aBYu470Eo8IubUtj
	JaNwWzs3JTITDjcGXyn50SCHZOTGS/IXfb9h01m6gU1hsj/H15Ukif+UJHywgtx2ZGDDD5T2EyPRX
	10BYa203G1F+j7KaYOOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gq6pX-0000oh-85; Sun, 03 Feb 2019 01:44:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gq6pU-0000oG-C8
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 01:44:17 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1CE8F2083B;
 Sun,  3 Feb 2019 01:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549158254;
 bh=tGLFz3zhsHCdlpsupksEJi7xoeCtLEV+ZVhSkMm1TU0=;
 h=Date:From:To:Cc:Subject:From;
 b=dfBrajNr4pZlsJFqMj+e/XFMz5j8M8LX5a6UkJ9uvLhKwa6MdsobMvbuL3QsZ0gSF
 D3IpgFg1AWA4JfpuIcJHVPUFM94CVnDjrDcRkrNFdTTxwl5L7adIF/EhsF7t43go5V
 B8uWFDz67jp2IlPoASEjDn3QTUkS33dITv5GGQAw=
Date: Sun, 3 Feb 2019 09:44:02 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL] i.MX fixes for 5.0, 3rd round
Message-ID: <20190203014400.GB22413@dragon>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_174416_433853_81C005D2 
X-CRM114-Status: UNSURE (   8.68  )
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
Cc: linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
 linux-imx@nxp.com, kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit c5b11ee9f1c22a8d6b5cab2099904f7adbe79a7f:

  dt-bindings: imx8mq: Number clocks consecutively (2019-01-16 21:27:02 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-5.0-3

for you to fetch changes up to f2ce6ed3dcc837af8ddb4076c71f5d370e65f6af:

  arm64: dts: imx8mq: Fix boot from eMMC (2019-02-01 11:50:03 +0800)

----------------------------------------------------------------
i.MX fixes for 5.0, 3rd round:

It contains a fix for i.MX8MQ EVK board device tree, which makes the
broken eMMC support work as expected.

----------------------------------------------------------------
Carlo Caione (1):
      arm64: dts: imx8mq: Fix boot from eMMC

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 44 ++++++++++++++--------------
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    |  2 ++
 2 files changed, 24 insertions(+), 22 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
