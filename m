Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5853AC61CE3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:44:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296A520652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T9508VVl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BPYg7qpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296A520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rFlfag0shJIb5zdd4zBFisdeE6bKfEHZUnqpnKVfl3s=; b=T9508VVlbqYWub
	tuPuf3o9SYaJVYLvJT/6jjkF49UCwR46QavXrdzSRPCWo4bGBsFo3ntRsmtB4WLEwhRPVCWKgGl+8
	QY4Foh/+8ndyb0IRPVrfO6552F8BCoiSFx5OQelitgYnMpXL8ILJ+/g/XQtx3q/wFRCwo5lL8zpVd
	gAyPxK+MVwlfZ9a9pmQaeE+SVJBUfp7fSbFx2fQjzXVd/FVOsZo5iCHQBDR7pe536yBU6fi6USunr
	guPAOZf5qGWjdUv+4qpvwwms/fmnmVsZgQEAdY5tydY4neCQxDXS7A07wMMRqybAxbBKKSF9Q9f+v
	bK4HeEkJPRGr2ukZC4RA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkdoZ-0005jf-OY; Fri, 18 Jan 2019 23:44:43 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkdnj-0004tA-Sx; Fri, 18 Jan 2019 23:43:53 +0000
Received: by mail-wr1-x441.google.com with SMTP id t6so17000368wrr.12;
 Fri, 18 Jan 2019 15:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JrTHYLjAfqH/LuOKfXauzd+5MsTXoqD9khhUxUFncuc=;
 b=BPYg7qpaZFjAc7NNQRxZmfxiV+7x0dKNUqPiB26iok4tLYZJhmO1Yk2HRcBEN60mob
 Ox4YXc3CgEXxW+2PbZFOoOhhiU+5OOIKQDb9M/o7XkpsZBrKQaomMsriqrKU6RMdC2jl
 FqusnfMbQ+czsDrxJZPMrjndv7cnmAF0fDJSt2stmZiZwMBfKAnTH5pAkhhzVwMMNrkM
 9Bx1huBitgYtq1TQhO07fJYU84xRDaLjdCfj5JdRVz56gSUrAKxXkc2tSFw0V7kh0zUR
 ez/6B5xOCVMQUsijwZvmsPOhr1ZVviKwIBp+PFO/TLlzAXxXSJfj84cvQx4byEBCpFJ3
 lO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JrTHYLjAfqH/LuOKfXauzd+5MsTXoqD9khhUxUFncuc=;
 b=kzQZgkqExZTr09GcANDACitc1ALnnyZYyTt1BRHnuq5+oX4svZKOVew+i7DrU85zrV
 H4OaGQ1XI6Dt92fOsayl+Zdg6h0Wb7uEgSc4WYno3R1UOrp6akbZ8P7BH9v6TW8nDMOn
 +VmjIa6LOFpcIzBMAaSjJ0n/LcI8Lxr2vR7u7t0+nfsame/0zzf6rQ4ktElJp4CJ90iO
 w3iIpVQCogAXmsbk34Z4Kq/BkNhrCa13Uq5JUsySsKS296X0RPMDNXp0hTdwDYs1h5d2
 Hj84Hzmc4JexV/Rt9fxdakBDOC4ugoZatJ4SZcpF3PPZhrFNUDm4n9Z4pm5fwz8BobLC
 IbzA==
X-Gm-Message-State: AJcUukdGnTi3aL1QctGr9VVnFJr8G+ObVF1OZkBWRsLOz2GPlIqpjQyC
 svYoGTMgKdxqpnN0X+s+SPmPaaG/
X-Google-Smtp-Source: ALg8bN4RVl5PElSfM/oj+M/ToPesknq8DM7ILVmATxDEfk0+W0FQ7TMHx58BvnX1ctSqh2vdTao+8Q==
X-Received: by 2002:adf:9246:: with SMTP id 64mr19635198wrj.130.1547855030195; 
 Fri, 18 Jan 2019 15:43:50 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A810039E290CB771389D7.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:39e2:90cb:7713:89d7])
 by smtp.googlemail.com with ESMTPSA id j8sm108970024wmd.0.2019.01.18.15.43.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 15:43:49 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 3/3] ARM: dts: meson8b: ec100: add the GPIO line names
Date: Sat, 19 Jan 2019 00:43:39 +0100
Message-Id: <20190118234339.16050-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118234339.16050-1-martin.blumenstingl@googlemail.com>
References: <20190118234339.16050-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_154351_928378_B753A1B7 
X-CRM114-Status: UNSURE (   9.13  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the GPIO line names from the schematics to get them displayed
in the debugfs output of each GPIO controller.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-ec100.dts | 50 +++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 5ecd787e9265..b35b1c6b8fdc 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -288,6 +288,56 @@
 	};
 };
 
+&gpio_ao {
+	gpio-line-names = "Linux_TX", "Linux_RX",
+			  "SLP_S5_N", "USB2_OC_FLAG#",
+			  "HUB_RST", "USB_PWR_EN",
+			  "I2S_IN", "SLP_S1_N",
+			  "TCK", "TMS", "TDI", "TDO",
+			  "HDMI_CEC", "5640_IRQ",
+			  "MUTE", "S805_TEST#";
+};
+
+&gpio {
+	gpio-line-names = /* Bank GPIOX */
+			  "WIFI_SD_D0", "WIFI_SD_D1", "WIFI_SD_D2",
+			  "WIFI_SD_D3", "BTPCM_DOUT", "BTPCM_DIN",
+			  "BTPCM_SYNC", "BTPCM_CLK", "WIFI_SD_CLK",
+			  "WIFI_SD_CMD", "WIFI_32K", "WIFI_PWREN",
+			  "UART_B_TX", "UART_B_RX", "UART_B_CTS_N",
+			  "UART_B_RTS_N", "BT_EN", "WIFI_WAKE_HOST",
+			  /* Bank GPIOY */
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "",
+			  /* Bank GPIODV */
+			  "VCCK_PWM_C", "I2C_SDA_A", "I2C_SCL_A",
+			  "I2C_SDA_B", "I2C_SCL_B", "VDDEE_PWM_D",
+			  "VDDEE_PWM 3V3_5V_EN",
+			  /* Bank GPIOH */
+			  "HDMI_HPD", "HDMI_I2C_SDA", "HDMI_I2C_SCL",
+			  "RMII_IRQ", "RMII_RST#", "RMII_TXD1",
+			  "RMII_TXD0", "AV_select_1", "AV_select_2",
+			  "MCU_Control_S",
+			  /* Bank CARD */
+			  "SD_D1_B", "SD_D0_B", "SD_CLK_8726MX",
+			  "SD_CMD_8726MX", "SD_D3_B", "SD_D2_B",
+			  "CARD_EN_DET (CARD_DET)",
+			  /* Bank BOOT */
+			  "NAND_D0 (EMMC)", "NAND_D1 (EMMC)",
+			  "NAND_D2 (EMMC)", "NAND_D3 (EMMC)",
+			  "NAND_D4 (EMMC)", "NAND_D5 (EMMC)",
+			  "NAND_D6 (EMMC)", "NAND_D7 (EMMC)",
+			  "NAND_CS1 (EMMC)", "NAND_CS2 iNAND_RS1 (EMMC)",
+			  "NAND_nR/B iNAND_CMD (EMMC)", "NAND_ALE (EMMC)",
+			  "NAND_CLE (EMMC)", "nRE_S1 NAND_nRE (EMMC)",
+			  "nWE_S1 NAND_nWE (EMMC)",  "", "", "SPI_CS",
+			  /* Bank DIF */
+			  "RMII_RXD1", "RMII_RXD0", "RMII_CRS_DV",
+			  "RMII_50M_IN", "GPIODIF_4", "GPIODIF_5",
+			  "RMII_TXEN", "CPUETH_25MOUT", "RMII_MDC",
+			  "RMII_MDIO";
+};
+
 &pwm_cd {
 	status = "okay";
 	pinctrl-0 = <&pwm_c1_pins>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
