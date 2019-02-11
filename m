Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38290C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:33:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EA020818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eNrXjlKv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="v+foSweA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EA020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rLInrmz7GAFNobJkO9UfWAbD2nyD7QghwtYKcwdeYY4=; b=eNrXjlKvVT3+s3
	E2fvYNdOPL11ffkGSFZhypMP1zz8iTa+q322kc+jV5cYHP4yJomA3MLlD50+eLNfvjjK2cdXNoXzy
	JK2sH1SeSWaowHCy/vEWDXtSA5qIi/RJdk2JhsiDRkIoZQzX0YqCU2ljXIGPRQLXVPhYxDG7e0U8r
	sixMSSm1kt2r061mqbyphJGIGz2WCGIUWX/nxtqnwLdJUtGbwdFIUZZzKpS2sR2aHCAG6xCdrsmiv
	chepMbBmC/YrhJ/g45S9gnSLaRvJrYQf5rgHGix407Kl7zPpISJuOZzNixjtas4TYt0xuFIdEX+QP
	HKK73/VnXA5G6v9Vg8vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAm3-0006CN-Ev; Mon, 11 Feb 2019 12:33:23 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfU-0007WQ-UV
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:54 +0000
Received: by mail-wr1-x444.google.com with SMTP id i12so131709wrw.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=krZKYWoU8pidQJSuC93zX28N7u3H16YP6+0fJKp65YA=;
 b=v+foSweAwlvLRYK067ZEY421O7c6yQsEQ2J3Zc6Guw8DCLrNAlsM/cL1gjLlP5QlKy
 nfEBCwyUMiuslK5XPkwn9nIH3bisP6+hVvu9p3Q812crvhpCneAkVDr5JFupnXxpwSAh
 iWMnD0akRTrSPeWeB0delCZ/+/M6b3bRERwX+wJZHl7f/ogkSX0YPgAtBCFsfnUeKNUG
 u2Hoolx6LL0CuhrA36b0VVIfLwBQu5Xivv0ZdjENk5u5LHzw6XAGLiPYjwrsqtDZLKOF
 ye9V42Mbpxa4qK5s/dhEfHrO28cmKk1CGhBDHEwitsaxgH4NoSJ9mD1y6b83jGS98M98
 2I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=krZKYWoU8pidQJSuC93zX28N7u3H16YP6+0fJKp65YA=;
 b=Zoipus6UMJF/ODs6ceKFLC8IsJXfSrlc+FpxYmuHbrlfj8fiRhO/QXjUSGLAU8RA03
 GcNgJFSAdjv6Yr8zLrurTA1TsNmeOk2OwfosoTLo/k/yWl87DFPgLU9crZR4HRL6V7ie
 5YJ5bcwoyHZpONZ7YU5rWo2VbL4gRdb5xpC+PZVY6pDz87grPu2nZWw+MWXWsm1Aezyb
 gFRuroE9ZDB9OVA1IueIbhKJtP5UqbIwIGdZUhq8RTmJIr0f3sidare/Zw9ilG8Vy1wp
 Mp+K7GVpC29ZbiYAQi54bGgZzk/29DVSX6ZrGhB0OV3Jcn1mudiHPFlkzWN6sIQIpcNj
 y6Pw==
X-Gm-Message-State: AHQUAuZYbJ0zfjiQOaj39ic4GCR8qtyrUS1wX/JCBstU2Pn9o7IzE7LV
 oGn9BSuS3cBO4C6AXLR6YREctw==
X-Google-Smtp-Source: AHgI3IaAQHSdGcRUIgcdYvZNxlXj6H4KgRs1wEYKfsoBZw6wR8VkvZCUMVhkm1hGJ/OCUOvAlE9fHg==
X-Received: by 2002:adf:dbc4:: with SMTP id e4mr29296689wrj.320.1549887995641; 
 Mon, 11 Feb 2019 04:26:35 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:35 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 18/33] ARM: davinci: aintc: remove unnecessary
 includes
Date: Mon, 11 Feb 2019 13:25:51 +0100
Message-Id: <20190211122606.8662-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042637_698592_CE080263 
X-CRM114-Status: UNSURE (   9.70  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

These includes are no longer required. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 0f469c59acfb..0768edfc3b66 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -12,10 +12,6 @@
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 
-#include <mach/hardware.h>
-#include <mach/cputype.h>
-#include <mach/common.h>
-#include <asm/mach/irq.h>
 #include <asm/exception.h>
 
 #define DAVINCI_AINTC_FIQ_REG0		0x00
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
