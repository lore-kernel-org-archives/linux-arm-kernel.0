Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:23:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2700217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JMOg5YiP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6qr585s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2700217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xUfpqbH/JzMzkg1ksWKTbtep1+kB9NJC0yPv3KVF5VA=; b=JMOg5YiP8MZeQC
	blGABWnVxKSL+LOzCSC7pdLt8IGFimE+iZzD0qRoH72vFZyNhbADhY3DRQ89a562zoQ+M4l1mlQgo
	cv3Q9L+5jaxeN03pvXd/49rDstxl9IQSMmfJiSyD1Fn63kO7HiOUIJ0M7hIdzfyB6L/eCrxo1HvHm
	hH12XvhJF87EGxooiz+X86h0Cnj/TmfnRKdAFtJosaW0yWfB71EubJ++IWapgzqZGAhCPzf8fot5b
	YBYbj+E4Y+TwGlhyvlGK3hwtbGPextZyx2cX8ldf8vFM7kgGy3vVz8SpvF7iKGaKDdtMQFjfQEg3F
	qkOcd6BrpwakoYiXWSbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaMeI-000139-0a; Fri, 21 Dec 2018 15:23:38 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaMcI-0007DH-Tj
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 15:21:38 +0000
Received: by mail-lf1-x144.google.com with SMTP id p86so4153894lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 07:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WaF8AFfF7zchnr6jMRHrk5C2QYC8GMssuw/nTJO62Vo=;
 b=U6qr585sBxSIfLRDrNicqGEN9uOJKrt4fr8LvaAGKDSD3SyvethIWfaIaYiDajbcH2
 3klFQ8CEJz3MgAXjRXbMvvxMBzbTYrVW/7C283WJG5nE9fMszouSKk61cXVdWlq/XRKg
 AXzC99PWUUDJ6AZpqCDvtPLVyBamtqWAu3Hea6ZH0ALIZHFpLWUgtsZYkxRGakzEg748
 I/2uMhp8fFlizqFGJAyTy6tAbd4JFrL2c6XnXq1zd03R/KNm5O1kBxhjm8qupywToYYr
 KxVTBH4VZAgM7+YaNPmveC3UxJXfrzPrMu+k7GP6usCZ3qRN7cr4ngLcMI/uS971ae1l
 KBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WaF8AFfF7zchnr6jMRHrk5C2QYC8GMssuw/nTJO62Vo=;
 b=ss4XI9X+AFA6V0YorE7oi+qldBYneP4+7ujNkFzzUNboa2BpMGXuSGAmZdFYfL19St
 9v94l7J/ZpB9NpalaS5sMgZDHYXtjqm2UHmhz4s/mm0g95t824bv0IYUfFomuqcRgW0p
 /OOB7NlrxlWw/HMv6zELNj+eowLS4ZAwSUTq21c1RVcfSJ5u7t5oX3BapwDCe9xWPs5T
 CsVDRkNgVYy7m7kUTaPq8G8oY5niUk5zdvnjCLEydy14Dh9Jrvh2Fcjzd0xrEdji4nKS
 MZ/LR20iBkUBBLKX7uWQqDraQ3drCG+lkomOF/w2sHlL58CWR2/TZar74zBhD+5v/co9
 GStw==
X-Gm-Message-State: AA+aEWZCzgsSNoPkyJV32REAGRJL8HY5kYDLoaesPpkrxW9fINZ/K13o
 lGeXPK+k90H4AXaCeclNNJ4=
X-Google-Smtp-Source: AFSGD/V5wWqjvO4yJ3wN68om6a2DmjCFJ9oGRSa6cS+wnGo2HshVYZcficms1BX9spXd0OPO4ZR2Rg==
X-Received: by 2002:a19:c115:: with SMTP id r21mr1682969lff.144.1545405682998; 
 Fri, 21 Dec 2018 07:21:22 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se.
 [90.142.43.138])
 by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 07:21:22 -0800 (PST)
From: codekipper@gmail.com
To: maxime.ripard@free-electrons.com, wens@csie.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH v3 8/9] ASoC: sun4i-i2s: Add set_tdm_slot functionality
Date: Fri, 21 Dec 2018 16:21:09 +0100
Message-Id: <20181221152110.17982-9-codekipper@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221152110.17982-1-codekipper@gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_072135_773898_266134D5 
X-CRM114-Status: GOOD (  13.46  )
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

Some codecs require a different amount of a bit clocks per frame than
what is calculated by the sample width. Use the tdm slot bindings to
provide this mechanism.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8cec2f42c94e..cfcf427270fd 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -196,6 +196,9 @@ struct sun4i_i2s {
 	const struct sun4i_i2s_quirks	*variant;
 
 	bool bit_clk_master;
+
+	unsigned int	tdm_slots;
+	unsigned int	slot_width;
 };
 
 struct sun4i_i2s_clk_div {
@@ -385,7 +388,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	if (i2s->variant->has_fmt_set_lrck_period)
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
-				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
+				   SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
 
 	/* Set sign extension to pad out LSB with 0 */
 	regmap_field_write(i2s->field_fmt_sext, 0);
@@ -498,7 +501,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			   sr + i2s->variant->fmt_offset);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      params_width(params));
+				      i2s->tdm_slots ?
+				      i2s->slot_width : params_width(params));
 }
 
 static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
@@ -749,11 +753,25 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
+static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
+	unsigned int tx_mask, unsigned int rx_mask,
+	int slots, int width)
+{
+	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	i2s->tdm_slots = slots;
+
+	i2s->slot_width = width;
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
 	.hw_params	= sun4i_i2s_hw_params,
 	.set_fmt	= sun4i_i2s_set_fmt,
 	.set_sysclk	= sun4i_i2s_set_sysclk,
 	.trigger	= sun4i_i2s_trigger,
+	.set_tdm_slot	= sun4i_i2s_set_dai_tdm_slot,
 };
 
 static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
