Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC6EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:04:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8D220896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AQYb/qoo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pfpt1dQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8D220896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pMiEDjnlBf/+0YF3FxaoeGo0pcL2uxZDOFKBAtDIzZ0=; b=AQYb/qoo0Rw3tP
	OiN1G0TX/jXDIT4Is4nxkosg7YqwSkNpFHKBoSPXG2V5GPDS/SJCh9nW9IXnWf5ikmePa/8TF3Z4n
	sWiHolmvTreWjhlA1qFqKRWuGxqxfLnpV1aGZUCOikAoUxcao9odvUOkBiMgU++Qmf/0gXaEVHSXe
	+dzJ2GFMxEGZKRdzyB0XGCZTBSFDaBled2ssIGu1FcCd8ezDo0u0NKw26Ah4gBDyp2Hw3monJhVyN
	s7uY2CF3mvKmfbLg1xMzt3z64p2t9z/GmSLV43u10pkFWXzJPrKYaRj8yKHzgVJGw/T9R4M4rtNje
	/55qUJEqIQFNsheW2akA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXZ4-0000xV-0Y; Fri, 18 Jan 2019 17:04:18 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXXf-0008BA-HO
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:02:55 +0000
Received: by mail-pl1-x643.google.com with SMTP id gn14so6598700plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LgNmpUZNbudKQwbqSkrJvpGuDLaSJyahqxMxDXFKylA=;
 b=Pfpt1dQmBQJXMUNgR53emDaiSe047LELt436/GfMUtpuisKukbtTQH0u1w9sEXiywv
 Eep+vI+gVslOyzUUTP6WvwKlfgxcq0zxrTCy5CTP4d27qwoOeoVkZm+Nwpl6ufadeC5I
 VhZohwAFYa1CmsXT4ExcPCwq2ABdLO9Rv5k4uVTtOAxgz3AKy5hRWQ7Ztje51urxC0PW
 dCeTRbjOv3u/nkWlleEwyRK3yaVoV6q1NN8L1aSSpeLd3I2XkpWBhpK1WOk5GNMtTTeu
 KoBlk9mQ5+rhRzDmugWmy9f+u2fVCj4GppqeS3o3nO3/CNiSTp1LvivS98FffuU8O1dN
 m2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LgNmpUZNbudKQwbqSkrJvpGuDLaSJyahqxMxDXFKylA=;
 b=JZuIhVJ+eSL0QFagUKixiPXlpJYmvZeTGSYJmVCHfZ58YyXN3ZyszAUXhb2KZSQtY4
 bd9Lb857tod2jMCW7mtKvL3BNGYeco5FEm2wXm8Jqs9VvmvbtcrqKfzhbxda/WNaTi/k
 yBZFs9nhCGRorHyPGuYssw+ycfN6GgimV+wN2vIK3jVcnOw58bHzFEi9NfacM0bqZK+G
 UpS6CUSxnhqAdxUaPX7B8Q0zFMbFMpfva+6DALsOmTbPzyFGB9Ke2cJ4n5EIjd+7WhyF
 h2bA531NkbS2IwYnrSKNyBWB6CPOIX7OnYNCXOHc1oUAupD9Ap5iqFMUrRStbwWM8HPu
 Sk0g==
X-Gm-Message-State: AJcUukdElz3fkejb4e0zUd9JO3gJsg99VEb5wAtpOsJ+PikRNZdgjMyX
 WjKGfDOUKHDLR5Fdja222aA=
X-Google-Smtp-Source: ALg8bN6kUKgnGRWhF24o8hn5zCzZpIYRKHBoqNOOBq2Gs5dDMB3b/y5oa634RNCtCF32/+SpyIfI3A==
X-Received: by 2002:a17:902:e012:: with SMTP id
 ca18mr19815227plb.218.1547830970874; 
 Fri, 18 Jan 2019 09:02:50 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net.
 [216.71.193.140])
 by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 09:02:50 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] arm64: allwinner: a64: enable Bluetooth On Pinebook
Date: Fri, 18 Jan 2019 09:02:30 -0800
Message-Id: <20190118170232.16142-7-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_090251_875264_E7A794CF 
X-CRM114-Status: GOOD (  12.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Pinebook has an RTL8723CS WiFi + BT chip, BT is connected to UART1
and uses PL4 as BT reset, PL5 as device wake GPIO, PL6 as host wake GPIO
the I2C controlling signals are connected to R_I2C bus.

Enable it in the device tree.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index d22736a62481..8fc55dfa7034 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -340,6 +340,20 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723cs-bt";
+		reset-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
+		device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL5 */
+		host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		firmware-postfix = "pinebook";
+	};
+};
+
 &usb_otg {
 	dr_mode = "host";
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
