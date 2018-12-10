Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4812C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:42:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853042081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HT1cYRpq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="VGaryfFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853042081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cbwZ65g12jzpzZklU6mGlqpaY9xtuEpcPzFLIQNHc4k=; b=HT1cYRpqgQcGwk
	F1OBt4l6Ix6KPFu5BkcqYR6w92t0asmdTvJHaM1Jny+wkipI+BbLO3NkePnCjYkKGrLAAfk+0mbbN
	2Xr7oMCiq9vb70N6Mf0a6lbMTchH4O58UmJFWJs7dMURV3uTddm1HUqhCz6+NRlKuIxFLWy+AGK/F
	1l2ROe8n9Z8GywKxGqJXegIhsBqnd8SG2AMCMvo25FHRS4M1or6fw7WRi/ctIvHt33eLz+Gn9OSLx
	bSPSF6vR9FqZ05qwXSvVq4jCCvq2X1Cpr2W+8qdrWW7q1m81J8kUXOzfTt2WDA+TVLVg5kfwMRQAQ
	sfN82RBoUSejvhEKq63A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQVv-00033C-CE; Mon, 10 Dec 2018 18:42:43 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQVr-00030z-Lc
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 18:42:41 +0000
Received: from localhost (unknown [213.204.46.240])
 by plaes.org (Postfix) with ESMTPSA id 43DE44126E;
 Mon, 10 Dec 2018 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544467345; bh=DNxG4QIovujeB65kr1xY5el00nrx7k3udwttY/HTPZc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VGaryfFNV8xozeb60Rm/7qOjwYb6gmCJWGq8Cd7nxq9t9XCpL+pNRT7bgqit37AYt
 OXwWFOVmIObrzD2+lDTY2dql8MHvW87roLS7tCbFsjbpgDF1cBnqvPlFkolVCVqaJC
 NBog6RXKOMt/Xt+60O1Tg4JYbkP9MkfoO7ft5YKDRREakbtwWbr2Pu/RmIw0LmL/Eh
 TDrW/h/j0Kymk51bt7orI5oJHpvsyH1m2ZDVWBr1BcfOrJ/CK7J7SLjJeEoAVx9NAO
 7SalzfgTfPW56vrQFa598+kViB/L/HYnIWHw1tZBw/+tchFeXp3FQR/5GHz8MFVKAX
 RL1oB4IrRw3gg==
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Olliver Schinagl <oliver@schinagl.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>
Subject: [PATCH 1/8] mfd: axp20x: name voltage ramping define properly
Date: Mon, 10 Dec 2018 20:42:12 +0200
Message-Id: <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544466940.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_104239_927068_343BEFA1 
X-CRM114-Status: UNSURE (   9.57  )
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
Cc: Priit Laes <plaes@plaes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The current axp20x names the ramping register 'scal' which probably
means scaling. Since the register really has nothing to do with
scaling, but really is the voltage ramp we rename it appropriately.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/axp20x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 2302b62..a353cd2 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -35,7 +35,7 @@ enum axp20x_variants {
 #define AXP152_ALDO_OP_MODE		0x13
 #define AXP152_LDO0_CTRL		0x15
 #define AXP152_DCDC2_V_OUT		0x23
-#define AXP152_DCDC2_V_SCAL		0x25
+#define AXP152_DCDC2_V_RAMP		0x25
 #define AXP152_DCDC1_V_OUT		0x26
 #define AXP152_DCDC3_V_OUT		0x27
 #define AXP152_ALDO12_V_OUT		0x28
@@ -53,7 +53,7 @@ enum axp20x_variants {
 #define AXP20X_USB_OTG_STATUS		0x02
 #define AXP20X_PWR_OUT_CTRL		0x12
 #define AXP20X_DCDC2_V_OUT		0x23
-#define AXP20X_DCDC2_LDO3_V_SCAL	0x25
+#define AXP20X_DCDC2_LDO3_V_RAMP	0x25
 #define AXP20X_DCDC3_V_OUT		0x27
 #define AXP20X_LDO24_V_OUT		0x28
 #define AXP20X_LDO3_V_OUT		0x29
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
