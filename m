Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4BEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:43:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9B9218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cde6EtQ9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JW0aTBzf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lt697TZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B9218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6MQhOEFTPf6Ug4rVnmqnbZik55KrhB+xXUmieYrmNIQ=; b=cde6EtQ9WA9Oin
	9Gdmc1GE1RH13UzzJ0LqK1ukd9QxQ1rzFRh9RJAwDOWVOfEC9c0LaZS99a6Fu4gaO/N0ckvx6RHH7
	ZcnbE9d8KujXKn1u7GnqAzGan2KKAfJeyzvf6Umb4mMu5oKnRmTGg+7NyR6JgxaLF7jBrrAsUzbWS
	2SJMr+JfxSfaDOFrRrd3w79QBJhC4YsuKqg/6hWa9Ll0jW6OdkZw7AZWBpa3BxToaP8Pf/LYh3eMN
	1tid6io4kD7eoFFu/bPH7+xenmtSMgb7R/os4JWQ585alfXETAMo9wxsoI9xD1I08+qnISZQCHTak
	i9m6udAWToLx61PkOg3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAvT-0005pR-9v; Mon, 11 Feb 2019 12:43:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAvG-00054t-Tn
 for linux-arm-kernel@bombadil.infradead.org; Mon, 11 Feb 2019 12:42:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H6mmX1T1Rw0VrOeRhK3Cni5+zNNC71FKpECFu89Vdzs=; b=JW0aTBzf8MQjjV/ATKWT44x8Q0
 4gOoHKH9ZpaH3Ip08QwGj0ADBRgQHkEm9IPEfAS1IyxBcNT/VmmgiEGWodiccjbpuczRBuuBaWIc2
 qAsa+Q+/VeAG5Fg0IQtM83rNgWHW1uzspmmhzpBdyBEoL+sRdbZo81Js1N0uIKfCahFc+0M/XPmY9
 LpF6keRFUcZwjeQfCoITxQ8a2N0pa/u5Xjv+Rs+Qe90QPGzE/PfyZtj5uyTk1HkNmZ/1dwUSxxgAa
 W1lQ+ikEIe3akFjauBXJVLiw90nCINlhcpfN8C+ZuaThUJwURUNsAGrSG+i5wK8RFfi1FP1nGnPS1
 pRoUJH8w==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfh-0004tP-SQ
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:51 +0000
Received: by mail-wm1-x341.google.com with SMTP id q21so17010219wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H6mmX1T1Rw0VrOeRhK3Cni5+zNNC71FKpECFu89Vdzs=;
 b=lt697TZfEgnHkZco7R52pJxInRwx3u59akt81q+jrdp6EBmdAu7AZQzbq+b0/jUHNp
 j5xVuf/8lFcTxvgJGNFNx5e+hux7201Xya4xawCjvt7sZWxZQkLhloX8jxEzBgiR6xVo
 mK8mVEA8MxNNXxzXE7olDOXM3DV/FAmzAyjyet9slncWfcFhyyzEndUUwlO6vp2DA8QD
 TD213OjgmdVBincVwp+PO0Ph9N4fhQ2Z+86wesb9Ze389kxYI7FJvJlWdVoPAXFTufLt
 y5bjMBmZSJONrnDE3B591cs5QtcyHfxEMh2leWM/EfKGh3MA3jjGBD+v0S1MOsecJ79k
 RpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H6mmX1T1Rw0VrOeRhK3Cni5+zNNC71FKpECFu89Vdzs=;
 b=LoHqBL8fMusVPp5tQKr5V0G9Ig/81p6Pvk8i49+DCc3/RlSGY/ZybOZIaMpcfAS5lO
 VdfT6DJPLVd2G0TNt8/0Pb/BqHUgpe6nZaQriQGeM1wJyFVTdm3H+rq2qGeV1wLoyKeS
 WqdrV+JNvr8t4neo0OZWCxz91PshT8HEDGI7GWr4fJTlimzif6MtQZAnkzblaPjr1Y8+
 luihOEUu0jg1VWNkLrK+s44k1x3xC55LCkX5AxiZHjOEQc1WSn8KGrI3h+hdeKF1lVvI
 M/7JyXinTaxOz3XTI4S4LsKgCD41qUzYGg5mBjcWTS+XSXObhqBgbu00jvQP3qWCnxK5
 b5kg==
X-Gm-Message-State: AHQUAub2ibmiIBVxUfmRAVio/l20txkpFEjwR5GvpU4vPQvvWBL0qChG
 sQvRIc6mGx+F/HAvF6uYZMnC7Q==
X-Google-Smtp-Source: AHgI3IZEQ0yJJz3s8V0klutMpLsQAm74CR5tSGGtHWyl4TAhVWbtq+u5mv0pmng0lskLGaYz4z/sqg==
X-Received: by 2002:a7b:c103:: with SMTP id w3mr9614921wmi.41.1549888008827;
 Mon, 11 Feb 2019 04:26:48 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 29/33] ARM: davinci: cp-intc: use
 readl/writel_relaxed()
Date: Mon, 11 Feb 2019 13:26:02 +0100
Message-Id: <20190211122606.8662-30-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_122649_973470_E297E47C 
X-CRM114-Status: GOOD (  15.25  )
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
