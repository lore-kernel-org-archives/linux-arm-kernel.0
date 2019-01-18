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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62ACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:05:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984562086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q+jyJmkH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftqIRO/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984562086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AnPSmJ+QD3kqFPAYiRMj8JAPCD3zcbtIoTuoQYgntXk=; b=q+jyJmkHBr4l0F
	OshECehEyCNpgGo6xejo66kzcTrHHhrlFbqMolEJzEYPhQArHdR5TzEoiukzk7Ig/XYWtZPOkaQTd
	3EMGcS9R/gUv+cyQTlppj4JbiIXmda7VGmMMY1/Qni4KLu4vNpoysHXABU7glQ1dIRt80F5madW+W
	RW244LWgPWsW5KCrwaODJ3kjPrQbuK4RfQwKqIRhG7fBYj0Mp44Qk5j/26wJAhlEoZf7Gyu4yV6V0
	Y5uORgtNIe1Szhsfn7R3ck7tEIFwAlZvw2ervVFHGzd73eD7AFGzG+kQDADcDXnmvtRJ5JD04BuNN
	dnMZSy0MgN4tfa3WRgYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXZx-000289-Bx; Fri, 18 Jan 2019 17:05:13 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXXg-0008Cb-Qc
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:03:00 +0000
Received: by mail-pg1-x541.google.com with SMTP id w7so6308764pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UMvz14KsDb0PYMBq3+E2kRoJCqEy6k0e06L9ePq+UfA=;
 b=ftqIRO/X/6mzz1he8iRS6VADySG/xrTgENEVo+bxqpOeBDi+0tTPC1II0ZpFXstAu0
 oKvalFBRf6QPyf8UvcB3wIbjDVvQ7Fsrlkbsiv+LBiGdHkbANXaxxVccLVk6NAkPHtvw
 GwEPPSy4Xu++rppn4Q3+B5J4OJ2wAgGwnw8FN0z0IgRYUHWZMCm/5T2HvVUk5cn5RIl4
 kSnwQQ45Pyl8bpFFnvweymF47YaIM/L76reqUY5Y+xDlRrFOGqqkpbYmsI9oSSFjobZy
 J1J88G7Da8e262SKonZpMQq0UsVKXxFe6ZpMlwa5+PwjYa/yN5TW9mF7IQ+74vJ9FK61
 cFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UMvz14KsDb0PYMBq3+E2kRoJCqEy6k0e06L9ePq+UfA=;
 b=Ou0/51J5N/5llSag1ROch4JJWLFWc+vXCkuLfZIV/htNC/hMpVbl7bTlE2FePcORLm
 xv02BMWX0/Ekb2MKVE+lE5ETzrd1nvNnkRd54aGwj5TNDfW1NDHfm0Fr9vL7Kf74H9n3
 /oS29i0QH2rE6AzISUlnCv49RCrfAtmm34fUhmGVhNh5lv8mGtZYg/mxHK93RFhsBXLY
 A1CpFoWyEZcEN9+1UCkAmMTRpsCDPTCZoSXFlmJHDxEm+h2vZrFmnLPZG15RRPKMw0kr
 mQMLPqYu6GSPW/W0yG1gjOCB9HcE4dCN2XG5C3D15ZhIwrP0uNS24Ed2p9yNNha+SJpc
 xblw==
X-Gm-Message-State: AJcUukce82THUs1Ak1GMpm6ug4JzpwBFucYTF8O3JBZdsAy+WOfAqwol
 NXQVIK/YdBXACVh0+FS/3lA=
X-Google-Smtp-Source: ALg8bN5hUwzZesH5VdBnEDelmV183k6F7bwp74T/wOB1HhQXIVzVGCHABPyZhMDnuYMTeOOaB2enfQ==
X-Received: by 2002:a63:5f89:: with SMTP id t131mr18696033pgb.26.1547830972161; 
 Fri, 18 Jan 2019 09:02:52 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net.
 [216.71.193.140])
 by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 09:02:51 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] DO-NOT-MERGE: arm64: allwinner: a64: enable Bluetooth On
 Pine64
Date: Fri, 18 Jan 2019 09:02:31 -0800
Message-Id: <20190118170232.16142-8-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_090253_281350_A4844E08 
X-CRM114-Status: GOOD (  13.35  )
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

Pine64 has optional RTL8723BS WiFi + BT module, BT is connected to UART1
and uses PL4 as BT reset, PL5 as device wake GPIO, PL6 as host wake GPIO
the I2C controlling signals are connected to R_I2C bus.

Enable it in the device tree.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 216f2f5db5ef..4d48aa31d420 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -302,7 +302,15 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
-	status = "disabled";
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		reset-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
+		device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		firmware-postfix = "pine64";
+	};
 };
 
 /* On Pi-2 connector */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
