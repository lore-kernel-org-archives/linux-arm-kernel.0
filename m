Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB04C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:43:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D816218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wbw+EUHR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lrk7eD5s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="G4hk+Onz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D816218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HGx0B5nxvZy4gup3G+6LvnI5E5BYlKNgHn2Ux8JbM20=; b=Wbw+EUHRlOwG4Z
	qMWJVd1F/tZsOeIgW2AbbFhMR0z+PZ55RfxvksgO0ra/PGPWS+uV99dmpfk/9Qz2Hhhsz88nQVvo/
	6/uJlB29gaS/kO5f70jTJeaUFewUrutp/nE0+8xbQBqIDFbY1MKDz/3LOPtYufYkK73LA+Fnew4v9
	XLnnskl2CW347O3r5jN0HHans+cbjElLvAuIC8NWdBH7uijcyGoF+VCeN2rNj30qp92FBtot3Kxv3
	YaOlBwryIrBkR/QxnXLygOZPG5UZ/cNZhRTchL4DpM1k0O4Hrr+jRGv9TyTKOf6taBf1HxvOlsczf
	+DZYKw77bKgfUK5lsRtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAvm-00068T-A4; Mon, 11 Feb 2019 12:43:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAvH-0004wB-6f
 for linux-arm-kernel@bombadil.infradead.org; Mon, 11 Feb 2019 12:42:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=; b=lrk7eD5s3rEKX9S2aqRZfPgB0B
 mx1ylvTQe1ITfdpaa1sHY64+A85pkw/c2Fj+0Kq3pn68McIKx/0cqDl/8vOPureOTKRVzmXwoQBak
 3HrowBdtohHblbT/UNq7IgO7IOAb27wRiMcCultAc/lpIejryT7OiHgVsiwnAqtZQJ9PM+0WWqkFG
 K3ql7imqwfS66IN/DUrvFxQJ2U7PhwlsrUvDz/ekGIZVEDWszwkf7aVLx9uQmhEuL7B+22rXJ7LQT
 D5ZGFZ9/2zF1Crk5TqIx8wq4Tw26z+IB9pIDe/mBicZtNjvjM5wqaH4d2XXHfqU4I5rAEhjzJJgL4
 b95wF4Hg==;
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfd-0004sg-GA
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:47 +0000
Received: by mail-wm1-x343.google.com with SMTP id b11so17504314wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
 b=G4hk+Onz7gZcvgSYg0Zr5+/mm768DifKcmh7HQJXbmiMi+XAl1Bil4m8X3KjOkLQEY
 l1/Im4dyraPFkQBE/uufiL5zSZodyZsGZWKz30hGNFZZpra71Now21tl41jTpOOLTTRZ
 btobsynMlDlKYCfeUosW9bQWTcFxNt7XWBEBP9T3EP1kqDAzHcZlan9+xZB0Xo6Fs967
 Qjk4XcftC3qjV8MORW3g5JMEgnvMpU0Yt8Y5ol66wKOMbo9f0g8uZIEu70MdkLiwSTo8
 f+wQX1X3myt25dFxhXmoJ6oIakq4Jf2Jvh9Qg701ZSKvnO5u9H4EsccWX9DjGLTKO3qa
 PCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
 b=pND2/IM+EPMCQu9h3NfESOYWaXmCRjgipo7HLkP+oJuAVRQCLmbLUG9CFBuY87RI/9
 O4P6ReQCrE7VK+WcpJ6VfPVz8RkxQeF8glByo3EzxGtURORlCLPBZz2PWU52wd2gmYLL
 yAHYVOW7q/c3wOIAx58Z2YaW8Fekwocf2/T80rtwvysouO/ZB13luAN5BdjeERc3LWz2
 A8Y0V2PZe0NmzwLRVPOOQr0gKd/kyXwFD+HLKA0D/Md2VB2nalGfsXZxNue1hgqxo9uP
 7HLH8msW0a1rNPHVzp+NMiQHVnlFcZzl0LoQjvTdISn1YxPberd2tVnWlYe5ja17isJT
 l6LQ==
X-Gm-Message-State: AHQUAuZIzkTbF5VJJMEGwkPP3v94DYMm8UuQwlw3lRAjSPie7hE7ulWj
 BgRSuLkQRMynWiPpbDOEFX238g==
X-Google-Smtp-Source: AHgI3IZYS4gxKl9Si7JH5QZM38ZIE/i8h8HTjvrFh2lJMk3GXbuojDqcRm71UPvwu9/+/LsyLucPKg==
X-Received: by 2002:a1c:b40b:: with SMTP id d11mr5433674wmf.80.1549888003973; 
 Mon, 11 Feb 2019 04:26:43 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:43 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 25/33] ARM: davinci: cp-intc: convert all hex
 numbers to lowercase
Date: Mon, 11 Feb 2019 13:25:58 +0100
Message-Id: <20190211122606.8662-26-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_122645_606195_71E95D6A 
X-CRM114-Status: GOOD (  14.11  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use lowercase letters in hexadecimal numbers in the cp-intc driver as
is done in most of the kernel code base.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index bf77b6950273..dcd43b067a6a 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -23,19 +23,19 @@
 #include <mach/common.h>
 
 #define DAVINCI_CP_INTC_CTRL			0x04
-#define DAVINCI_CP_INTC_HOST_CTRL		0x0C
+#define DAVINCI_CP_INTC_HOST_CTRL		0x0c
 #define DAVINCI_CP_INTC_GLOBAL_ENABLE		0x10
 #define DAVINCI_CP_INTC_SYS_STAT_IDX_CLR	0x24
 #define DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET	0x28
-#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR	0x2C
+#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR	0x2c
 #define DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET	0x34
 #define DAVINCI_CP_INTC_HOST_ENABLE_IDX_CLR	0x38
 #define DAVINCI_CP_INTC_PRIO_IDX		0x80
 #define DAVINCI_CP_INTC_SYS_STAT_CLR(n)		(0x0280 + (n << 2))
 #define DAVINCI_CP_INTC_SYS_ENABLE_CLR(n)	(0x0380 + (n << 2))
 #define DAVINCI_CP_INTC_CHAN_MAP(n)		(0x0400 + (n << 2))
-#define DAVINCI_CP_INTC_SYS_POLARITY(n)		(0x0D00 + (n << 2))
-#define DAVINCI_CP_INTC_SYS_TYPE(n)		(0x0D80 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_POLARITY(n)		(0x0d00 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_TYPE(n)		(0x0d80 + (n << 2))
 #define DAVINCI_CP_INTC_HOST_ENABLE(n)		(0x1500 + (n << 2))
 #define DAVINCI_CP_INTC_PRI_INDX_MASK		GENMASK(9, 0)
 #define DAVINCI_CP_INTC_GPIR_NONE		BIT(31)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
