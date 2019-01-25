Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B195C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:56:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAE6218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eIfcVfsa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bFqg0MZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAE6218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kif0oIgaAD4OKVW71R8Mzk5XtzGapf/c/JxtXk3vMac=; b=eIfcVfsamXJNBs
	jj497DYBq2DuUrHkQ3ywfO3OBdldQObGxMukPE1zhMP/Y4+mVoZ1DgdFh/dggKo7ve6sTwE0tpM8r
	kW/rtBHpu7CAdcY4sn01jNIrpNNpcqEBA5JidKzhNpiN+50nBe1NTtHeUJQ1BleDZevf3hhcvhJEz
	zAxrgSF0KuUDmgVd0UBfs7H5BxjMjPa0rbzMZmvD4HvdF4aRbLHf1gUoklfLMMwe6BFhMP5teLJNR
	ygwfhF1bH/sn1vtq9sD8mLmylknUujrnXPRMEYdppf5MuZOYqIxg+6ic3C0lEia0KS/hXuMcmmyt5
	doQDKzzcCipLCF5aI7RA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn11W-0004uT-Nv; Fri, 25 Jan 2019 12:55:54 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn11H-0004k3-Ct
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:55:41 +0000
Received: by mail-wr1-x441.google.com with SMTP id l9so10138504wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 04:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FGyl7nUB5a4usJDbt63P5nsvTE/zIzRWdDdcpccuWyI=;
 b=bFqg0MZncMMjGzTjw5VuC3rmnnzE0PujgcrtQUjxYyA1IvG7JH1crjYEDJBqCRZgNr
 nPdEnuiLxgseeeXdoQOGO++RM+HBGydWDvF3wO4Ynydi8GQ4PlPVVVFxetA0QMY7M2SJ
 +y7s8Jnrrdix2xx+oodIoR3qPUas2N3xSluDzMRBM8F15y9PT8JbpyXVeAfYsLpAPm6g
 UeoK6mfxfqssHdhAI2gDHIH8MbYsM1XAE/tL7k61zgBJtjxUu9x0vFfCDXwDhAU8FUh7
 d7e5LeiLBlI/ofXhLpzcOjCGoLz21Dgk44YYGHIOK16c491ZZif8UNSNFw43UYcREYnW
 ZJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FGyl7nUB5a4usJDbt63P5nsvTE/zIzRWdDdcpccuWyI=;
 b=K+DU4S3hySou7dzCt+Ih7ro72D+v5rt0ebpiimUijyYmaomhVX4BUBpSOB0br+vcRU
 3R3yXC/f29L7sneP9yLZm5wxVa4K08NnVHAzs5pl6P/RCtQUh+3Qu72S1MF0rss6E3rM
 8gZhC3qCX/MxWTiMx2byAVTFemqbrmCxCE8rYG4xS19yHYHjZI5K8UW47RA4dkXlHd4w
 bNWc9kEV+zxuDUOLC8oq9n1AmI2t1ix60mp4u6Bc0xAlFLsbQ0EkZcyx8Eqz3qNhXxah
 AFroFDp+3PcZ67nYjv7eexcmrvdzqfY68rluSdKDFlv1toYWzsKcLW5YbG/sQ2vvo13a
 1rHA==
X-Gm-Message-State: AJcUukcmgQCK5YgqbZCuTqmUxwE7R8YOZf8RB/nxT2fddQRsknHrZi/V
 sNndgrQbfFMLjGOEG/ySutrJ9Q==
X-Google-Smtp-Source: ALg8bN4jwUcaRTSE8fMKqaFt565StLTL0XcbuDCAEhoQOX5i4stvF98e//d0UHU4ZrV7rg98em0OqQ==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr11056269wrs.75.1548420937387; 
 Fri, 25 Jan 2019 04:55:37 -0800 (PST)
Received: from xps.expressvpn ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id w80sm93057860wme.38.2019.01.25.04.55.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 04:55:36 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
 robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, aisheng.dong@nxp.com, abailon@baylibre.com
Subject: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
Date: Fri, 25 Jan 2019 12:55:10 +0000
Message-Id: <20190125125513.23656-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_045539_454699_7CF05717 
X-CRM114-Status: UNSURE (   8.58  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SmartEEE, compatible with IEEE802.3az standard, is designed to include
legacy MAC without EEE capability into the power saving system. SmartEEE 
is enabled by default configuration on AR8031 after power-on or hardware 
reset.

Unfortunately this is proved causing issues for certain hw 
configurations.  We add a quirk to optionally disable SmartEEE.

PATCH 3/3 depends on https://patchwork.kernel.org/patch/10781297/


Carlo Caione (3):
  net: phy: at803x: Introduce quirk to disable SmartEEE
  dt-bindings: net: at803x: Document at803x,smarteee-disabled property
  arm64: dts: imx8mq-evk: Disable SmartEEE

 .../devicetree/bindings/net/at803x.txt        | 18 +++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  1 +
 drivers/net/phy/at803x.c                      | 22 +++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/at803x.txt

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
