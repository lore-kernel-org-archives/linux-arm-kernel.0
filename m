Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0086EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69A0218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yw2N4ZYJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktqJ1kt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69A0218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5nsLucHam1e6Wt0rpVrtQU1vofyiWn9Hpted50YP+1k=; b=Yw2N4ZYJYU9+2W
	9qZgiWCxqCTmMsrfiKEhxWuNwBxNgOjHIGt/YRf+k86GgSVojEwDrh0qQBfViutYEr8tb1OpoxReD
	bAkBaCS5Rs+3C8tDPCBLpIuqntNxfij0suQDU3LlSRqouviqkNEAjvDWu5bkv/bRm4F4W3TSoQQBL
	GgZZTysgz8CHb/fBicX7yOaaEPDcrNsjM2S52cT4p7GKmPQPk3RKjtGmQJ4JbJBoE6sPR47IB5dXW
	m9AlHvnxUgcNEAfrtz8KIEV1r8cP/g7ZrNkyXOn3aEmegoCcuKSbmeYxwPD7MybKl3op/nWczwW7w
	fiVDk9pLc0oFFsC7reyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaMd7-0008EQ-A9; Fri, 21 Dec 2018 15:22:25 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaMc9-0007DI-Um
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 15:21:28 +0000
Received: by mail-lj1-x243.google.com with SMTP id c19-v6so5055332lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 07:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WttkbvrJMbeZSlFiVpQSvZj2pxx/qQWUGD6I3DfhS0U=;
 b=ktqJ1kt/lk3JTICDqMUMFZnM2hvnF0zNJ9f6saRYbOT1cE39WkOTvcMSCKRmCo5piX
 CGP/+24RvDovdWvNf0HgXyJqzb8JHy5505WjBekXy/W8z7pjRWfTrKROy/ouRa2DIO/5
 akULMl1zJyNbmQkHL95C2XYX+cXp6iqznK2W4Y0QGV3o04sEVQf5R8pQpTd01xz9dgSO
 79c/QTYzU+5IsulRWwGHlSCpsTFPkqymht4qE4bslgc+YMMFyy5+4YCsy4TuSSNMCJ8E
 dTdM3wsdbmuUgMvAlQ0P+VucQRLdwvGeiGWPKxkpMyWmIaiTas7ZOO7eIOBEGvJuujWk
 97vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WttkbvrJMbeZSlFiVpQSvZj2pxx/qQWUGD6I3DfhS0U=;
 b=Ak57r6ZXDtYxusnM2l7tpmZUPckoKyWYSWiZs3r5SKVgryer2ZRXrP9dUNnvmoZNFe
 sl8DPpI4lL1sefANcSxIaLwhgJuWLvcBSlQlrRSOck97LUKRlz0cI+/RR+EU4w0sojIi
 uQVCgk2P3xPrTYIoIInYNQZIEiq1d0mAOT57URe/oFVbyRrPSliIQfCy20KF4AFhOA0w
 EN3XNguyeVErRGyRvy/aLO4POLTPcRUk3LWMADLeBfbNtQs8oY07mpkazAXB6n0/lkhV
 ZfasdWLJGjgyd6+sqdhaHYkt8kPYRDQm86dJsj8mHJBujnGwQnSNL/7F908/Kx3CJyBg
 SQMA==
X-Gm-Message-State: AJcUuke8yEsO47WGrgr7A2Jw2EzASB3P+yiSt8Jd9qmPV4PQHqa4rRtw
 hLBBGyTpn06T+ffj4JzAVek=
X-Google-Smtp-Source: ALg8bN7Uh4stQ0PblLE2HU9yausHFhInzYDcjBzuEG/XnLwQ+lPxK5aqiO6E4XElZbTdm/9GhK5vCQ==
X-Received: by 2002:a2e:2416:: with SMTP id
 k22-v6mr2090824ljk.80.1545405684248; 
 Fri, 21 Dec 2018 07:21:24 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se.
 [90.142.43.138])
 by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 07:21:23 -0800 (PST)
From: codekipper@gmail.com
To: maxime.ripard@free-electrons.com, wens@csie.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH v3 9/9] ASoC: sun4i-i2s: Add multichannel functionality
Date: Fri, 21 Dec 2018 16:21:10 +0100
Message-Id: <20181221152110.17982-10-codekipper@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221152110.17982-1-codekipper@gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_072126_114054_9819027C 
X-CRM114-Status: GOOD (  19.35  )
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

The i2s block can be used to pass PCM data over multiple channels
and is sometimes used for the audio side of an HDMI connection.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 121 +++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 57 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index cfcf427270fd..2be3a3e7a3c0 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -199,6 +199,7 @@ struct sun4i_i2s {
 
 	unsigned int	tdm_slots;
 	unsigned int	slot_width;
+	unsigned int	offset;
 };
 
 struct sun4i_i2s_clk_div {
@@ -406,56 +407,71 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	int lines;
 
 	channels = params_channels(params);
-	if ((channels > dai->driver->playback.channels_max) ||
-		(channels < dai->driver->playback.channels_min)) {
-		dev_err(dai->dev, "Unsupported number of channels: %d\n",
-			channels);
-		return -EINVAL;
-	}
-
-	lines = (channels + 1) / 2;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if ((channels > dai->driver->playback.channels_max) ||
+			(channels < dai->driver->playback.channels_min)) {
+			dev_err(dai->dev, "Unsupported number of channels: %d\n",
+				channels);
+			return -EINVAL;
+		}
 
-	/* Enable the required output lines */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
-			   SUN4I_I2S_CTRL_SDO_EN_MASK,
-			   SUN4I_I2S_CTRL_SDO_EN(lines));
-
-	if (i2s->variant->has_chcfg) {
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
-				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
-				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
-				   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
-				   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
-	}
+		lines = (channels + 1) / 2;
 
-	/* Map the channels for playback and capture */
-	regmap_field_write(i2s->field_rxchanmap, 0x00003210);
-	regmap_field_write(i2s->field_txchanmap, 0x10);
-	if (i2s->variant->has_chsel_tx_chen) {
-		if (channels > 2)
-			regmap_write(i2s->regmap,
-				     SUN8I_I2S_TX_CHAN_MAP_REG+4, 0x32);
-		if (channels > 4)
-			regmap_write(i2s->regmap,
-				     SUN8I_I2S_TX_CHAN_MAP_REG+8, 0x54);
-		if (channels > 6)
-			regmap_write(i2s->regmap,
-				     SUN8I_I2S_TX_CHAN_MAP_REG+12, 0x76);
+		/* Enable the required output lines */
+		regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+				   SUN4I_I2S_CTRL_SDO_EN_MASK,
+				   SUN4I_I2S_CTRL_SDO_EN(lines));
+
+		if (i2s->variant->has_chcfg)
+			regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+					   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
+					   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
+
+		regmap_field_write(i2s->field_txchanmap, 0x10);
+		/* Configure the channels */
+		regmap_field_write(i2s->field_txchansel, SUN4I_I2S_CHAN_SEL(2));
+
+		if (i2s->variant->has_chsel_tx_chen) {
+			u32 chan_sel = SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset) | 0x1;
+			regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
+				     chan_sel | 0x30);
+
+			if (channels > 2) {
+				regmap_write(i2s->regmap,
+					     SUN8I_I2S_TX_CHAN_MAP_REG+4, 0x32);
+				regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG+4,
+					     chan_sel | 0x30);
+			}
+			if (channels > 4) {
+				regmap_write(i2s->regmap,
+					     SUN8I_I2S_TX_CHAN_MAP_REG+8, 0x54);
+				regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG+8,
+					     chan_sel | 0x30);
+			}
+			if (channels > 6) {
+				regmap_write(i2s->regmap,
+					     SUN8I_I2S_TX_CHAN_MAP_REG+12, 0x76);
+				regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG+12,
+					     chan_sel | 0x30);
+			}
+		}
+	} else {
+		/* Map the channels for capture */
+		regmap_field_write(i2s->field_rxchanmap, 0x00003210);
+		regmap_field_write(i2s->field_rxchansel,
+				   SUN4I_I2S_CHAN_SEL(params_channels(params)));
+
+		if (i2s->variant->has_chcfg)
+			regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+					   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
+					   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
+
+		if (i2s->variant->has_chsel_tx_chen)
+			regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
+					   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
+					   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
 	}
 
-	/* Configure the channels */
-	regmap_field_write(i2s->field_txchansel,
-			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
-
-	regmap_field_write(i2s->field_rxchansel,
-			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
-
-	if (i2s->variant->has_chsel_tx_chen)
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-				   SUN8I_I2S_TX_CHAN_EN_MASK,
-				   SUN8I_I2S_TX_CHAN_EN(channels));
-
 	switch (params_physical_width(params)) {
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -509,7 +525,6 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	u32 val;
-	u32 offset = 0;
 	u32 bclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
 	u32 lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
 
@@ -517,7 +532,7 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		val = SUN4I_I2S_FMT0_FMT_I2S;
-		offset = 1;
+		i2s->offset = 1;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		val = SUN4I_I2S_FMT0_FMT_LEFT_J;
@@ -538,16 +553,8 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		 * i2s shares the same setting with the LJ format. Increment
 		 * val so that the bit to value to write is correct.
 		 */
-		if (offset > 0)
+		if (i2s->offset > 0)
 			val++;
-		/* blck offset determines whether i2s or LJ */
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
-				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
-
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
-				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
-				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
 	}
 
 	regmap_field_write(i2s->field_fmt_mode, val);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
