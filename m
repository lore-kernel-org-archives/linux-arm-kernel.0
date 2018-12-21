Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34858C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:23:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DA9217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YQzLQAJ9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuWu1PCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DA9217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S0JxI+Uszspt7Cj+46PgcjhKb5EhBtMrNBq0mOTzgvA=; b=YQzLQAJ914RSkY
	ELk6tIq9wmGjjkoZACquBs2YxnHl3iU12gLyxktR4inDyF6XyG1KHXRfQayvZEXTETAWfKZyYoEyX
	MmwNA9nLQw9elYGtqjjJEwcCp1TwRTLTgSACKzRWdQ/oLzBZe8748c0p96YF/VMVf0WVHCp2cM9G3
	7ZuiwO2Zavo1MNFv5bNxdeOXv7jAUHqVAcOmZKBful/Uv6hWPDLpo4teHLd0Ai3L9wtWfEfryiRGc
	8bEHvXPVAl/7T6DFFCqvl6TYWOPcqNs6qHuTZqDiM1EA7QH9lLR8BFPC0umFUcMsF5hjkDF7uTCqx
	pYspUWvRVXzl/zzV+rrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaMdp-0000Z2-1x; Fri, 21 Dec 2018 15:23:09 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaMcD-0007Ce-Dg
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 15:21:31 +0000
Received: by mail-lj1-x242.google.com with SMTP id q2-v6so5048989lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k1qbR0f7/OKaG3uk0h/lc5XdCr3NJKWBkdbvBaKq80A=;
 b=EuWu1PClYpwp9gdZ17n750bQjIT94h6/zAyN33C9bfXmrfT+wvk5gOL7dNRZaGYwah
 8FxmTqFa1XS5Ejuh7K7UJaB1b5hqTw/rNIdf8/lhH06psbomy0Jr2DNpuvkZOIU8Dc55
 CijO19JmtXQyA1p34V+suC2X3IyiK1EVNwyNhMZbIs/cirB9qvHA3gxrXwZ/uN20ACWS
 UH/St2n/Go9gu93UXpwWsA4+5h3O+iHFwaR8YLij8x94BbPUqGrSGLES9DY22ULZjf+s
 MUDLHOhOpiwesuKj4LUPx6rFb7wjDlmvbD1ZgEXR0l7odLPfa7qzFaZq2jVpCzHApmrq
 /rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k1qbR0f7/OKaG3uk0h/lc5XdCr3NJKWBkdbvBaKq80A=;
 b=R0GXcdy+wkwzSS2uNqJyXLmNXBFqI2oX19aXMeLn1UOmgnrkfbfJ6WXc1YVcGSpr6X
 /lLcXs2o4xfeTZMpopW6zxW5tZmMtCXEWGKPJAHL9QpqYd/ao/lh98boKN7SNHrmgW+1
 Yv7Ggl9xs7uU3L2E5Cnm688LQiKtrookpYVcjKDeJloFWeIChmbSQhEh6r0qFPpdENr6
 qf3r/YSuYyzVxfP31Du8/+pZZMldwbymCJ1tj1GCjaS7i9wh1WU+61qr1+ImzvmyTIxB
 LegLRjMB9PIOrWEZEFExlYcRoYlMTYf8sGsngL5pjrjQYCz7NzKGejreEFSiHb66p813
 hIyw==
X-Gm-Message-State: AA+aEWaOewkhyZjsg2PGMURWYe7qzZsXMmgmazK2U5xmuwO706tyMQ60
 q7ZelSDdyI0XV5jknnrn8/8=
X-Google-Smtp-Source: ALg8bN7CioKpx+xsbgSjLD0bnfPUdQM43lHkATv4YHbnzslwvMy2Pgzi3IQPMeWIWPP96sf5VonMwA==
X-Received: by 2002:a2e:5356:: with SMTP id
 t22-v6mr1827643ljd.26.1545405677647; 
 Fri, 21 Dec 2018 07:21:17 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se.
 [90.142.43.138])
 by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 07:21:16 -0800 (PST)
From: codekipper@gmail.com
To: maxime.ripard@free-electrons.com, wens@csie.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH v3 4/9] ASoC: sun4i-i2s: Fix offset mask
Date: Fri, 21 Dec 2018 16:21:05 +0100
Message-Id: <20181221152110.17982-5-codekipper@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221152110.17982-1-codekipper@gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_072129_736168_03E7B8CB 
X-CRM114-Status: GOOD (  11.39  )
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

Also add offset to RX channel select

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index adb988ae9ac5..93a484d7e228 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -110,7 +110,7 @@
 
 #define SUN8I_I2S_TX_CHAN_MAP_REG	0x44
 #define SUN8I_I2S_TX_CHAN_SEL_REG	0x34
-#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 11)
+#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 12)
 #define SUN8I_I2S_TX_CHAN_OFFSET(offset)	(offset << 12)
 #define SUN8I_I2S_TX_CHAN_EN_MASK		GENMASK(11, 4)
 #define SUN8I_I2S_TX_CHAN_EN(num_chan)		(((1 << num_chan) - 1) << 4)
@@ -482,6 +482,10 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
 				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
+
+		regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
+				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
+				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
 	}
 
 	regmap_field_write(i2s->field_fmt_mode, val);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
