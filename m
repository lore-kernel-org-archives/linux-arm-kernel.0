Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6C2C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:53:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD95A20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EQH1xqGM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m/xjIQul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD95A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xBUTOrHaGvlUxBZVrGwUvTPanXbtI3eSAICLrkRTByI=; b=EQH1xqGMP9pUDF
	gqnH70C+E9DmD9equMwHWCSmbpz7mEVrM+h4SLAmtIXAhi8dak/5QL1uDVn2HJM1K/3PanQ1An5mL
	yAHlnv1goZFYzytNCi49Iry2o0efZxtFr4dQQ3MlRHI/8zcbognToT29wHYgAhvWIs/xjSDrKcnUL
	UlYmw2i+9dD1tZc7pVnUgrwxqJwn3j5GiWi7jy8RhoeZGdXvSGz3CaAGzFs2UjVeRQs7YIIGdTlEu
	Lvg5DvglQWv97gSNCSAp8WWxWcOrVTij6rMf+iclMZ4tNv0QLoWOPJENPbaXePQLhN6XW68p/YFC+
	um0PgmcIKZw+C8e9r6AA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDki-00078W-A0; Fri, 07 Dec 2018 10:53:00 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDkV-0006y2-PJ
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:52:49 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so3344394wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 02:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6va9uCpYQugXPSPBSUpN4XAYRxV90Vj9sDt46ZNv9ts=;
 b=m/xjIQul5bLIpHPVnJh8BrKkQ+u5UclD6qHu2ItZoXL74vA2ev5euMuA9dvp8QDUgl
 Aa+O4demh3SmZ3IgbvdMeFMUPlLR5wML1NiO+wz8e0T6DZ69OZCDYW64zInSRj1pY33e
 zf5UCVouqP6pA22G0j10AVN5fXzCOM0GBfmbG0AMuI9Rx1rwQGbxCACEWAnTgpjXpEdz
 jGg/e/r5ypO5ig+y9D6bPAEfbouvLYERqelvoF8wIMRp+SPmW6ldVQ1ydT0zsNrKn84P
 xGTFpIqG54vrILtJTzA/uUPFDFN8byflbhv9Qw1gAS2MrcI1r80c7CjlA2VWzLZqN3Vc
 13xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6va9uCpYQugXPSPBSUpN4XAYRxV90Vj9sDt46ZNv9ts=;
 b=RJs6ZdaNB5l++mcg+puD7xT/tnvfbn4AliZ8l+edEiYdbab2+LfqKCDlNUxP+tLJYR
 +xJaDouwr9PFMuy6agONkRJ6q+Rt92WcgDbbe92HiDIutZwQdsIAsqL96vGoR5nvqBNM
 mHNG1FhIh44zGKVtUhHpbdNxLTF9M4SfCL/zV/ZjynNH9myweJIBWSRexR/ZbMn/FQ2p
 o2Gqf99QhLFzYATzHt1q5jTNJRr8T+FAMyxYbUZ2JfzbkhPhC4U7ljdeoU91s8NBaNGx
 Vp6YZz/euR09vu4laVOEWDdVY1Z5BlAXDk5kVvtKhWuolLP7301OfpEaQA7DA2QgejIZ
 /JrA==
X-Gm-Message-State: AA+aEWYG26d/bGB+KuPafxdrqr+Ze/eGkpaQL2W+klsFDPGimDXcf+Ke
 W5Zpe5n/puTVnXqoX3EZVeQYZw==
X-Google-Smtp-Source: AFSGD/W+6e8OTSkktO6mTygdCjZITLqRjnvxbt2LNkQV1c7hs+Xf5Z7xrMnV9GoZIVHHN7lYWQD+cA==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr1499958wrn.185.1544179957940; 
 Fri, 07 Dec 2018 02:52:37 -0800 (PST)
Received: from xps.home ([2a00:23c4:f7a1:ce00:800d:14be:d1d:88c5])
 by smtp.gmail.com with ESMTPSA id v187sm1234684wme.0.2018.12.07.02.52.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 02:52:37 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, martin.blumenstingl@googlemail.com,
 ingrassia@epigenesys.com
Subject: [PATCH v2 2/2] arm: dts: meson: Fix IRQ trigger type for macirq
Date: Fri,  7 Dec 2018 10:52:31 +0000
Message-Id: <20181207105231.25593-3-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181207105231.25593-1-ccaione@baylibre.com>
References: <20181207105231.25593-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_025247_878750_66FB61FA 
X-CRM114-Status: GOOD (  15.30  )
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

A long running stress test on a custom board shipping an AXG SoCs and a
Realtek RTL8211F PHY revealed that after a few hours the connection
speed would drop drastically, from ~1000Mbps to ~3Mbps. At the same time
the 'macirq' (eth0) IRQ would stop being triggered at all and as
consequence the GMAC IRQs never ACKed.

After a painful investigation the problem seemed to be due to a wrong
defined IRQ type for the GMAC IRQ that should be LEVEL_HIGH instead of
EDGE_RISING.

The change in the macirq IRQ type also solved another long standing
issue affecting this SoC/PHY where EEE was causing the network
connection to die after stressing it with iperf3 (even though much
sooner). It's now possible to remove the 'eee-broken-1000t' quirk as
well.

Fixes: 9c15795a4f96 ("ARM: dts: meson8b-odroidc1: ethernet support")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/boot/dts/meson.dtsi           | 2 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 0d9faf1a51ea..a86b89086334 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -263,7 +263,7 @@
 			compatible = "amlogic,meson6-dwmac", "snps,dwmac";
 			reg = <0xc9410000 0x10000
 			       0xc1108108 0x4>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 58669abda259..a951a6632d0c 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -221,7 +221,6 @@
 		/* Realtek RTL8211F (0x001cc916) */
 		eth_phy: ethernet-phy@0 {
 			reg = <0>;
-			eee-broken-1000t;
 			interrupt-parent = <&gpio_intc>;
 			/* GPIOH_3 */
 			interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
