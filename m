Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354E3C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08D62229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bvCLL/A1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UvlOOgQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08D62229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lypfMT67SftpMqWs+FJuDXijXK1LTEJ4GZmX1Y3eQgs=; b=bvCLL/A1TQuT54
	nWBEQsP5rHjXHbxN35RCDp9ETTCsnvmTGKzQ6P5qxMUOU/+DqHv2NV51Fe8jVINJmlJoujD71sGLc
	lXr+RPu7vhU0jrTpuJbhMhaMZrzTs+5qZ12rZgVdVHeOfN2NbugNoyB7sBOZhFfZZ9EhxZfxbf2Iz
	ACUQkRHtmGU1fg92+nzzkULUTQcND2rwXyyAczK5n18bjXBLoSKSfccxpMWyROHOraMbH+VN8z0Ar
	i9bEJeQM/VfXKBCKX09NUkJmjE6PLS/TBCfIf3VJpBD/6tUCG+JRpYoLTo4cmihb2v+DTVtjApaVH
	v/6ZSUrBaJ0AY/XzNJ+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIPy-0008M3-Ot; Thu, 14 Feb 2019 14:55:14 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINp-00054n-F1
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:16 +0000
Received: by mail-wm1-x341.google.com with SMTP id d15so6605318wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=USRlKAODwGBhkc4t0PSLqGy7lcGY6/I2eL77kpLurCo=;
 b=UvlOOgQsPQxHmkJ7szJSM5p54chW53QnoTkbSc3MyZnIj7ziJg93BwDcuBcSDW6Dek
 BewEUQvoGbsMiqyS5xuJ/Qjz7ZShbG4qd1gxlrRCrGTIVgMnPmvBOqX1tMmUcFULRqw6
 O6EL7ZvsoqGEM7pA8YPJ6amyjxJySJ+GKecTKqGbcCK9372HWQGUC3HUFxDzLKJGSAnd
 EFhQHM6CqCAZMnmtkDWwbzzf0v7T1w3zCZ2UN5ffj5E9iqnUOtA6U5VEuIcMO8W/RTe6
 2BBVwcjPGg0BZn1JMERMVG5Zm//RUNLVXPKFq5QJR7h2vD95e3uFW9tGlsr2JS7hvfKI
 vvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=USRlKAODwGBhkc4t0PSLqGy7lcGY6/I2eL77kpLurCo=;
 b=eA2ZTok/KC5eLaX8ZKa0k5yl81rMUSffa8NyaJAxLvzySBsUi3aHFb4tvCJOm14GYf
 UQ6CzFHktqhAekJs0eUe6lCreZSPRSnzaMaYiw/rrD7WxuklLBvT0lAjG0g58X7CnWzC
 7/RIf6ss7pEIkjF3+C6ErmvzREpuGK+SxUGSZ54d+V/2g5yYHQ0ITNX6LzVORUVA4Yz5
 h0Hyhqq7rhKYlR1E+LadWXqzRn12yeuGvEi86pKpi7IXU6AP3DCH3yn0YkT/V7J4JJWk
 wBz75ylkDrQms3YN6N100wdU9OijWOQrsb2L/ZYAqAqe3nHSWBUwDIv4YfNG4EURSF9D
 DPgQ==
X-Gm-Message-State: AHQUAuZFvkSNnkhoYdf0tW1Uk0Ko41dK9qPnMckurdEMxn68GpoGUX+c
 o7NoVdT+KBqM2G2+glmcJ6FSOQ==
X-Google-Smtp-Source: AHgI3Ia/Zne0eSSbxwIyQn5NbbdsWkhVTDY65hDxiZiitNP5qFnlfOhjP3HvvdEdzUuEa328pRq6ng==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr2874081wmh.119.1550155980091; 
 Thu, 14 Feb 2019 06:53:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:52:59 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 14/37] ARM: davinci: aintc: use readl/writel_relaxed()
Date: Thu, 14 Feb 2019 15:52:08 +0100
Message-Id: <20190214145231.8750-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065301_942714_9E6FE170 
X-CRM114-Status: GOOD (  12.90  )
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
