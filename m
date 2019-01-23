Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BA7C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:12:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DDF21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nsp1YbtN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Shd8ATuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DDF21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t+lTZd5qMAteI4oym/41aIHssbs5NwbBu8Srz/Z6CX8=; b=Nsp1YbtNYWDkfv
	wcxkxsdz/SlAoyNUeu/MOgKl4PmYAqm/N0e1lDE5F1lMRMsanNgRlQGB1eLKvKiz1AL6HDcYjk3d7
	ESCaDJJKRMlrMMhFIjGlBm8arPg4avqfFEU1usd4iOrSmKzLYoq690gHraq9Yv61EQ4Bu580wi+lJ
	JZAzWwrrsdc3UZbk17e2l+o+XpiDk+0StIEMwlFHejzuao5YHKQakx8x+MVsM7To3CwOQ4AqwVv7r
	rR7xG9rNiqnJ8pSGx7SIfbMJfgTEGktfsxXM4G4M2pWvs14HkyLfkBuqoyH+Cy4ExK7qPQ1qDI5Ta
	dw4BxBeATQwcYIty7FvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKCq-0003so-JV; Wed, 23 Jan 2019 15:12:44 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKCn-0003rp-34; Wed, 23 Jan 2019 15:12:43 +0000
Received: by mail-pg1-x543.google.com with SMTP id v28so1191411pgk.10;
 Wed, 23 Jan 2019 07:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+ltNVYcC6CkDbXmacb4vM3Xb4R9iKDUJk3cvtKU9Vkw=;
 b=Shd8ATuXHOENy4yxqV9u/fdY8+QjiykPRBSFzhvO+drMSv7DXV2XIT38Iv/PC6Fdr+
 d+GoNhUh2NjwE3Bg2fmcKhj/kEgVcwD/w3VlsQsYuXvUis5bmZMjb+e/3gswrX0yyH+A
 /+YLg70wu1GmoqMCItw4aS833hEUY98faggUcHOBENBt6nD2MnXG9zykMbO76jvbhal/
 r/gGqDHlVu3Qd0bsliQHw80vNFtb6hwsQYY0Ccrbn0SzVLEP6SNrKjD6LhjjWtDFR8+n
 Qb69JDtGmB0hnLuIYOmwk+pAEWRrPNcAIBTlWpSISS4BfwDgqzYKePU517vT2LvUpE+O
 6NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+ltNVYcC6CkDbXmacb4vM3Xb4R9iKDUJk3cvtKU9Vkw=;
 b=okHI6eA7K64rzZ631ZeCW8wkQYQPTRW5MI/uQg5ZQpzFMtNHJI05W0H7DSAU/FRaKb
 69+vkSlLdWEO7wSy+fmmvV1Qpe+jVeYt6S2vpBqqNh45HGZc3vQA6ClM8gbVlJMC70n5
 Sxnfl/VNQNiytY0wpXqNYHSeuXaKtYADoIJJrpkW/a6lOmzTdtKt6ZC3R1BDhpu0bxmU
 ccavcXix3E02gBZNEe+EuCBJkjTaQCn8duMu19mbQwBZN4lZPVeDAsjj3oJOL+NNqqaM
 NaLe7NAzAS7XIC7nS8EE2z3RrsqVYvWLIxVpP1QzWgpsZ4xNrt+jkpHFD+T53g1DRHcd
 B4sg==
X-Gm-Message-State: AJcUukcWf0cFnwqym6LW1TGNyW0vlbISGhC4/C6t2n9K0M0TdMXa+VsG
 r7A+OJYYoFVKSRguW0DAtiDXdNCa
X-Google-Smtp-Source: ALg8bN6z1EqnfX0EW8KZXDhQmFCm/nm+rYoTZiMWD2tbmCfKhfRfR9pKc+4Z6evbttkt5ZK6BqHfFg==
X-Received: by 2002:a62:6503:: with SMTP id z3mr2241122pfb.169.1548256360169; 
 Wed, 23 Jan 2019 07:12:40 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.133])
 by smtp.gmail.com with ESMTPSA id v9sm24772468pfe.49.2019.01.23.07.12.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 07:12:39 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org
Subject: [RFCv1 1/3] phy: meson8b-usb2: Enable otg phy controller on Meson8b
 SoCs
Date: Wed, 23 Jan 2019 15:12:07 +0000
Message-Id: <20190123151209.2080-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123151209.2080-1-linux.amoon@gmail.com>
References: <20190123151209.2080-1-linux.amoon@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_071241_249050_36A3AFD2 
X-CRM114-Status: GOOD (  11.82  )
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Rob Herring <robh+dt@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Meson8b support two USB phy controller, one with otg port and
other usb host controller. USB OTG controller ie. otg port can
be used to power on board or host port for usb device.
Changes enable usb otg host controller when dr_mode is set to otg.
Currenly otg port can be used to power on the board.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch in this series.
--TOTO enable OTG port to work as host.
--Currently we can power on the board from this OTG port.

/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
        |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 9c01b7e19b06..1333c77e9172 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -109,6 +109,7 @@
 
 #define RESET_COMPLETE_TIME				500
 #define ACA_ENABLE_COMPLETE_TIME			50
+#define DCD_ENABLE_COMPLETE_TIME			10
 
 struct phy_meson8b_usb2_priv {
 	void __iomem		*regs;
@@ -188,6 +189,20 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 
 		udelay(ACA_ENABLE_COMPLETE_TIME);
 
+		if (phy_meson8b_usb2_read(priv, REG_ADP_BC) &
+			REG_ADP_BC_ACA_PIN_FLOAT) {
+			dev_warn(&phy->dev, "USB ID detect failed!\n");
+			clk_disable_unprepare(priv->clk_usb);
+			clk_disable_unprepare(priv->clk_usb_general);
+			return -EINVAL;
+		}
+	} else if (priv->dr_mode == USB_DR_MODE_OTG) {
+		phy_meson8b_usb2_mask_bits(priv, REG_ADP_BC,
+					   REG_ADP_BC_DCD_ENABLE,
+					   REG_ADP_BC_DCD_ENABLE);
+
+		udelay(DCD_ENABLE_COMPLETE_TIME);
+
 		if (phy_meson8b_usb2_read(priv, REG_ADP_BC) &
 			REG_ADP_BC_ACA_PIN_FLOAT) {
 			dev_warn(&phy->dev, "USB ID detect failed!\n");
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
