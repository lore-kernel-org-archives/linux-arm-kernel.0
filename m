Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C36BC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:55:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FD5218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DQmicAXS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="guAKJy0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FD5218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O8xwtXGitkC6gjl4P5dt9CrC9So48a1NRa4dviN6liQ=; b=DQmicAXSYhAZsK
	PrT/tmEYaduFOdBCSVTvcyesfi0ai5Oy7oVqLOp1mIK/2+oEuE5mjmPa4FoNlgzOXVJO67BvoS6Fr
	vy2HRY0ltr5p234X79SPoqJJr+kpTGV+BxBbD4HS+Ep3GOSZFxOm0fMM15UcMwG1WfaWd4LZ5uPV2
	dNjgybsyFUHUOGAcWMOZFtdHtmcTCdE9rC+QOhgPxRSIL+f99FOFrvmD1piCsc0PgnM00qdIkcFne
	yJS3bVTc+gWaHR35gKIcgRYQeXQFok+nOdEi6KcvE6Ct0x3c0usVDNW9GNUQf4a0nPL9dkvqKJipq
	vsQ5nPwkhOcUsERPS8vA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZxrK-000473-2i; Thu, 20 Dec 2018 12:55:26 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZxqu-0002fJ-Kk
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 12:55:04 +0000
Received: by mail-wm1-x341.google.com with SMTP id m22so2066575wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 04:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XK1+ImY4LqT3mqPXOgRcotLaegAmI6oUTAhBqe9t1Sw=;
 b=guAKJy0OL6nXtpHu5GU/d99DuxpR0mmuIZemRdWaOszAnuyybtR/sssbywfDKRrNrf
 DqL8yOLBev+gKWvFdn94peWiE144jfkW0jdSegShXzl3vVX8Veitr4Aov8ON1Mna/ZKG
 ltr8NR+r0nrJ12xaj2GAHmF2tKLYzb0BjWWpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XK1+ImY4LqT3mqPXOgRcotLaegAmI6oUTAhBqe9t1Sw=;
 b=GZHj/gyfY9SsOQ/jGDaZT22uo6l2v+JizQTRs/xfaKpRHl4tGHgQIHf5+1+wUQPL5m
 yxU/eX7iYXrblaRKa5IBLtQH0VpYB/8sajeYsxbjZN2PvPmqQOOkZ39zbX2mnWJx54gz
 4SZTtrZIlq2SrtXZQjoeNMR+hl5CuLwJNbwLzFaTEEOFFN2a1aK6kK27YVn5/tk5A5ge
 yaqwlvlQxDxRYmqULO/+FzDhCqYrBoxEZhzWViRArtzkhsXQFZe9A+X61muUkwH+Y/LJ
 5NjjstDFcvU/blIiw70MyXUHp0WwnflEEF4JmDZeb4nJy9zlTqdaR0nAeDXYWqDyDy4z
 fK3Q==
X-Gm-Message-State: AA+aEWYwZK8jCcu9sHNybaE121LbmE90iYA+N6yjVn0+GYwdhn4IJ1rw
 Irg4uKpq3IGGEdb1AAI/VecHRw==
X-Google-Smtp-Source: AFSGD/VaVhsdOJ+GQeoQ3YRRzS8H1oCRVWa/ZckdcR5C+R9heqHrTZBUjY6lcOQvr2R2zurM9FcrHw==
X-Received: by 2002:a1c:a895:: with SMTP id r143mr10839869wme.95.1545310493002; 
 Thu, 20 Dec 2018 04:54:53 -0800 (PST)
Received: from localhost.localdomain (ip-163-240.sn-213-198.clouditalia.com.
 [213.198.163.240])
 by smtp.gmail.com with ESMTPSA id o4sm8732756wrq.66.2018.12.20.04.54.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 04:54:52 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v5 3/6] media: sun6i: Add A64 CSI block support
Date: Thu, 20 Dec 2018 18:24:35 +0530
Message-Id: <20181220125438.11700-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181220125438.11700-1-jagan@amarulasolutions.com>
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_045500_679921_9CD6D033 
X-CRM114-Status: GOOD (  12.36  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CSI block in Allwinner A64 has similar features as like in H3,
but default mod clock rate in BSP along with latest mainline testing
require to operate it at 300MHz.

So, add A64 CSI compatibe along with mod_rate quirk.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index fe002beae09c..48919aabefdb 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -913,10 +913,15 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 static const struct sun6i_csi_variant sun6i_a31_csi = {
 };
 
+static const struct sun6i_csi_variant sun50i_a64_csi = {
+	.mod_rate	= 300000000,
+};
+
 static const struct of_device_id sun6i_csi_of_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-csi", .data = &sun6i_a31_csi, },
 	{ .compatible = "allwinner,sun8i-h3-csi", .data = &sun6i_a31_csi, },
 	{ .compatible = "allwinner,sun8i-v3s-csi", .data = &sun6i_a31_csi, },
+	{ .compatible = "allwinner,sun50i-a64-csi", .data = &sun50i_a64_csi, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sun6i_csi_of_match);
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
