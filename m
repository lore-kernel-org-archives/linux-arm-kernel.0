Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19599C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:31:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDBC206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LDmHZSSs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="swozf4TI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDBC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YXNfvM70KfBbAjoOJP18rgBRrpfFJPgFtbhiI0Ag5ZM=; b=LDmHZSSs/a8/f1
	Hdl6TwpixP5nMG8RJDfmTNwH9Iajd9i9NpqVHFa0mmCni1EUX3fzS5lzU54fNd7MJMSGpTd2wHaFj
	diz9tzPIIRXUKXk0bI/Iwm4Pabcp+rlCUyYudMmqJ9ARI2aJRnizJhRMOvqaMdXeXSHdIfJuZnHHy
	fcsOL16Sto9qkNsRSgUPC9HTowU1AxeL1jboYZa7ljof5MmOGKpOT/LCDT1ij5qJHzm5qBFDs4104
	uLGw5i6ohBCy8UvYFsbOo5x6DXvyAVpZl7hA+Vsk0YhtQ3Y7ZouvGNHMfbHtL/aHanvn8a+efiVcA
	/iBtN9NVBa9sBevm5CfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBjP-0007Fp-8U; Tue, 04 Dec 2018 14:31:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBjM-00076N-O5
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 14:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QCbKMYSAqGXe82qSpXxNoR6mtHoGu2y++xmq9qcbSwM=; b=swozf4TIEcjhOul85fnvitqJYW
 EfTBDQ4rqSYBzaAvV98fMXjU9LeGFiAB5YmqKudQtLXzVwu/ooOgoz/perF8RiPKA5NhoFdpqoO7T
 uGWRohNfZs3xdBtDGikMe0wZ2UbU9t8AKYGMHnz6pYVm2LCutstqN3qpxnjCkv3e854LRzxD5d6h0
 GOxCfXbsECueuWbaBlx+39l6RunDTLWyiOOiD1+RpUe26y0r1JJMQh36Jnn+nnGWXGlexT+25JqRJ
 h7zLX9tpTsdklI2uV6rGZ5dozebzTlAB74f9vn7w1V0mMuUTHnkZV9qXRdS9IHHclrVHykyWPQ8+f
 c1GfpEOg==;
Received: from mail.bootlin.com ([62.4.15.54])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBbx-0003F5-QY
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:23:43 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2AC6C20E22; Tue,  4 Dec 2018 15:23:20 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8B6C220E27;
 Tue,  4 Dec 2018 15:22:43 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/21] drm/sun4i: Make COEF_RDY conditional
Date: Tue,  4 Dec 2018 15:22:16 +0100
Message-Id: <20181204142218.16284-20-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_142341_880507_A51441C0 
X-CRM114-Status: GOOD (  14.31  )
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

From: Maxime Ripard <maxime.ripard@bootlin.com>

The COEF_RDY bit isn't found in all the SoCs featuring some variant of the
frontend.

Add it to our quirks structure.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 9 +++++----
 drivers/gpu/drm/sun4i/sun4i_frontend.h | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 4d58d00255ae..da1bb82d534e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -95,10 +95,11 @@ static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 			     sun4i_frontend_vert_coef[i]);
 	}
 
-	regmap_write_bits(frontend->regs,
-			  SUN4I_FRONTEND_FRM_CTRL_REG,
-			  SUN4I_FRONTEND_FRM_CTRL_COEF_RDY,
-			  SUN4I_FRONTEND_FRM_CTRL_COEF_RDY);
+	if (frontend->data->has_coef_rdy)
+		regmap_write_bits(frontend->regs,
+				  SUN4I_FRONTEND_FRM_CTRL_REG,
+				  SUN4I_FRONTEND_FRM_CTRL_COEF_RDY,
+				  SUN4I_FRONTEND_FRM_CTRL_COEF_RDY);
 }
 
 int sun4i_frontend_init(struct sun4i_frontend *frontend)
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 22b8afa3795e..458a5e69f56f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -103,6 +103,7 @@ struct reset_control;
 
 struct sun4i_frontend_data {
 	bool	has_coef_access_ctrl;
+	bool	has_coef_rdy;
 };
 
 struct sun4i_frontend {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
