Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64958C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:58:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BD6222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qzqbbqoU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Q+8OvKcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BD6222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bipp2L1cCvLEzXL5goVf+h6uu41ZhQaW2eTM9dustiQ=; b=qzqbbqoU78NK2b
	CPuG5G/szDPbGT7f2oU4ItOndmzHS2Jad4ySfJu5hEkn1oykTg8k7C62Evm+EMDbhg8+KIkZIS8fc
	vh1WY/i8wg+54O9DS5/jEVzVBWRnDVXy/herxZs39ZIqC/5bDY+wd4wlDsB3fmJQA63sm6CnUwu85
	C3UV661akVmus+npwYPYInsRZvMoTX8DxJlHkKhQotjli6205syzwgnq53nxXWzo6n0qQn8M6kcdt
	KWTJ2WqFiRuGJJn1riwHqNPNfmisfYMcwUX5VGCrK35L2+oKFTrus8nL5AowmHjK2feWbrmwq08WF
	z9++G5TZQjbJnD1cMsPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guISl-00042P-OQ; Thu, 14 Feb 2019 14:58:07 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIOC-0005dD-Hy
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:45 +0000
Received: by mail-wr1-x443.google.com with SMTP id q1so6780590wrp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D9OS2j5P+OKbS15xo80RfyEYHigP9NlBVGu1ltrl0zE=;
 b=Q+8OvKcYMz28eCikUsRT1SEzESuFixDZIfGn2mWPLwiePWiXY2Z+DV8xY3knuo2lA1
 ze+MmpYyyBstJXXRa4nJ/pOd2O38Je13IS2fYhCny/msqIQXriVxc53C5SsQRmOzjJIH
 ePYJu4qzem3qk3GPG0ZlqESpwQtnjy8pufCajzE+lB4mYPnam6xLvQn3PhnVikSkpq2h
 3b4Mi0M3B1zyrvtJ2XgyfCMXQO7O0k734shnRyXnlKJ2LOE5TfF262UhDtm9/AAHnZ1/
 4DZPATMr0BxxNhmI8Oy/qiFDVD/kqZ02OymPzrHsiv72FRecGQ19wW8F6efjawhJZM4Y
 MJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D9OS2j5P+OKbS15xo80RfyEYHigP9NlBVGu1ltrl0zE=;
 b=Z1KZMJ4mdmjc+jW+QJg7shjcZFuQvDm8VsOxPEM7W4feLCQsoaOdePkJIllnGNRmmC
 kX3rEGacBSUHjscbG7DLaBwc3ZnpPjNygr2KyousGgcdpBCsTyZqh3KCRMHhjPUq1UJb
 fVwSpoDsZWGi5SHHmlanpdJDIm7XzrsijGQhVh27WKVLxVE8LSC1dMqRwsg6tksxPENo
 8YGzKVnycxSSFyMw6lhPlqD2ZZZeFwPaPU/wDu3Y1ei77PowKUyVkfOXK/FlAobcENM+
 dedwlRvU2L3Z1czX+bsTxyyhAE8KvkMeDk8KOM26iV6j8yN4/aM9KJcXL7gx59Fu5Ryj
 DWeA==
X-Gm-Message-State: AHQUAubYPAjtQ+8hCMkVwllfKGHLs5jA6E/rAfE6rQn8EMrSxqDzieqN
 Rrg/vynea3Ul79ACCGOole+szg==
X-Google-Smtp-Source: AHgI3IYUNJ6gjMu13DLiX/0O8K+lGwumOsQ6vq6uhsteUkOicKJHagr5JWdJnaG6j5EokVVTE/ahhw==
X-Received: by 2002:adf:f40d:: with SMTP id g13mr3168099wro.18.1550156003257; 
 Thu, 14 Feb 2019 06:53:23 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:22 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 34/37] ARM: davinci: cp-intc: drop GPL license boilerplate
Date: Thu, 14 Feb 2019 15:52:28 +0100
Message-Id: <20190214145231.8750-35-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065325_265821_75F8423A 
X-CRM114-Status: GOOD (  11.43  )
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

Replace the GPLv2 license boilerplate with an SPDX identifier and add
myself as a second author.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index f88b7f0978aa..eeb3351016f0 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -1,13 +1,11 @@
-/*
- * TI Common Platform Interrupt Controller (cp_intc) driver
- *
- * Author: Steve Chen <schen@mvista.com>
- * Copyright (C) 2008-2009, MontaVista Software, Inc. <source@mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Author: Steve Chen <schen@mvista.com>
+// Copyright (C) 2008-2009, MontaVista Software, Inc. <source@mvista.com>
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+// Copyright (C) 2019, Texas Instruments
+//
+// TI Common Platform Interrupt Controller (cp_intc) driver
 
 #include <linux/export.h>
 #include <linux/init.h>
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
