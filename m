Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362EBC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0205F208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lx1btCZb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2TILMS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0205F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cleeDAs+hXGYBLyJJLbw+UyBbQk8247CG6I+jHDfWG4=; b=Lx1btCZb6KF48KwOcCISJ+9ZJt
	mw2WVkvNFxAL21pm6klZVHQM2H/ePKwLwsPnF+MAfFk5l1BvAhf3TjnVIUwp1LpL0q1lMrEg3vEMP
	9EwHpzk15K5izg/HaztnLbZmEuOPONqS+TreX/ghWWQYNfzLaMmW3Gaytvr7cBYjiw18It+s441Bq
	FD59FZScHxyYreRtOFS9zeb42r84O3LDlfuLM1EDd4KbtguW6Zt6+1vJ+47f4GUMKj0aDs6wj6hB4
	bvYyqpmxSe+O+SOzz9h6ObT0qyOEkk6y7CmsYVFAd+2/cuNCAewFGcMUwevDys5xzYWXxIf4+A0hj
	DXsPGHyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZDN-0001vj-AF; Sun, 02 Dec 2018 21:23:45 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZDK-0001tW-9F
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:23:43 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so10138280wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+RIjtlpT3+92I1+2H0hsC2goUn5MUzztUllaWtnGW6g=;
 b=Z2TILMS7nhHpXjPG8qMmgoZGLsz5pbrkGf8QKsyQI8Jnpq6trsDTbAeryTZW8u7/Yo
 INyr1g774vsZ1aw7ePanyBUXyhxl2L+L3FkK2hIUIn3ZFrUaiAD6ngmyi102kkf5JusG
 fhSD91W3htOEdJUxzEE9dzjcvbBAtMmReA7w7bRVxTXh1rp53nyZQddv2h2ZtaPpMNbC
 /u9OvrKELsuTn2TsoPsRcqVtTNll9fZN8YfK3JutNMECv/TftHAXizspneGmd3uTv6Ay
 rWLk4SeRNsJQi021kXk25Adbnz2hv/K0UwAro88dNMacYks3OGAlf5J1clL+b6cnisJv
 ZiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+RIjtlpT3+92I1+2H0hsC2goUn5MUzztUllaWtnGW6g=;
 b=NqzM02g93Ps9F6n9vGQNF2NpIjHL+b3wbORegFrdt0P5Q2jNMnRKGswVCcRNGrCQuZ
 Omq4aFvikBtaHBZSEcfNjBtHdC90bM01upbGsaqY//R2Vf/Dh5G8VBbwp3kFRa0LR2CT
 uvADGKNParh/J2fHLMxaqg8iJRxL+R/Fi3T0Ha8p8jQ0TPOItLi/TgJznoM/T3jAmWET
 HyWNVK+qGRIkdWYqOm4QSeU38RD8MJvY6HlFLHccYTIIjp7Mu/SGEjqWdWm+mveSCYKA
 JUmneKO0jdQGbptos/Tily1s51iqzwNpHHLyQgM7Pw2SCVeQnDLf4WmaMM1kyuDiMFjb
 vyPw==
X-Gm-Message-State: AA+aEWadqtIXPrwvtP5gY8MvMLqGVdNdJWl56CDyVRP1j6bX1nZJhMBC
 PVgcTtDcaJtAFJWJCHrxtnY=
X-Google-Smtp-Source: AFSGD/WyrNYACQFMYw4QTsRc1ryyvozAVERA4/z47O05e3frHy1QokNLAuqaXCZZq7TImRSlUQiVFw==
X-Received: by 2002:adf:c108:: with SMTP id r8mr12313316wre.233.1543785813999; 
 Sun, 02 Dec 2018 13:23:33 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 13:23:33 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Subject: [RFC PATCH 02/10] dma-engine: sun4i: Add has_reset option to quirk
Date: Mon,  3 Dec 2018 00:23:09 +0300
Message-Id: <01acc2214bf4aa62bda1c6e2ecf04ad698f9866b.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_132342_351968_E242F8D5 
X-CRM114-Status: GOOD (  17.78  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Mesih Kilinc <mesihkilinc@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
has this bit but in order to support suniv we need to add it. So add
support for reset bit.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/dma/sun4i-dma.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index e86b424..d267ff9 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -18,6 +18,7 @@
 #include <linux/of_dma.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -153,6 +154,7 @@ struct sun4i_dma_config {
 	u8 ddma_drq_sdram;
 
 	u8 max_burst;
+	bool has_reset;
 };
 
 struct sun4i_dma_pchan {
@@ -201,6 +203,7 @@ struct sun4i_dma_dev {
 	int				irq;
 	spinlock_t			lock;
 	const struct sun4i_dma_config *cfg;
+	struct reset_control *rst;
 };
 
 static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
@@ -1198,6 +1201,15 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 	}
 
+	if(priv->cfg->has_reset) {
+		priv->rst = devm_reset_control_get_exclusive(&pdev->dev,
+							       NULL);
+		if (IS_ERR(priv->rst)) {
+			dev_err(&pdev->dev, "Failed to get reset control\n");
+			return PTR_ERR(priv->rst);
+		}
+	}
+
 	platform_set_drvdata(pdev, priv);
 	spin_lock_init(&priv->lock);
 
@@ -1268,6 +1280,16 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Deassert the reset control */
+	if (priv->rst) {
+		ret = reset_control_deassert(priv->rst);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to deassert the reset control\n");
+			goto err_clk_disable;
+		}
+	}
+
 	/*
 	 * Make sure the IRQs are all disabled and accounted for. The bootloader
 	 * likes to leave these dirty
@@ -1339,6 +1361,7 @@ static struct sun4i_dma_config sun4i_a10_dma_cfg = {
 	.ddma_drq_sdram		= SUN4I_DDMA_DRQ_TYPE_SDRAM,
 
 	.max_burst		= SUN4I_MAX_BURST,
+	.has_reset		= false,
 };
 
 static const struct of_device_id sun4i_dma_match[] = {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
