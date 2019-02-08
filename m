Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259BCC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:52:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AC620863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bs4tD0p+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ae19QPbm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lFbxxyY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AC620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6MQhOEFTPf6Ug4rVnmqnbZik55KrhB+xXUmieYrmNIQ=; b=bs4tD0p+tjVBXI
	lUmiv9HZvuI3Y84VEa0lLsHVhPSMNxdC+ZBR2Hh989aczmTdrsiwN/50slTyV7kIkSr44aF0o4fJe
	u2x9gZwKF0AMSx/LeEllAfuSmkE+iM/oMTQLWzzaDL4g9oezzhXY9aQIaID1VmrM9g1LuJMtoM6Os
	eEQ1xfjYckrOKMphmGsPtua64hyYuLK+8VwMcMogCQLKA9o8bNwjeUlOKpDCFoqCUfB3cZ0zHd31k
	hGtgXsqVPkUAKFd4PnjB8vYCxREWkMVfILBmOFpfrRNDgkmh1VHFogu8Orb3zk6Coin+4hmcs3M6K
	AtdNsMzoGTYtlJ0UHq6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsAJn-00051V-S2; Fri, 08 Feb 2019 17:52:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsAJB-0003yF-SP
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 17:51:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H6mmX1T1Rw0VrOeRhK3Cni5+zNNC71FKpECFu89Vdzs=; b=ae19QPbmu4l2cwzG18Zq4Y7s1q
 REn0H52GaVCgGHFVnb01gz1U13b8s7zw+LbRNoRy2shrjhAxIEivSvkkwE+8qrMah/4FSU/qVZ5UR
 QmeJuqvLMdIa17TdRfhEaEr5OKZq72ZNg/NQ3C8GEw8Puz8rOr36jjbzWngOF231UMz/o9NCrsNMH
 06uh/rQZDbwGwCUo5PSXQLnwr2LBiFeCkgP9jL+IBphWuQy2MRI/49fDT4MARJii+QOsPgapBWk6j
 MNJHbGdDT3yBS1JbvItazf99ecNOlhUSZa9/zzgUH9TtnhVoZRBF8YIOv5VmoWsd0D+GKGk5ss9Lm
 ok0TxP5Q==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3y-0006d9-3k
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:43 +0000
Received: by mail-wm1-x341.google.com with SMTP id z5so4366377wmf.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H6mmX1T1Rw0VrOeRhK3Cni5+zNNC71FKpECFu89Vdzs=;
 b=lFbxxyY3IxcUzFTBJLzsfVJHq8XWJa9p5gP2ToZJ8Ixw5H9OkMWk/36SScf0lAKSU9
 tSCiMlWCBkiFDEUGSaYdSCeFcmduT2HgRl1fLO6QSAEgI8jijHfXF6TWlCwqKKm2yPUx
 kXsSd7j+UxTLYk59MrbixZL68E220LLu6gyJAVlny9LdLIhPnyLcsfFvbMA43RFut5JL
 PI+C8PT3vqL8ro5vX1kXdE5psHfcC/hIS5+stS9Egky2Cj+TnoziMiIFIcaimUv30IU8
 6St8xbZY7h0iscYwhEkls2aP/7Ak/GZycpg+PqVn+xKYVPCFi4U4lRwo8PSp+l4SDRDG
 wuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H6mmX1T1Rw0VrOeRhK3Cni5+zNNC71FKpECFu89Vdzs=;
 b=r38ck+8bKYKaYt7hBvvzM8sZ5QxT6+OX8I5qHzjXLW3vccRUaJqT423xM8xPag8mkO
 Y/Xv0W+pTy6fPlKjFNR19iCrjpViNCofb5pijYV2u7A1PLeCUlaUe/UVkW40pzTSalKp
 CHIk1j6ugzPnXh9MmgOkUA76/0JTEda6/ogClmbo9Bnh4NG5MMnLEJxgVfDiU5F9P1Xm
 toZgKnRpgSH20TIhMKmgDdq6gSrlgbEy8yTGJyjpDLthxmx1J/49Vfy9x3DSPTqgozDp
 Ve4MJR9UBUhwQcont4JlZEzcumyCe3xnz+GpcFBcns0Bv4wcdedogK0N53cGflKGxAuz
 Z9QQ==
X-Gm-Message-State: AHQUAuamMR0ilUJPQJLI+RF0yYgZ1yyMYkjfKJEYeCwqP5cB1cwb/D9D
 dIPbfI8MKLsUg9arE5QZE3qTaQ==
X-Google-Smtp-Source: AHgI3IYGRu8V/S6RdIIYnDp1H5CZLu2k9RGp0lVcLanMUYYwQ3Uv6vJud5VqOIjcsIzKC00L0FAyVg==
X-Received: by 2002:a1c:f71a:: with SMTP id v26mr11681787wmh.131.1549647340841; 
 Fri, 08 Feb 2019 09:35:40 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:40 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 29/33] ARM: davinci: cp-intc: use readl/writel_relaxed()
Date: Fri,  8 Feb 2019 18:34:54 +0100
Message-Id: <20190208173458.4801-30-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_173542_172599_7EB7EDAD 
X-CRM114-Status: GOOD (  15.95  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()
and writel_relaxed() respectively. It's safe to do as there's no
endianness conversion being done in the code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index c1efb9390655..4bbf0eba1920 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -45,13 +45,13 @@ static struct irq_domain *davinci_cp_intc_irq_domain;
 
 static inline unsigned int davinci_cp_intc_read(unsigned int offset)
 {
-	return __raw_readl(davinci_cp_intc_base + offset);
+	return readl_relaxed(davinci_cp_intc_base + offset);
 }
 
 static inline void davinci_cp_intc_write(unsigned long value,
 					 unsigned int offset)
 {
-	__raw_writel(value, davinci_cp_intc_base + offset);
+	writel_relaxed(value, davinci_cp_intc_base + offset);
 }
 
 static void davinci_cp_intc_ack_irq(struct irq_data *d)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
