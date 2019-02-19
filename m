Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83C2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:04:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCABC2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AaedgWyO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="ZBid+p+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCABC2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V+tQ3q4KYNks1YpwcSRDi4au02wUudFN78S7jUXJA9A=; b=AaedgWyOqTG3Yu
	A+RdkGImPTXQajt3jPcZZLL2yZmQbCmMb1CSENUOHjx9Nd/ylHzilFfXZcLnyM5Zs7NqknERWFATV
	BNkWsyBxAbZc4XbuyqOStkruo7z8OUBFdAA/y8pTddaVkgO8sR0G/jeXYl2NQ/QnJ0YWm9ogbTYBb
	5XxxR6oMid0VzYa240Wc+XPR+TdH+k6Dm7ISySGTc/X32Mgusq7scqQ/bUmTwDmok37WlhdJWH8Hl
	8+yjGK3J7KPt1m+4vr2/c3wXuqK2dH64wjZI2Sj649CXvM3wgziKks9PwlacMTQwx0rKsd1PjwJlL
	+sFLIOfIWVsoae1m7UEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw546-0005Jv-Oc; Tue, 19 Feb 2019 13:04:02 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw53n-0004xt-Ei
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 13:03:46 +0000
Received: by mail-wm1-x341.google.com with SMTP id m1so2749236wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 05:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=UX76xod9X+zXCg7JKouCVEpytXUP9Ng1RnH772L+OKo=;
 b=ZBid+p+Keiv1SBhQaOn8qUYKQgVxy3Fveba6NMdztq2HEafBcXQYOo9OG/I9R2ULh2
 TwnE4b/uZsuquiGvAs0vkPDd62yB5sBICb0u5fBNJBY3yndChDFCDcPDwWBCvteGtayg
 7F2ChnaoJUc4HjMzQP+B6ewxWsvp7FaLlwO22vFvJZdR+QkZmNWVIHIQh4+c62fuRdhp
 1znFuG2Yybp3Zxght3tfogtc3hQ3rjF05O3f2VP3eYscqkoTTIfIXlTg3qgqyTXhmcen
 JgTB3bWtjKLTc48K3q5oaZLEEvK3vBYtxlLdkLZfHk1We5XnLJd5FXC6pLIFs2C0937r
 xhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=UX76xod9X+zXCg7JKouCVEpytXUP9Ng1RnH772L+OKo=;
 b=K7cZG/04ZGyIBRJ4s2oygqMfmmLWvYnlWa6NspyOu6iAiL8BrdsjJHzIP8ahf/S5ku
 2YoDDCHweSlnMsKP6V6AK4va/Ebdk6jnulW05mFLzYDlGfqVNkco/hsSW+ESjq7dmLT6
 pyoSMmGqySDXYdADCDOjxrxdLvbniIAXDgaHfWrzWiixxntqC5adZvprD3lfKlQYV+Sc
 GCDZKMnh0IVyxVx5SS1/nMtNgNkhgFkd/fejB1LSH7o9vn0dbNes28rwWXf/1QzlMkws
 FnBUFvxATJlZdv+4gDbgWWfBFWtJ/XnUoRSdrhq/DUREc4MJvxYWHJQtKT3TgysNZ4+I
 5Spg==
X-Gm-Message-State: AHQUAua4lcLTqDMvM1p5XmRsRWFqVSmsnc4/0My++BBN3sLoxDO/8E4q
 ucBBlSIoVwYQavSrb2Wu3SqMFEER3AfTrQ==
X-Google-Smtp-Source: AHgI3Ibw7pREYmcgsu239XRSfhXs9H2h3akRczM2hHgfUTLKr0xB1Ta3pR8R8KyKejopILO1Mee0KA==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr2878403wmd.36.1550581421445; 
 Tue, 19 Feb 2019 05:03:41 -0800 (PST)
Received: from diamond.mathembedded.com
 (host86-137-106-133.range86-137.btcentralplus.com. [86.137.106.133])
 by smtp.gmail.com with ESMTPSA id y22sm61899811wrd.45.2019.02.19.05.03.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 05:03:40 -0800 (PST)
From: Stuart Menefy <stuart.menefy@mathembedded.com>
X-Google-Original-From: Stuart Menefy <stuart@menefy.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: dts: exynos: Use bustop PLL as the source for MMC
 clocks on Exynos5260
Date: Tue, 19 Feb 2019 13:03:34 +0000
Message-Id: <20190219130337.21353-2-stuart@menefy.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190219130337.21353-1-stuart@menefy.org>
References: <20190219130337.21353-1-stuart@menefy.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_050343_495857_A6534E74 
X-CRM114-Status: GOOD (  15.10  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

By default the MMC clock will be derived from mediatop PLL, which
usually runs at 666MHz. However as most SD and MMC clocks are multiples
or fractions of 100MHz, it makes more sense to use the bustop PLL
which runs at 800MHz. This matches the behaviour of the Samsung vendor
supplied 3.4 kernel.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 arch/arm/boot/dts/exynos5260.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 55167850619c..14b423de9137 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -288,6 +288,14 @@
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC0>, <&clock_top TOP_SCLK_MMC0>;
 			clock-names = "biu", "ciu";
+			assigned-clocks =
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC0_SDCLKIN_A>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC0_SDCLKIN_B>,
+				<&clock_top TOP_SCLK_MMC0>;
+			assigned-clock-parents =
+				<&clock_top TOP_MOUT_BUSTOP_PLL_USER>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC0_SDCLKIN_A>;
+			assigned-clock-rates = <0>, <0>, <800000000>;
 			fifo-depth = <64>;
 			status = "disabled";
 		};
@@ -300,6 +308,14 @@
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC1>, <&clock_top TOP_SCLK_MMC1>;
 			clock-names = "biu", "ciu";
+			assigned-clocks =
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC1_SDCLKIN_A>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC1_SDCLKIN_B>,
+				<&clock_top TOP_SCLK_MMC1>;
+			assigned-clock-parents =
+				<&clock_top TOP_MOUT_BUSTOP_PLL_USER>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC1_SDCLKIN_A>;
+			assigned-clock-rates = <0>, <0>, <800000000>;
 			fifo-depth = <64>;
 			status = "disabled";
 		};
@@ -312,6 +328,14 @@
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC2>, <&clock_top TOP_SCLK_MMC2>;
 			clock-names = "biu", "ciu";
+			assigned-clocks =
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC2_SDCLKIN_A>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC2_SDCLKIN_B>,
+				<&clock_top TOP_SCLK_MMC2>;
+			assigned-clock-parents =
+				<&clock_top TOP_MOUT_BUSTOP_PLL_USER>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC2_SDCLKIN_A>;
+			assigned-clock-rates = <0>, <0>, <800000000>;
 			fifo-depth = <64>;
 			status = "disabled";
 		};
-- 
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
