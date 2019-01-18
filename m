Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE31DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:01:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800352087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t89oCfXd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bHuzbpJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800352087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1SC939+37LcFJQ3OszCurI9g4G1hrsU4Jm7zQBnxjEo=; b=t89oCfXd5l9R64
	1fiLNqdw7pL3zHsTe6iTyQ/b/mOq/dYoIh7LZ+sks4F9rK9Q4vgBGfr4WA3ZQhBfX6p0u27Zs3WkQ
	WhVelydGgJSX7a/AqI3e2IlrkGLQJn5v6DK51FYAmMUpV4sNCVRc4bjnVaIoxc3O5LdiOsLI1wOEU
	gVN6xZEM3hYXQvjbUJLyi4aFhmKLvLP0X8QHZBjZf+7Fu+fYpddrwYBbfvtlXvYNiesjj14820GAJ
	9Qp6hwLlehCXCiCvXAHek00g3KZKBpHNUH8RFi7c0c1J+7DjKqIYZV0tyrBb9aItYTcweqZ+jOkcV
	m3mYheQZ6/321sZd/YNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVe3-0006ss-PV; Fri, 18 Jan 2019 15:01:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVdf-00064q-Ih
 for linux-arm-kernel@bombadil.infradead.org; Fri, 18 Jan 2019 15:00:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j3p+QJF9Z5LbzFF2EHAWXrBVGGujcdIopSp7hVkdLWg=; b=bHuzbpJrWnphNslDBDQKHV5zgL
 RRVDYjS0FnBVg1x7lxCKBijmnXbT1S8nxj4W4FbRxuEeK4t4tncQubSfjQ6j/cbujB+iU4l3sRWAX
 snH48/A4F2Zzcvbq4bE+MKTL+ZikDnD8GL7dHqcf5L7Wvlnz2qLAeIzVldihgma5nqMhfOb1NGnWD
 JPBg2MA6gt3IUU3Z0R0kZzRCfnzHd4MRWHgVO8Zck9VpIKYu7gLv1vcO/dWMPa0QQ/ZnyxdusV5BT
 c5UtpTnWB8kkuj5uFmRA+F5iRaRY+SPO0xfAhOAjn8KWK9Itnampz43cQyeIidzIibB0Cf2FTyAHC
 RCcVulxg==;
Received: from mail.bootlin.com ([62.4.15.54])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVVV-0007G3-FN
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:52:30 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5BFAA20CC3; Fri, 18 Jan 2019 15:52:28 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id B651020CC3;
 Fri, 18 Jan 2019 15:51:46 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v5 22/23] drm/sun4i: frontend: Hook-in support for the
 A10, with specific quirks
Date: Fri, 18 Jan 2019 15:51:32 +0100
Message-Id: <20190118145133.21281-23-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_145229_535635_1EDA3658 
X-CRM114-Status: GOOD (  12.69  )
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the appropriate device-tree compatible and quirk data for
hooking frontend support for the A20. It supports the FIR coefficients
ready bit but not the access control bit. It also takes different phase
values than the A33 for these coefficients.

The compatible is already used in the A10 device-tree and already
documented in the device-tree bindings.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 4a215d5202e2..53e4dbe466ff 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -682,6 +682,20 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
 	.runtime_suspend	= sun4i_frontend_runtime_suspend,
 };
 
+static const struct sun4i_frontend_data sun4i_a10_frontend = {
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
@@ -697,6 +711,10 @@ static const struct sun4i_frontend_data sun8i_a33_frontend = {
 };
 
 const struct of_device_id sun4i_frontend_of_table[] = {
+	{
+		.compatible = "allwinner,sun4i-a10-display-frontend",
+		.data = &sun4i_a10_frontend
+	},
 	{
 		.compatible = "allwinner,sun8i-a33-display-frontend",
 		.data = &sun8i_a33_frontend
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
