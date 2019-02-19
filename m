Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905D6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:04:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B803217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SMCcLlK7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="bQBLGMry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B803217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fa796bRHB8RqRVnN1vYbtqixrRzkkMA1+7LRIzYn6JU=; b=SMCcLlK7qPiFBr
	dN9JPfDpKw9bVoFj41Us7VaPm2rJdcQKs6fV/01YkxjfFCmLQPqWJokwFkhgeUyvXd5w8cxEZiSp3
	ROsPgT34fc0u5d9XKCeqna7D+dOjc3LkzJnpQ6Di6y6mOa2JoCdcwsDG2DA3DV6XVgcuAKDMV/j4L
	mO8uS+tA8fhUAA6GufXLtWsuQ4IlwGPbRWeAQXMlnQFBYM1gnNaiJR567pNBn44r/GjKSp6UayGux
	YW8HSIzy/eoBRqsiWvKDoThHFkgWUH25GX6xdH1Yeq2DGFVOqIYKkm99yHPKLADQaMaoMit3ZTJ86
	TXnLbNbt2G5oh0puDGww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw54c-00061L-Mh; Tue, 19 Feb 2019 13:04:34 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw53q-00051d-Pf
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 13:03:52 +0000
Received: by mail-wr1-x444.google.com with SMTP id c8so21877183wrs.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 05:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=ib3nWTzMlMvOHJNOPsg7HqLqSUd8Q6N9xMvPHRojwVU=;
 b=bQBLGMryGLAb2PDgTNx/wOurFGL8n9JNoeUl/0J8cuctXc+PK7zN8udi6OsLJ++yAQ
 wyj59U8dx2ZjJ1Ra6Bcgo5UD+LCJRj6x4LNMW8fXz1JAI0B9wrnNbWBUhUd6wxA6F1w2
 dYqVzJvF3xFMSlqx82ToEjNy140T40QitHA/smdTu3ZgIQ4fFxD1KwchRKyEBIhmVuTa
 z7/J/YK8mStOt22l8tFXf6Wy/bUdjsOYMcNLmb8BixVqp4xT1n+kVovM616SAFhgQixT
 JLjNTcAt3rPvXvxvpSjWwm/2egYRc17vS4/QtF7bViCgeeiTSXRnFwugb/xsDWTn/+Ev
 1Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=ib3nWTzMlMvOHJNOPsg7HqLqSUd8Q6N9xMvPHRojwVU=;
 b=S/RsdFz3yWkMyZWrQjRVTZzD0blrm3AAK17A9iOzgOcDnJraF0+DVAL0oSy2f5KWkW
 lL3bams0Occfn6Jvw/A6AobR2UbzxHvtFZMJYn17XW/+x5YNqM2pTzQHN/6YXXjsQIZ3
 WrXgf0XNrc+Atig6goRvdHCAz+cHnbxM+6Pe9P8+NrZL0rwdIYuDTBNCkEap2PiImg27
 mbW+5FcxN7Y1hdxvDvz96+VCPdxjAyJTKoE67u8wb/unufJ2JL/Elvp2izuibgddxp03
 ZU7/EeUjzYHXHD4dEaOBrE8E/i0ypVNOKlSkLAs59kmx8Ovamqykc/gEGBGkixsT8apP
 BdFQ==
X-Gm-Message-State: AHQUAuZGeS+04VH8ZDtN5mbhEg0Pvgom9URYt2Yxp88IgoQ5rc4F4nm5
 oGkFfk63hXmQ5R92tW27VZaP0Q==
X-Google-Smtp-Source: AHgI3IbwmjRNZn7bwTYAg0gBYMFuvwAwGyPrmZu6O37VDNX/OrDqL2+7iXonCx7pQ6GfSTKylZsNdA==
X-Received: by 2002:adf:b741:: with SMTP id n1mr19971800wre.287.1550581425138; 
 Tue, 19 Feb 2019 05:03:45 -0800 (PST)
Received: from diamond.mathembedded.com
 (host86-137-106-133.range86-137.btcentralplus.com. [86.137.106.133])
 by smtp.gmail.com with ESMTPSA id y22sm61899811wrd.45.2019.02.19.05.03.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 05:03:44 -0800 (PST)
From: Stuart Menefy <stuart.menefy@mathembedded.com>
X-Google-Original-From: Stuart Menefy <stuart@menefy.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: dts: exynos: Fix interrupt for shared EINTs on
 Exynos5260
Date: Tue, 19 Feb 2019 13:03:37 +0000
Message-Id: <20190219130337.21353-5-stuart@menefy.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190219130337.21353-1-stuart@menefy.org>
References: <20190219130337.21353-1-stuart@menefy.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_050346_829043_645F869E 
X-CRM114-Status: GOOD (  15.31  )
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

Fix the interrupt information for the GPIO lines with a shared EINT
interrupt.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 arch/arm/boot/dts/exynos5260.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index a8c7c6e589a0..3581b57fbbf7 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -227,7 +227,7 @@
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
-- 
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
