Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4323C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941B62192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LpkGlz+L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut8/sDmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941B62192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LDkwfah0aMdQ+pjF97smTdJrQLjqZZe0q/rvyImp1Uw=; b=LpkGlz+LEEVjCO
	15Q26quvCDK0hhgEQsP6eROI+sd4xLqwwUadpONKEfvfkxWCrElXe1OywUye8RGgzez+1fUVqBAYg
	IR3jR6VgXkCFDjpSsQb9rXoeRg4+vYaS06+JkucGtm5j8zFshNfh3pQJxdwLhHi9OBAZkVNadNsWz
	TrDm5eOBFmpKsycaeFRAQOBxmkgFXnkaDkTejRjKqNaeKS6ll0+8jvvAJ+PJgOTlM+Dp5ZOVGsXmM
	6yngRtHfiN6ThBNZuWaP6FCNyUYSbXsR/w9wszNGDDL1fqS5YJPHr9J5B0AZu8YIWRO1ZYB+Fj/gQ
	9t/cHNCfjzuQGvl7mL9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaMdO-0008W1-0a; Fri, 21 Dec 2018 15:22:42 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaMcC-0007Ca-Cy
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 15:21:29 +0000
Received: by mail-lf1-x143.google.com with SMTP id f23so4147720lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 07:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i6JjiPCmTaf5vd0jGiuaXaqrB7/Dt9QwI5wneEqTlYM=;
 b=Ut8/sDmI1j0vvoKRrWJL7UzivFbr1XbcS7YKMQ4aYVmr+Pa8rv6F5mz8NUVYff3PeK
 ve2X4eSsZ0DgPHcr78Jm35e5bhdQ5aZj1mNPMC1p+2iDvNj+WBjTjiutv9RL/oqkg8q7
 PQOrRTZ4q4a2goVBcObxEXwR4zDyCUD0FyOye0TaYwTn+uJFg+3F3cDZeRqZPDTnGsJz
 6cHwcG6oX9SbwwyWpabEuMk4YWp6TX8WCjmMt5gW+vfiDmlX/mngFwHrbEzdVHpwh3Ik
 wH0newTL117fZE2cwy3s2c2FIHsDa7AkUCX8F8NwVON6wXTwQvprponSQTqOQbsfLSy9
 52Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i6JjiPCmTaf5vd0jGiuaXaqrB7/Dt9QwI5wneEqTlYM=;
 b=dzuUdrn3i2BrhL6pjYzBXYmA2wb3XtXeyD56fVI9wA6rYpl54IFrUXc5IMkbVSg+BL
 /IOqPmx0oHwbVxSlVysRs6poCHAdGY+qQhB1RNUy7ZpsLnA7nL8UiKQtKiQxqEs9h+Gj
 7QU7VBn5pKRVwsncL5+6aMyckR+Z9AXh3or0spaMJamXARu3ubDanh7wYStIhTngCBDD
 BqcyCDmGYQNgSTEl/gEZgBWiIV6FmxZOvrIXZz4B2Z+/1o/NWkdoPypFUDJc+6/gHhxN
 BT6+clzHX97/GfvEGLhwAdGWnDPHElIvhpDw1ua/WOaFC+5Ncfewaei1fpGdcFrbcxRD
 agGQ==
X-Gm-Message-State: AA+aEWZT+e9DMRDbJHs6/lXmDG1UXhT3ME/x9NoJL3EM3BzWnjGcLiVz
 YnvAzafQGzZju38Ev03sb1g=
X-Google-Smtp-Source: AFSGD/UjWM9VvfBv0ChRjPCyCwOoYn6QOxMuTLf1obp3YgtDLnXrEP1ss8UbMCseDn654FRbiUOkAA==
X-Received: by 2002:a19:d5:: with SMTP id 204mr1587680lfa.116.1545405676440;
 Fri, 21 Dec 2018 07:21:16 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se.
 [90.142.43.138])
 by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 07:21:15 -0800 (PST)
From: codekipper@gmail.com
To: maxime.ripard@free-electrons.com, wens@csie.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH v3 3/9] ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
Date: Fri, 21 Dec 2018 16:21:04 +0100
Message-Id: <20181221152110.17982-4-codekipper@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221152110.17982-1-codekipper@gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_072128_434980_A320706D 
X-CRM114-Status: GOOD (  15.11  )
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

Extend the functionality of the driver to include support of 20 and
24 bits per sample for the earlier SoCs.

Newer SoCs can also handle 32bit samples.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 41 ++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 80bf29e0cc86..adb988ae9ac5 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -399,6 +399,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 20:
+	case 24:
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -411,7 +416,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		sr = 0;
 		wss = 0;
 		break;
-
+	case 20:
+		sr = 1;
+		wss = 1;
+		break;
+	case 24:
+		sr = 2;
+		wss = 2;
+		break;
+	case 32:
+		sr = 4;
+		wss = 4;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported sample width: %d\n",
 			params_width(params));
@@ -687,6 +703,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_3LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
+#define SUN8I_FORMATS	(SUN4I_FORMATS | \
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -694,14 +717,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.ops = &sun4i_i2s_dai_ops,
 	.symmetric_rates = 1,
@@ -1106,6 +1129,18 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
 	i2s->capture_dma_data.maxburst = 8;
 
+	soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
+			       sizeof(*soc_dai), GFP_KERNEL);
+	if (!soc_dai) {
+		ret = -ENOMEM;
+		goto err_pm_disable;
+	}
+
+	if (i2s->variant->has_fmt_set_lrck_period) {
+		soc_dai->playback.formats = SUN8I_FORMATS;
+		soc_dai->capture.formats = SUN8I_FORMATS;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun4i_i2s_runtime_resume(&pdev->dev);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
