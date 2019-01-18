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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4435AC5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:53:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1416020823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HNxYUI4z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dRFkUbJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1416020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tFsbCic2FzZPpauswzEa30TOpzOb9IBTKWFfIIcr9As=; b=HNxYUI4zUChn9Z
	XMvueT+v96/Y1fjakEX/2eE6pmrmAUSLLH8fNglYEsgok4fgSlwG1+YBtEUl0J8aqOvGTsAKuxKi/
	rAlb0vgHObJJ4VCNmxG3ZQd8qKOnZXe5Ka+ZTnAM3hcSgSOxcb1gsOntPWYnlCZZMa2ZVidCBsbvA
	zpAdIkwVndmre+9XyaQVTsS0k4xoZYSqVSnakAe27u7dmWdgsOQE8ixIQkUbaPVAkCo+DcAHe8ALc
	pAPmPgWMjXzibKY0FTkVWW+ty1pOIrMES0IIbTRIC7hPAA6WgJDI5nX6PwcbxOegCPZ1OWDurmbxa
	L+Kz5rrAl/7LQjyylhSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkd1C-0001RT-U4; Fri, 18 Jan 2019 22:53:42 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkd0X-0000o3-V7; Fri, 18 Jan 2019 22:53:03 +0000
Received: by mail-wm1-x341.google.com with SMTP id y185so1968948wmd.1;
 Fri, 18 Jan 2019 14:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1uHQ4bAZjvNO49qpkLTZD4pYtUclz2GooyqEYvlGNx0=;
 b=dRFkUbJ6IGzje6D+VET6gsTh/ZjYPhWYBbeV61KPF+HUZIEwt6SXj5jf88xlt5N4RI
 Erfhk84Da9q4KJJYH6kNRrBrBh0KR6pRYWio6UCCKvKCPObQYbU17RcXAlNzYr6KTpsu
 6CC+/YnvZRPEG043ZOanOHkpDymcDdnkE01YZyzvu3LmWrFgWzTc9tUeFcnbJCNc/44T
 HV4r+4r8ZYRVQobt0ODe+shr3UmuagdS/mYXDJf5AqhG+nmy2RCNogPKFnk7jxrN6Ukm
 PAJDr5H9PrK3Zvohidx21tzscZlCEET3T87TPKp5Pv6N2iHE7mVWKpdcktY820ycIyeX
 F7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1uHQ4bAZjvNO49qpkLTZD4pYtUclz2GooyqEYvlGNx0=;
 b=aXn2AH+x7PZPX6TND1MlBLv1nx+47z5a9SFLTajYs9FQxSMvRPDSxG9S8fpaRcE95t
 okG+6TPo5VfGpSi2dA/VYpzs9JbdiYQ/vjOodhMxIb1xmbyT8qb9dCUdIOqqrhtiD28O
 n5iDp79rwA1WymELSAtgIRTm7nJvgAF1MZVdY9RDyQ+WEEoBwECZP/B2sbpuZQJ79JFq
 r8mflcAmdIkd+ZbZ3cje+ScaUeFk9ooi2G0ltgJgzyZlnQDPZnstG1aHG3xSOwVJb/Yn
 A3E+Oysqoq98qWq1f53b7eX1wQjV9fhArr6Qz/59ZftYd7RSQmxyl72QzLj7QI6tZm75
 dWXA==
X-Gm-Message-State: AJcUukdumoioqtZ1Gx2OGSmw7TigJtKkeUDi+Iqb+kFPZhK4okZm+brs
 uVv51Sm+gzfBlBVyLGhDa6XeRY6f
X-Google-Smtp-Source: ALg8bN67jUtPjRE1LtRIFfm8521swZA7ULIsqmd/pnuISNKUHE2Asev8OkNGLDZ3EbbxTIwHNBQ/lA==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr17370378wmi.10.1547851978844; 
 Fri, 18 Jan 2019 14:52:58 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A810039E290CB771389D7.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:39e2:90cb:7713:89d7])
 by smtp.googlemail.com with ESMTPSA id
 x186sm51197352wmg.41.2019.01.18.14.52.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 14:52:58 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH v2 2/7] ARM: dts: meson8m2: use the Meson8m2 specific SAR ADC
 compatible
Date: Fri, 18 Jan 2019 23:52:22 +0100
Message-Id: <20190118225227.6516-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
References: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_145301_998148_8D6F6804 
X-CRM114-Status: UNSURE (   9.46  )
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

The SAR ADC on Meson8m2 is slightly different compared to Meson8. The
ADC functionality is identical but the calibration of the internal
thermal sensor is different.

Use the Meson8m2 specific compatible so the temperature sensor is
calibrated correctly on boards using the Meson8m2 SoC.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8m2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/meson8m2.dtsi
index d1a28c2adac5..bb87b251e16d 100644
--- a/arch/arm/boot/dts/meson8m2.dtsi
+++ b/arch/arm/boot/dts/meson8m2.dtsi
@@ -50,6 +50,10 @@
 	};
 };
 
+&saradc {
+	compatible = "amlogic,meson8m2-saradc", "amlogic,meson-saradc";
+};
+
 &wdt {
 	compatible = "amlogic,meson8m2-wdt", "amlogic,meson8b-wdt";
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
