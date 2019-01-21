Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D619C282DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:40:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4B220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dVqWXO2Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lqbj5P2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4B220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XykL4mtV6XiR65LsgR+Hhl2d+i3LyAXoeuHZNASYryc=; b=dVqWXO2YYqxKU2pOxqV/1G5u8V
	y0WqAp5JyeetI7Reid5lElH9NsEWYDQxizXIOXOUfAX3I+GJo/zc6hkWvNYcEzQH6ryhAfMRKEde8
	qscVPgkBBj8eGNH07e4DhIl3yhNktEErLcB57cLrGadKXT7jSxddHyvIYpqnojMWc7x/KBPpHHux0
	pebCzSSWC5EdakU6HIt61cwzuEmjNaBIZrwyE3oyCasBBypvecx9Zx1BWR5BgrjtZoF8hxQEAA/HD
	xEbobqWcGwLmostaoYXlNlZcb6jWIC2Vep0Ij3oeLROdFojzrfoHTvdGgoQmSzN5T8oK0krC5wq4v
	lYqzlZ4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUBl-0001Uk-8m; Mon, 21 Jan 2019 07:40:09 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUBC-0000ku-St
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:39:41 +0000
Received: by mail-pg1-x543.google.com with SMTP id g189so9080612pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 23:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=TsYSQ/G0YznTAgTKSekGveHgCX9PxIa5Y7B9m7W0j9A=;
 b=Lqbj5P2AYTc1vqNowMzk+9mAq0t5KGdEZRfC24xoBJvA4nPl/uMfeBrkhVSN2uHSGj
 d+2gB+I+nHU8IWodcM6bxv9M+VjA1cd5vRciX1aP1ZAuAgjtDzMcZwNQL6KBS7llorsb
 ZfC4/Q79ujUzyOUUPeHPMGd0IqhACkiFM0MHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=TsYSQ/G0YznTAgTKSekGveHgCX9PxIa5Y7B9m7W0j9A=;
 b=B1l2gbQWNXZazr5OyGdHjjnP2DMyRalq4veFpo6g/TpDFSfIvbrDHPCDzPfBF+29l5
 +IqE65YDuLc58BRkL0QqHOE3XXwgg9GeEvxCL9nFQ+3yVBlTQ+LA2R3j6QkNJ5aTy8Vc
 GvsjdMr0QCglTVWRkNAaOW7gHpTTEfmMNZ4ok9LelR5v2dFLdbMEmVqFhy1a+9GBUBu3
 U9t2+KQW0kOQLXcxW1x/GHAw8EPcL0X/n27u8SgxjgxwILPeWDEZzY7zhPmCejXXM3Ma
 kaBbHulwX/K+ABufDuj63yApMS0b4fn80q+Fduf6cXfs9xUfIL0NgGqviOG5aqhzBQg9
 KjDg==
X-Gm-Message-State: AJcUukdvhuoiqA4KL2hyqjNDwlXjEUPph6GPng+brSblnIMIJ7gz8uIv
 1wGDjGOvEBGoHvW9HW8XoKL7Mg==
X-Google-Smtp-Source: ALg8bN70IdbzIK8C757BC1LH/HJ/zz4z4OB64aQ9xlZS8m6j9OciJvs5CGfpUuQSBWuU++MKfEmIhA==
X-Received: by 2002:a63:61c8:: with SMTP id
 v191mr27385499pgb.242.1548056374353; 
 Sun, 20 Jan 2019 23:39:34 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id h19sm15583083pfn.114.2019.01.20.23.39.29
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 20 Jan 2019 23:39:33 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net,
 orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH 2/4] arm64: dts: sprd: Add ADC calibration support
Date: Mon, 21 Jan 2019 15:38:29 +0800
Message-Id: <0213394a8e432e0ee0809f9032427d971ea9cde2.1548052878.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_233935_374910_EFF9B7BA 
X-CRM114-Status: GOOD (  10.55  )
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

This patch adds phandles to the calibration cells provided by the Efuse
device, which is used to calibrate the ADC channel scales.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index f2f2aa5..a2edc25 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -63,6 +63,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			hwlocks = <&hwlock 12>;
+
+			adc_big_scale: calib@24 {
+				reg = <0x24 0x2>;
+			};
+
+			adc_small_scale: calib@26 {
+				reg = <0x26 0x2>;
+			};
 		};
 
 		pmic_adc: adc@480 {
@@ -72,6 +80,8 @@
 			interrupts = <0>;
 			#io-channel-cells = <1>;
 			hwlocks = <&hwlock 4>;
+			nvmem-cell-names = "big_scale_calib", "small_scale_calib";
+			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
 		};
 
 		vibrator@ec8 {
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
