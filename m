Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31432C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:32:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6942084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y9SW40YI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6942084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=e7ILBy1YxUVfJXtnkJ550+bmm42PXt3wynerJU5tgsY=; b=Y9S
	W40YIH14QdAYsy2SocEyWf8jBIDuROYCdFD3k5l49JT3Q7OL/YHA+wjcy2pzMpBnof6n3IQKU68Al
	yxf8l06OLyeQaZYvmwHkn6aQ7R7pKuYYthAixQNfvTMCHLb+FRqEfFT8zQaijs5tcT83USHsBXRYx
	Urxbs7jvJGyf60rnC/k2xdB3PLuyviAWauRt+0J7f6slgBOmp7KolYbqX7QYesIsXAl0LsIfNB8xc
	iOZqQFtzAyTrornz6lXhUA7pKrBzf6VGKGaXiFghnvQ/oHS5mFAneepNoPDI9GrTEn1MZIq0tnUEB
	AKIIFg5kRjacenmUwz4jXnzl5KW+0fA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gic7v-0005ia-6g; Sun, 13 Jan 2019 09:32:19 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gic7q-0005Vi-NL
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 09:32:16 +0000
X-IronPort-AV: E=Sophos;i="5.56,473,1539640800"; d="scan'208";a="291725798"
Received: from palace.lip6.fr ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 13 Jan 2019 10:24:46 +0100
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH 0/4] add missing of_node_puts
Date: Sun, 13 Jan 2019 09:47:40 +0100
Message-Id: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_013215_060671_2286DE83 
X-CRM114-Status: UNSURE (   7.07  )
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The device node iterators perform an of_node_get on each iteration, so a
jump out of the loop requires an of_node_put.

The patches for drivers/gpu/drm/imx/imx-ldb.c and
drivers/gpu/drm/sun4i/sun4i_backend.c contain some added of_node_puts for
which the need was identified manually.  Details are in the patch logs.

---

 drivers/gpu/drm/imx/imx-ldb.c           |   25 +++++++++++++++++--------
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |    5 ++++-
 drivers/gpu/drm/rockchip/rockchip_rgb.c |    4 +++-
 drivers/gpu/drm/sun4i/sun4i_backend.c   |    1 +
 4 files changed, 25 insertions(+), 10 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
