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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D50C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:04:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9242086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PlAc9np1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE2s9Fi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9242086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6p666/INlzOgOONn0UTVDbQZiFBpe31i8zRvcor8+GE=; b=PlAc9np1Ru8ZKI
	MXn6pspqsnvU4HTUxaL0/S15pcFWDNw0B9OvsHILXdA0Vv/HiqXXpO8JQtbJGINibe0CEXrNvGL5M
	7lVNT7MiyZK2s7V3qsJnLiWUKgVigi+CcV83bvbDVjQ+JtQlFY7zbQ1ImbxcOAisCejhjiOwz4NAA
	0QDeZ9BZfzwXwZruQs3//zLxVMFFFY9NoHDW5vOYP5aKgfsAkqwIWygiHn6F87uvGYcPlWZ3e5hNa
	Uwyt8pkzfyIpyEm03YurTBvCC2gglu7Ej2lHPGLQpj3vr0PqH+lk9Qzfe1tsb1ja4Jl3Qmocu8tcO
	nEF3i934aCwSttKwc0yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXZL-0001E2-GI; Fri, 18 Jan 2019 17:04:35 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXXh-0008Dh-RV
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:03:00 +0000
Received: by mail-pl1-x644.google.com with SMTP id t13so6593417ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZcE0++5u/bnDO9bvoYpUsbiaOU0sb4V9OQ0+PXHgS5E=;
 b=mE2s9Fi4sTMYiU1QXLckdLLFVjTB+qtcWoGKiDN2/mjUnPrMyJ4k64vtBj2rKcUU6O
 In4qg1yIauYZ3u/2jaER+vstVOdaR64r2TQz63tV4b9xq4+0kR1mbsuAHrYt1PpZpXzq
 oga9PX/ZfZSxZJA+a5kXvZmzoIS8wZ3RJv9taxrP8MD0s2iWRIUEHq51q2Lz//kxELtb
 1A6IRRJSJ+rXxq/G1ZsW2VuYUudyvnOJNrs63P6uxAX7xGWcpfk8hBvVoqsSJ4e2LlDX
 1WOem+WVtD1FxWVs4KMe3xsMv6DNVP/T7H/lZ+xu73yMTOvd1rT1S2/qkYcVSK506eFE
 JABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZcE0++5u/bnDO9bvoYpUsbiaOU0sb4V9OQ0+PXHgS5E=;
 b=FL19QjNHSDaqIawQpQLwU5m135KTuKMK3AHRdo7hYngsg2LS12Z1w3K0RVNreWB2NH
 eboXTjn+Mk6PbSraFTTGe1nq9ila8qFSKeOtgMBvY0JA6fTRTTm5mHY4Q2T79zYBAG1G
 vEySyvRi8YpxAmE3U9KOLBAKgXOwYX8UE53dEsKxsHkgcse+KL25rkj0hLppeQPUJZAy
 uUsaLYLBB4rFv8perjxNCKQjlB1ZkSLU0GHud+CGgMrEhLcjrVEbUjhzREMlCsJ3tonQ
 VDY1f2yvmfg76Wn4CDpfa4HBmhz9MhHpl+Ye1np2nsheUw5Jce7+wGXjLC0CHTdgK3yz
 yyuA==
X-Gm-Message-State: AJcUukcIsYN/nSByvS7RJSSe+E70zdAUuZiyyHXT7RtYbvXLy1Llf/kB
 CMt+M1QMtdA0GSwMr+Zj8Go=
X-Google-Smtp-Source: ALg8bN67v456utGVLWiqi+aDYttYUprlBywzYI0OUggA5xoUZQRpdBWeIlXY8gcLLbH3xV9LWXo1SA==
X-Received: by 2002:a17:902:27a8:: with SMTP id
 d37mr20153695plb.182.1547830973155; 
 Fri, 18 Jan 2019 09:02:53 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net.
 [216.71.193.140])
 by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 09:02:52 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] DO-NOT-MERGE: arm64: allwinner: a64: enable Bluetooth On
 SoPine baseboard
Date: Fri, 18 Jan 2019 09:02:32 -0800
Message-Id: <20190118170232.16142-9-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_090254_518275_5524C5CA 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SoPine has optional RTL8723BS WiFi + BT module, BT is connected to UART1
and uses PL4 as BT reset, PL5 as device wake GPIO, PL6 as host wake GPIO
the I2C controlling signals are connected to R_I2C bus.

Enable it in the device tree.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index e6fb9683f213..691ffad390c6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -204,6 +204,20 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		reset-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
+		device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		firmware-postfix = "pine64";
+	};
+};
+
 &usb_otg {
 	dr_mode = "host";
 	status = "okay";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
