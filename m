Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDB3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE1F217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sl+eBMFA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3bQLKpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE1F217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zp/iwkgwYMnoOG6NgUVVfnzfkWj2HInAZLBhzFcogCI=; b=Sl+eBMFALwAOsz
	UtGnjkDoxi6nj44YlgugiUfnorcHboeQcolTt6e4AETTpUmzhDnq0O0N5jp7memymTsSxcIku9az2
	xJR1DjfqYRBBuQW+NPAxEMXpHJ0OxHVh6WfREJgMU3t8A/bNc5wEUG8uvUVCc3/CSRIiEpR8J/a7Q
	bLdbvibOc6dOHgcJPA2rpxijhWHm7BTlKealSgOxxWps3r+oWmb0ah7CLHDDpuHk2NrW2VUGmha+I
	EFNkxJNL2VSQnBmnOdKNw0SqBGSqcmU2xqvjd8o+mKVXgkYdEz+aKES73f+SBZLqvKlLohMLiWwKj
	9jdGFGKeKNUOutZj8SEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaMcs-00080e-PK; Fri, 21 Dec 2018 15:22:10 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaMc9-0007DG-US
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 15:21:28 +0000
Received: by mail-lj1-x243.google.com with SMTP id g11-v6so5065929ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 07:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=acjXl/ZaoeTwfrYah/bbezD4My/k31GlnJiqaMNlHlk=;
 b=j3bQLKptvBG25yLOrZld8QsSMRYiG0HezMk6GEg6QuqD73AjutLPIIIFtF3iby341Q
 BIFVBSENNEgv58RfIOrlm3EBfJ5PuuBPWMleSeI+T0EBoBHnKlg+Tj6XH7W76rm6ZgML
 Tfs7ibGwRkiF1h07s1j9Q4lNErt87SNTQbuTl0na7CVVxGpIsd+cCImfREkjxS8xJsug
 7yXtBhw/FY0/7F1vl25b5MGE+MNLOR9rtNWFcv9qP2fqX+a6ZlxzFgeXx1P6bMlfaaFY
 Sz2pH2jxu9MWfdDjZ8fT9gtU7P6A9a7wRYlv0R2pt5xxcIYdmVnO0D2rdBsabptNGKh0
 M8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=acjXl/ZaoeTwfrYah/bbezD4My/k31GlnJiqaMNlHlk=;
 b=ub5KCaXtPIyRS3Ght4pNSbr6O7lENGHIfnJ1IITH8i3eroNSKvpOSF5kOETHIWxau8
 PwQ6poWXFRpLWx2YSaW9bucic1gowf9hI7CcBRPl89y86Z6vupEutPvl23jpbYuBzM1K
 /rIfFJPeWgERXeGftBSMMyAIjpBMRnupXpDC9qPwdmnU4xEyfRt1y6C71iUHA6Z12swW
 pBO9SdrOnADJ4LQtOyaITQSqDh7l8eXDPMP/AoLYGxULa+SQAcWiFL8gKx5wJxy2IVLb
 oROV3FcIq02Ar0YFQRw3Isxbjf/JdQ3OUZNwrqqUHaZfT4kZP3fs5+o4rqaD2MQvSG0I
 qbXQ==
X-Gm-Message-State: AJcUukdgvVCQ7JG35BbiTkb5MJ3aMMbfFs1V6P2/t5Re0fPdgBZAvCg3
 bS6wYGBy7yqLdAyERWLMppw=
X-Google-Smtp-Source: ALg8bN5xk+PRAyX8yZO52dbiqAbR0E0+wcBxwo7o2+mSWowWEM08LJjg2K9tiZ0Xy5rLrOxgDnCfig==
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr1922750ljk.4.1545405681551; 
 Fri, 21 Dec 2018 07:21:21 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se.
 [90.142.43.138])
 by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 07:21:20 -0800 (PST)
From: codekipper@gmail.com
To: maxime.ripard@free-electrons.com, wens@csie.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH v3 7/9] ASoC: sun4i-i2s: Do not divide clocks when slave
Date: Fri, 21 Dec 2018 16:21:08 +0100
Message-Id: <20181221152110.17982-8-codekipper@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221152110.17982-1-codekipper@gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_072125_984649_C5E09908 
X-CRM114-Status: GOOD (  16.87  )
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
Cc: alsa-devel@alsa-project.org, Marcus Cooper <codekipper@gmail.com>,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, be17068@iperbole.bo.it,
 broonie@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

There is no need to set the clock and calculate the division of
the audio pll for the bclk and sync signals when they are not
required.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 144 +++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 67 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index e85789d84c0c..8cec2f42c94e 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -194,6 +194,8 @@ struct sun4i_i2s {
 	struct regmap_field	*field_rxchansel;
 
 	const struct sun4i_i2s_quirks	*variant;
+
+	bool bit_clk_master;
 };
 
 struct sun4i_i2s_clk_div {
@@ -298,82 +300,86 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	int bclk_div, mclk_div;
 	int ret;
 
-	switch (rate) {
-	case 176400:
-	case 88200:
-	case 44100:
-	case 22050:
-	case 11025:
-		clk_rate = 22579200;
-		break;
+	if (i2s->bit_clk_master) {
+		switch (rate) {
+		case 176400:
+		case 88200:
+		case 44100:
+		case 22050:
+		case 11025:
+			clk_rate = 22579200;
+			break;
 
-	case 192000:
-	case 128000:
-	case 96000:
-	case 64000:
-	case 48000:
-	case 32000:
-	case 24000:
-	case 16000:
-	case 12000:
-	case 8000:
-		clk_rate = 24576000;
-		break;
+		case 192000:
+		case 128000:
+		case 96000:
+		case 64000:
+		case 48000:
+		case 32000:
+		case 24000:
+		case 16000:
+		case 12000:
+		case 8000:
+			clk_rate = 24576000;
+			break;
 
-	default:
-		dev_err(dai->dev, "Unsupported sample rate: %u\n", rate);
-		return -EINVAL;
-	}
+		default:
+			dev_err(dai->dev, "Unsupported sample rate: %u\n", rate);
+			return -EINVAL;
+		}
 
-	ret = clk_set_rate(i2s->mod_clk, clk_rate);
-	if (ret)
-		return ret;
+		ret = clk_set_rate(i2s->mod_clk, clk_rate);
+		if (ret) {
+			dev_err(dai->dev, "Unable to set clock\n");
+			return ret;
+		}
 
-	oversample_rate = i2s->mclk_freq / rate;
-	if (!sun4i_i2s_oversample_is_valid(oversample_rate)) {
-		dev_err(dai->dev, "Unsupported oversample rate: %d\n",
-			oversample_rate);
-		return -EINVAL;
-	}
+		oversample_rate = i2s->mclk_freq / rate;
+		if (!sun4i_i2s_oversample_is_valid(oversample_rate)) {
+			dev_err(dai->dev, "Unsupported oversample rate: %d\n",
+				oversample_rate);
+			return -EINVAL;
+		}
 
-	if (i2s->variant->has_fmt_set_lrck_period)
-		bclk_div = sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
-						  word_size,
-						  sun8i_i2s_clk_div,
-						  ARRAY_SIZE(sun8i_i2s_clk_div));
-	else
-		bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
-						  word_size,
-						  sun4i_i2s_bclk_div,
-						  ARRAY_SIZE(sun4i_i2s_bclk_div));
-	if (bclk_div < 0) {
-		dev_err(dai->dev, "Unsupported BCLK divider: %d\n",
-			bclk_div);
-		return -EINVAL;
-	}
+		if (i2s->variant->has_fmt_set_lrck_period)
+			bclk_div = sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
+							  word_size,
+							  sun8i_i2s_clk_div,
+							  ARRAY_SIZE(sun8i_i2s_clk_div));
+		else
+			bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
+							  word_size,
+							  sun4i_i2s_bclk_div,
+							  ARRAY_SIZE(sun4i_i2s_bclk_div));
+		if (bclk_div < 0) {
+			dev_err(dai->dev, "Unsupported BCLK divider: %d\n",
+				bclk_div);
+			return -EINVAL;
+		}
 
 
-	if (i2s->variant->has_fmt_set_lrck_period)
-		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-						  clk_rate, rate,
-						  sun8i_i2s_clk_div,
-						  ARRAY_SIZE(sun8i_i2s_clk_div));
-	else
-		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-						  clk_rate, rate,
-						  sun4i_i2s_mclk_div,
-						  ARRAY_SIZE(sun4i_i2s_mclk_div));
-	if (mclk_div < 0) {
-		dev_err(dai->dev, "Unsupported MCLK divider: %d\n",
-			mclk_div);
-		return -EINVAL;
-	}
+		if (i2s->variant->has_fmt_set_lrck_period)
+			mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+							  clk_rate, rate,
+							  sun8i_i2s_clk_div,
+							  ARRAY_SIZE(sun8i_i2s_clk_div));
+		else
+			mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+							  clk_rate, rate,
+							  sun4i_i2s_mclk_div,
+							  ARRAY_SIZE(sun4i_i2s_mclk_div));
+		if (mclk_div < 0) {
+			dev_err(dai->dev, "Unsupported MCLK divider: %d\n",
+				mclk_div);
+			return -EINVAL;
+		}
 
-	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
-		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
-		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
+		regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
+			     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
+			     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
 
-	regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
+		regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
+	}
 
 	/* Set sync period */
 	if (i2s->variant->has_fmt_set_lrck_period)
@@ -574,10 +580,12 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		case SND_SOC_DAIFMT_CBS_CFS:
 			/* BCLK and LRCLK master */
 			val = SUN4I_I2S_CTRL_MODE_MASTER;
+			i2s->bit_clk_master = true;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			/* BCLK and LRCLK slave */
 			val = SUN4I_I2S_CTRL_MODE_SLAVE;
+			i2s->bit_clk_master = false;
 			break;
 		default:
 			dev_err(dai->dev, "Unsupported slave setting: %d\n",
@@ -598,10 +606,12 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			/* BCLK and LRCLK master */
 			val = SUN8I_I2S_CTRL_BCLK_OUT |
 				SUN8I_I2S_CTRL_LRCK_OUT;
+			i2s->bit_clk_master = true;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			/* BCLK and LRCLK slave */
 			val = 0;
+			i2s->bit_clk_master = false;
 			break;
 		default:
 			dev_err(dai->dev, "Unsupported slave setting: %d\n",
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
