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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37350C5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:55:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F9220823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sudhOsN3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AiK57wVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F9220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=byMteWifRY6jkwHnhas/U+kwb0Oe6hM2OWgx7mTKD74=; b=sudhOsN3RJg38t
	ZYs6jXRmWDnQCFVc9AvNoS+8fjg7t1WIxEQf/ZAc6MKn3jIORMCWmstXceBAyyfjzrqA2AIKqNW8v
	BYvi+dgSz6g42a01U8nC/J8JNjIN4H8VVu+abCa8iVX/66TthJuFpOQ7VW6/Ij/ObigsnNp6UJlP0
	Dnfp/nrBBPiNugFnZjUDkIJdkE5sO3O/0T4RdrjLGr/V4Y4TQVXUul96SyN4ipewD5RvX1pXTJ3E3
	eKF74b2rZMoLABburxEAqernZOlqZtwD8jvX7+GjqXV/QCftZJidOj86Rzwnu0p3WGKrrcXsWAOKL
	wCjR5EiX5+E7Yls9GcoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkd2w-00047j-74; Fri, 18 Jan 2019 22:55:30 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkd0c-0000qx-Ft; Fri, 18 Jan 2019 22:53:10 +0000
Received: by mail-wr1-x442.google.com with SMTP id 96so16991990wrb.2;
 Fri, 18 Jan 2019 14:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XHAyIX/toFB+9Ta7kl1IOzRCmFz0Mv8bQkAxb45dusY=;
 b=AiK57wVds52nn6QJg53PbOCAcYW296rGCUedqC+FQni5tlIuSdWo0BUBNZdpGnxtsf
 cCStOpHLoCqH+OWWa3mgwhI6b9IaKvycbwGD4EkKlhtCcqEln2XcawykeU94+0fHiX3k
 qWaISpU1rH7AxiHS5u9tlalroZcHEftwgMAW5ioh9UDHokifNQGa9QB9cxN6apNmUuym
 8E3XZxbMAXE86ZQ1p5SOvKLMZ++UUoH2lVd3elYvO5NqgvsXQCo6mCPT6lKOEQnPxB27
 5KE6VuiKS23la9kdsr3A39M7Lpq+qWGqZ24g1BXB0osvLmJ0IQP46djNPpSZ02eZXUkS
 03+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XHAyIX/toFB+9Ta7kl1IOzRCmFz0Mv8bQkAxb45dusY=;
 b=KMplHh8Y3zZQa/FFgCk8AUN9sU8f19E09huM9I+Eywt/jd6TS1fVJnu+OHX4Mx7GIa
 6E/mhh/G/qcWN6fnwrvTrSaYR/SAfna1Aodwwj4EGCbaUGMMAT+/gphmitqJF/5msbgs
 bZJoQOMVWIBp5rUnSscYIBCC+gVFtMEjgNARpHbLOScMt/p5iRksjTNAPrNiTck3wYBM
 TaGIKMsgrtUGMdS2xmiCiZIewdxS5YV0xs9KXlFpCEW3SSv+0v1ufzWzfPugtVpz9XL/
 DBCaYQcoZy4lstX/qozIB+qdhkEbCjPYMenO7GfVET4C8TXW0OtK4p9IySbtiD7tCNi6
 mX1Q==
X-Gm-Message-State: AJcUukdpQRphrAxXftQBaDhD3yNN4jg8I8tgpP6/MRLoSI6ViCueE7ZU
 6rLm/MaNf1zVXfFXFRil1FAl4k3X
X-Google-Smtp-Source: ALg8bN5jdNYU2yyXDTlrdZB1aSUJW/AGqD93TZkQYdLLIuMDXkrbR3h7Pr6YOpx2NsJDe+j9SpQrxg==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr17987223wrr.155.1547851984140; 
 Fri, 18 Jan 2019 14:53:04 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A810039E290CB771389D7.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:39e2:90cb:7713:89d7])
 by smtp.googlemail.com with ESMTPSA id
 x186sm51197352wmg.41.2019.01.18.14.53.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 14:53:03 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH v2 7/7] ARM: dts: meson8m2: mxiii-plus: add iio-hwmon for the
 chip temperature
Date: Fri, 18 Jan 2019 23:52:27 +0100
Message-Id: <20190118225227.6516-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
References: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_145307_073858_88BE0B63 
X-CRM114-Status: GOOD (  10.30  )
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

SAR ADC enabled channel 8 can be used to measure the chip temperature.
This can be made available to the hwmon subsystem by using iio-hwmon.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
index 6ac02beb5fa7..18528101376b 100644
--- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
@@ -44,6 +44,11 @@
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&saradc 8>;
+	};
+
 	vcc_3v3: regulator-vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC3V3";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
