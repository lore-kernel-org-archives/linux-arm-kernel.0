Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F14C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:40:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1736206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l/NzNV3S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aB8QgPtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1736206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lMHBTqUq61JQbDeEgw5kFcuTa00ZFPQBwiC5N62lCYI=; b=l/NzNV3SAZvGwG
	xe/6vM5j8Pty3OtdhrOSu+6nc/+KKxkTyfK2feNkOtidaW8RldVLMldpfXFxPkCqOC5lIrMJf6YbG
	o1cOdsMP1hNeDWnYdgAwYDTS8tjzKdmk85AmPAuQkKecCEK9QeYD+0Th+uBSh7eWrcNB0ILfoyJRC
	5emIyCQHQtt21sjiVcsPoWbqYaVfPOFD7J/Avwe07yIxS9yGFSFnwPDp8wdp+bmvsVGNHg+zbY408
	gF/HoXWXVvEUOteRcSoLrThyVEMGHgUs1/lUoFTQ8F3xMQ23S196dzPGWqXTp6g9N9BHPPVrU8vK3
	C9A3Yh5EwWDWlF33dcKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCoN-0001VB-V4; Tue, 04 Dec 2018 15:40:35 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCfV-0002E3-Rm
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 15:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rUVfgGNAs+DvpMcjwZ5mRd/gw/vYUAMBcsrSqqXO2m4=; b=aB8QgPtTl0YTtMdIrIIgIjcBfJ
 qHrbnvAARBQbXFoUm7ndI2I78lqlo56W3cB1+NYRlFfJebB8UFXNCIXXybMhxVypOCCQjqGh45NEZ
 uFAM8/GAAN8/ku9sBfrRz0qyqGmIQqfFIlnJu4GSk1G26I7aO9BmRdAFbDqQhGg1mbOyzbC7I6o8v
 5ph0fgAWXKFcZswCPmKdSnnUOeMrI6t70E7rOlVBcuDwzZtPpU3advMAcb0kEalOKY29AIWuvzF3+
 wduixrPoJJGgqtXoED+ADAg5D+dqlXVBy4u5mGq/ngZS2nCBLfsftpV3AVh3EnwtV4fExafdnCFP7
 kKYwi/iA==;
Received: from mail.bootlin.com ([62.4.15.54])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBc0-00021j-Ev
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:23:46 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0F50E20EDE; Tue,  4 Dec 2018 15:23:26 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 1022E20E2A;
 Tue,  4 Dec 2018 15:22:44 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/21] drm/sun4i: frontend: Add A20-specific device-tree
 compatible and quirks
Date: Tue,  4 Dec 2018 15:22:18 +0100
Message-Id: <20181204142218.16284-22-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_092344_649862_2D1D38D9 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-sunxi@googlegroups.com,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the appropriate device-tree compatible and quirk data for
hooking frontend support for the A20. It supports the FIR coefficients
ready bit but not the access control bit. It also takes different phase
values than the A33 for these coefficients.

The compatible is already used in the A20 device-tree and already
documented in the device-tree bindings.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index d17394a367b3..da285c2ddd78 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -692,6 +692,20 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
 	.runtime_suspend	= sun4i_frontend_runtime_suspend,
 };
 
+static const struct sun4i_frontend_data sun7i_a20_frontend = {
+	.ch_phase		= {
+		{
+			.horzphase = 0,
+			.vertphase = { 0, 0 },
+		},
+		{
+			.horzphase = 0xfc000,
+			.vertphase = { 0xfc000, 0xfc000 },
+		},
+	},
+	.has_coef_rdy		= true,
+};
+
 static const struct sun4i_frontend_data sun8i_a33_frontend = {
 	.ch_phase		= {
 		{
@@ -707,6 +721,10 @@ static const struct sun4i_frontend_data sun8i_a33_frontend = {
 };
 
 const struct of_device_id sun4i_frontend_of_table[] = {
+	{
+		.compatible = "allwinner,sun7i-a20-display-frontend",
+		.data = &sun7i_a20_frontend
+	},
 	{
 		.compatible = "allwinner,sun8i-a33-display-frontend",
 		.data = &sun8i_a33_frontend
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
