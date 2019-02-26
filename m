Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF7BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:26:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9453B217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GH6imHDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9453B217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DqfTzjQ3OKTt1Ez3ereaCfcE5fWuaVUOadUAuPr9va0=; b=GH6imHDlYNpgWp
	zoAqsAH548eZW77Hh5xKL17qpcIbdPb+tuR/QvN+4AwGAPYg1jBY14S4c9NMKihDR4oOtJlMcSiiP
	fs7BsOmiUwmXkJGTt+/JNHijGvFb8wc3qS30jT59vBGoaAoXcgefCFhLdSrJmO7GzmIFTUN7JA1XF
	G3zHYgaHoCUXkwUubt7/++7atFzg3PDt6QtrhDp2+ylcs9xCrG7720XRU7/NcCdpdiW7dr8faUXv2
	5HQG0JOJA4wFzv+Db9F+esv5e3S9r780DsB8BPdOqzfnThamGL0e6ga6qhoPdtiLLaCFv2LKZua7Y
	QoRVbwzJ3dQTkanBdEVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydgP-0002eV-HR; Tue, 26 Feb 2019 14:26:09 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydgK-0002dR-Fi
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:26:07 +0000
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 26DF5240002;
 Tue, 26 Feb 2019 14:25:54 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 0/4] drm/sun4i: rgb: Relax the pixel clock check
Date: Tue, 26 Feb 2019 15:25:45 +0100
Message-Id: <cover.3a2868d9beb0d45f77f844aa8707810909ffebed.1551191081.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_062604_679596_1A60856F 
X-CRM114-Status: UNSURE (   7.06  )
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
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

This implements roughly what we discussed as part of the ANX6345 series to
relax the pixel clock validation while still filtering out the modes we
can't reach using the bridges.

Let me know what you think,
Maxime

Maxime Ripard (4):
  drm/sun4i: Move the panel pointer from the TCON to the encoders
  drm/sun4i: rgb: Store the bridge pointer
  drm/sun4i: Move rate variables to long long
  drm/sun4i: rgb: Change the pixel clock validation check

 drivers/gpu/drm/sun4i/sun4i_lvds.c | 29 ++++--------
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 74 +++++++++++++++++++++----------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 +-
 3 files changed, 64 insertions(+), 41 deletions(-)

base-commit: bfeffd155283772bbe78c6a05dec7c0128ee500c
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
