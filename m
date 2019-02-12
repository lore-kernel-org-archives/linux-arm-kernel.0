Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153FEC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:42:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D310D20449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aSxvGtHe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Yf9NbJAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D310D20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lypfMT67SftpMqWs+FJuDXijXK1LTEJ4GZmX1Y3eQgs=; b=aSxvGtHeI2IxFo
	rhCOTDB9Q7ImNAnJ2MlrKpljOCGbKXkzdcwwSzyz1R9AQqqBAP8oWNbotKrW+mI2HY9oIbDvYJhcn
	+ihd67VGBKlmx8hIAkX64U4Jvy1GfJKLmm4xtXb425HoGbNVUOPwdzu24tVUn5Zn8g34UqLEHrYQk
	MS4AZVc/jTzM+S/W78phLOazs4ioYoIlTo3RSKgr4XlXq+GO5IeT1qyShiwO/+6pO2NyLQThEMk9u
	QEZ39Tn5MW6NjEzye9lm2HihBZ7yuZQt/i+f8LAgR0eaE2+7skNyds5MPOPKbOy71bAciTMr9Crjk
	sk8EtCsNDFge5xnLTqZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVVi-0001T6-Db; Tue, 12 Feb 2019 10:41:54 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVT8-000659-Ko
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:27 +0000
Received: by mail-wm1-x342.google.com with SMTP id j125so2470139wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=USRlKAODwGBhkc4t0PSLqGy7lcGY6/I2eL77kpLurCo=;
 b=Yf9NbJApVtLWNLVYUeLEcKq5Da86bYDRitPJ5CVjAw+GpyU7YtU0b6nUhwdngeIXYX
 w5bobTS4xxf6vGlL87Rq8qgBTnjvYOsj8svkDmPCz/znvYdjMUZEA5R2bLiCjsA/Krg+
 nQOatKBQUzUUZLX74chDaoFzRTVfimf4U9+yqUALMNmFNZq/Vx6DPfc4DbBLoPtgdoNr
 aV4V2Ln0TLXZEjakUs86jHvu44Z5SVTizA8Vy1DOvXfvroeDynAP80z8uiQT8QvzLsWY
 wr3pZVYolc449TeOYXnqosxNLdmgVAB+LM/a/84YFX6dJhVSknleet7EmLo3W1ktYZcZ
 hZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=USRlKAODwGBhkc4t0PSLqGy7lcGY6/I2eL77kpLurCo=;
 b=VD3PFt466bAy++wvXhja+sxSuuBdquIkdLm1TqCITikl1Ecr5IzgnlFazUaNIM8DbP
 0WhRfrQI43LCVaF2Re4gU4GMdaQNDwoPicBz6rHa7L0iy96rQ8WSAFky289U6MYLlxDr
 kLk9feQGps9bjZ6E0eylpgfYxXESp+oukJ+QmRnqaGA0MPeURT45den5rCyjgqfOUIhr
 BtwP4NhlDnQYaPuR1gu4UVXyxm7++NYGGDZrc4dNrPnzpmsqURRLmkjjrikQi1mHv2lc
 9exCXpN3B2I6QpR3In3JALyrHtUe1YDzbBgRy5ud9GEX+27QSHAzUyMXJCoE4Lt/Alcu
 R6cw==
X-Gm-Message-State: AHQUAuZr6QD9g8eCKbmcWAUkfiCQ7vGMGi3wwVyPrDzj/CTX0LXUZS81
 vsGgOo+5dLk1oWFEWitEp6DT/Q==
X-Google-Smtp-Source: AHgI3IY33oqmLWPySwliC2gvpnXPIS7TecwKtWsdiQwm9jvsGx0XaNxXkSjjO8YOjEgUmkP8T/e4+Q==
X-Received: by 2002:a1c:f701:: with SMTP id v1mr2251393wmh.153.1549967953310; 
 Tue, 12 Feb 2019 02:39:13 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:12 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 14/37] ARM: davinci: aintc: use readl/writel_relaxed()
Date: Tue, 12 Feb 2019 11:38:12 +0100
Message-Id: <20190212103835.7768-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023915_126158_98A96BCE 
X-CRM114-Status: GOOD (  13.31  )
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
 arch/arm/mach-davinci/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2df91fc0dade..509be44eda22 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -36,7 +36,7 @@ static struct irq_domain *davinci_aintc_irq_domain;
 
 static inline void davinci_aintc_writel(unsigned long value, int offset)
 {
-	__raw_writel(value, davinci_aintc_base + offset);
+	writel_relaxed(value, davinci_aintc_base + offset);
 }
 
 static inline unsigned long davinci_aintc_readl(int offset)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
