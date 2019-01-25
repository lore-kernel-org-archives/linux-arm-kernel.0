Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E70C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:55:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965D4218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oIm6Bmf/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WOIkEhJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965D4218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Fc6pZMPsbyhgZ7AXTWE0c28mxe8WrvB4eXRfgfxZK0=; b=oIm6Bmf/F9ODer
	a4TxbSnz+2AILrM84lYkUf7tpyo5aBJgEe6Dqdyg81OdbnKPuPeyQYxwbDiePMaT3J4fTb5v3nLvM
	/l6mn3IPLB2au7uh8Rrp5bqpzRhWhPo3u2avpUIZ1mvHMAcYsk+rK05Schvo7CjXgRd6aumX3SU95
	Wcj9qJynDYPR82ZBRILOl384LjXlZIlOZ9EtMug9GYRS9/8A+UhFt5AF7zFQeYDnjDlfPR4tI8eMR
	6U+lI+Wo5UO0Xc2q2W96yl0ZFxhPowmVw+MmjVGvvqSiVE1rgnsGCrFn41eABgFZ/3mq94Q06ATFt
	O+Ijm6lfLDfHQWnaEMQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn11L-0004l8-I0; Fri, 25 Jan 2019 12:55:43 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn11I-0004k4-7B
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:55:41 +0000
Received: by mail-wm1-x344.google.com with SMTP id r24so4749586wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 04:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=juLI+9H8NyMB04BIfuKnL7i1P90CozxB4yuKvoPTnoY=;
 b=WOIkEhJLyKhE6FO4EZzh/pxzNtu0kbamQEg6FLM2vJ5VsC9KN+M8pOWiziFgzpril5
 JE75cHtar7/Y6TA6Cky06ORiU9CsBnUkN+LbpdnElckzlZgAO63ytYPRl2J/bi8EimZ2
 P78dsa4aKBVeyPWxZIptP8LsVhUWzo211PJiQ4CWiUozDCWskvnnz7pZ0DSwUm7vL6rY
 dC6umm98RhGQFJygwnUymWtSfuYLREsK0Hb7YHObrL9f45x1G5cbgjTalb1Ft5Aof+57
 NlyLr2KwwT2/7825cBZuN2bLkQbRZg2qrq1cf5entgzn+uIuYWFRaJKvYrr1VdBG8rJU
 vTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=juLI+9H8NyMB04BIfuKnL7i1P90CozxB4yuKvoPTnoY=;
 b=jXkOyj8IJtiKnNWs0L/bmH6Bbl56OkdyLgi1j5YTbYcmWRaWj4PGt1YtfDz2mqw7OM
 RHocHSnGG5iAEOFM42k6H8jyGFFkPf2a5OcoER7AYYR7uwwCkH0Uwqver/h190fJ1ftv
 f2X/hxJgVKO3kpH3nTWxvRGkweJOSeCqUxDjWwG1m/CGEkMBpAq6UWbRCYuY90sH0x09
 fLX2/50s4lwKajTx2DvQrLY/rl4LlcstcwYlSKqh5xku+9fr+9HKwMPsUjolxwFw5TBR
 B7NG9koKC2DOq6b7jHtVl4+EBaFChq5cqfM8cVn8o9KZahop5/h1TyezXnpXi0nyRb8q
 Q1eQ==
X-Gm-Message-State: AJcUukdP3BEyaBR6nYbOhqthJArU/64AzQdFSPKe6sN7OoAHZan/DMOC
 x3ZzFQLJXe+u6V9gfHI4A7kyYA==
X-Google-Smtp-Source: ALg8bN66svBeQC9r9GjiUKIkMpICRdGu5E4GApvSDIZHqXZwDkURxD3z+EDFIhTmjfUAuwTLtk+c4Q==
X-Received: by 2002:a1c:b455:: with SMTP id d82mr7093211wmf.78.1548420938302; 
 Fri, 25 Jan 2019 04:55:38 -0800 (PST)
Received: from xps.expressvpn ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id w80sm93057860wme.38.2019.01.25.04.55.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 04:55:37 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
 robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, aisheng.dong@nxp.com, abailon@baylibre.com
Subject: [PATCH 1/3] net: phy: at803x: Introduce quirk to disable SmartEEE
Date: Fri, 25 Jan 2019 12:55:11 +0000
Message-Id: <20190125125513.23656-2-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125125513.23656-1-ccaione@baylibre.com>
References: <20190125125513.23656-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_045540_255059_926D9725 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The proprietary SmartEEE mode makes the PHY entering a sleep mode after
a configurable idle time. It does this without LPI signals coming from
MAC.

Since this is a configurable behavior and it is known to cause issues
add a way to disable it using a custom quirk.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/net/phy/at803x.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index f9432d053a22..509cd7a4f7eb 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -38,12 +38,14 @@
 #define AT803X_DEVICE_ADDR			0x03
 #define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
 #define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
+#define AT803X_SMARTEEE_CTL3_OFFSET		0x805D
 #define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
 #define AT803X_MMD_ACCESS_CONTROL		0x0D
 #define AT803X_MMD_ACCESS_CONTROL_DATA		0x0E
 #define AT803X_FUNC_DATA			0x4003
 #define AT803X_REG_CHIP_CONFIG			0x1f
 #define AT803X_BT_BX_REG_SEL			0x8000
+#define AT803X_SMARTEEE_DISABLED_VAL		0x1000
 
 #define AT803X_DEBUG_ADDR			0x1D
 #define AT803X_DEBUG_DATA			0x1E
@@ -65,12 +67,15 @@
 #define ATH8035_PHY_ID 0x004dd072
 #define AT803X_PHY_ID_MASK			0xffffffef
 
+#define AT803X_SMARTEEE_FEATURE_DISABLE		BIT(1)
+
 MODULE_DESCRIPTION("Atheros 803x PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
 
 struct at803x_priv {
 	bool phy_reset:1;
+	u32 quirks;
 };
 
 struct at803x_context {
@@ -210,6 +215,13 @@ static void at803x_get_wol(struct phy_device *phydev,
 		wol->wolopts |= WAKE_MAGIC;
 }
 
+static int at803x_disable_smarteee(struct phy_device *phydev)
+{
+	return phy_write_mmd(phydev, AT803X_DEVICE_ADDR,
+			     AT803X_SMARTEEE_CTL3_OFFSET,
+			     AT803X_SMARTEEE_DISABLED_VAL);
+}
+
 static int at803x_suspend(struct phy_device *phydev)
 {
 	int value;
@@ -242,6 +254,9 @@ static int at803x_probe(struct phy_device *phydev)
 	if (!priv)
 		return -ENOMEM;
 
+	if (of_property_read_bool(dev->of_node, "at803x,smarteee-disabled"))
+		priv->quirks |= AT803X_SMARTEEE_FEATURE_DISABLE;
+
 	phydev->priv = priv;
 
 	return 0;
@@ -249,6 +264,7 @@ static int at803x_probe(struct phy_device *phydev)
 
 static int at803x_config_init(struct phy_device *phydev)
 {
+	struct at803x_priv *priv = phydev->priv;
 	int ret;
 
 	ret = genphy_config_init(phydev);
@@ -269,6 +285,12 @@ static int at803x_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	if (priv->quirks & AT803X_SMARTEEE_FEATURE_DISABLE) {
+		ret = at803x_disable_smarteee(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
