Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318E5C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF42420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tTP40kmH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBJVsmq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF42420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oFojoqRGaDSMn9jtdh5TakTJ92R4gnkoTdSJ56+GKKs=; b=tTP40kmHXfPKchyiji9hnqpqA4
	fBsw9lgSRf+itQuNP8/R7ZTlrNUGSduGI+gZcKEAcQSeB53DIrr04LLOr/P0ws5N0Ts2BsW7zpxZJ
	7KKpbAarzAWoLvin9ym+v6+GFYSEUyrC4ayRzaxom+wHm9NZpYLWQB5UWI9i7npmn+fn7Xp18RLVR
	a4BzfGCChtLsqgoKbuzhMOkfVEYpd7QcDVPHiFugs83SB3h4kTTn3c6L7YhHb0uZEwvH2KtCBWJ1K
	B1pzh87KLWSk50nhQhGXxOfsSkUEFXFMsR4YuCuDKHteWyUBvmZjl1qa5NT12+Qt6RuGZEKILoRHe
	Lw0cx+Lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUBT-00010o-Iw; Mon, 21 Jan 2019 07:39:51 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUB7-0000eX-5k
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:39:33 +0000
Received: by mail-pl1-x641.google.com with SMTP id w4so9409583plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 23:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=5wfuddSW6tp5kYw+zApWLVum/WpZ+TiS9aNH3MKdYzo=;
 b=TBJVsmq9SwsUa5AhC2yO9XS+8Y2Gb8Kr8LjezLadJmuXsgGfusLZJVottgxoApjWA1
 NUBiI3D9z/5C9zLI24XFGOP7gg7sBHd+O6mUScFWUjqS0CaZUep5sD79sl0uH7ydjhB+
 HaXic/wvGDMxjQi4MwJa6LzT29QvfIxs6yf/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=5wfuddSW6tp5kYw+zApWLVum/WpZ+TiS9aNH3MKdYzo=;
 b=A2RTm7u0ivlU42ufVvHsSC+vmK2mVY7SjMOCKydiJ3ql1K9EzPyPf3pCT0RpzE5iA8
 YDTsm9omDQPE27mTVF6lBz6Gu6Hvwdj6DZCxy9gbGJfAacQjQiRT3adLcrTDKMLjvUQv
 ErWCLP19k+IjzuqeW5NbvkCNoqHtjktRGoV1vl1TjvOHsWBKyLy1Gju+c6xIaYWozBXS
 2MJ81RwViudTxZUKl1ezurVNiHV+7uKG4YjqOUs0ruX5e8nvc7wSwHSb34UstYvcmYmx
 qDgGGiYimUNYE6SiXBTtjmkZPy5DU6NUyO7w0V9OBMSv7Vx9dP+PvflOiySG4vDqC+xS
 EeOg==
X-Gm-Message-State: AJcUukfE0D8pXItU6qE1DVcO+YodMYARRMFzk7+l1cQVLBDQaugY3oE3
 F0e0RKtokULbcsK6q/Ewh++3LA==
X-Google-Smtp-Source: ALg8bN4b+zcG8uMM54HVPij1o+1kGsedHZcVQYga9e1/iukaWsgMw+36iYZJ6Tg0h0ZeRIOKfy2lKQ==
X-Received: by 2002:a17:902:b090:: with SMTP id
 p16mr29147808plr.190.1548056368629; 
 Sun, 20 Jan 2019 23:39:28 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id h19sm15583083pfn.114.2019.01.20.23.39.24
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 20 Jan 2019 23:39:27 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net,
 orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH 1/4] arm64: dts: sprd: Remove PMIC INTC irq trigger type
Date: Mon, 21 Jan 2019 15:38:28 +0800
Message-Id: <b6a32917d1e231277d240a4084bebb6ad91247e3.1548052878.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_233929_506762_BF674931 
X-CRM114-Status: UNSURE (   9.66  )
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
Cc: devicetree@vger.kernel.org, arm@kernel.org, baolin.wang@linaro.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Spreadtrum PMIC INTC controller has no registers to set trigger type,
since it is always high level trigger as default. So remove its child
devices' irq trigger type setting and change #interrupt-cells to 1.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 82bd642..f2f2aa5 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -13,7 +13,7 @@
 		spi-max-frequency = <26000000>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-controller;
-		#interrupt-cells = <2>;
+		#interrupt-cells = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -43,14 +43,14 @@
 			compatible = "sprd,sc27xx-rtc", "sprd,sc2731-rtc";
 			reg = <0x280>;
 			interrupt-parent = <&sc2731_pmic>;
-			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <2>;
 		};
 
 		pmic_eic: gpio@300 {
 			compatible = "sprd,sc27xx-eic";
 			reg = <0x300>;
 			interrupt-parent = <&sc2731_pmic>;
-			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <5>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -69,7 +69,7 @@
 			compatible = "sprd,sc27xx-adc", "sprd,sc2731-adc";
 			reg = <0x480>;
 			interrupt-parent = <&sc2731_pmic>;
-			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <0>;
 			#io-channel-cells = <1>;
 			hwlocks = <&hwlock 4>;
 		};
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
