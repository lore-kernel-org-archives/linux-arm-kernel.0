Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F0FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:44:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B99F2085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iEhfhl/h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LDQuT2pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B99F2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qry1KbX8nKlRUk2svea9xJrPXylcubyIJY7NpVCZ4ZY=; b=iEhfhl/h6nx/1f
	5f1YuQ88A0Gbi04UGDbFFfMJF2H691GFhjXv55LBPumz3XXUtGFW3MYm45FXn2PLFE3JcTiWXpcG0
	ynqw8NcMo30TeMFNR2/9cIwB9uc2ntZW6pGX1L9niDB1A2bzDa/tUDPvMov0NehuJoAohlQaiWjHO
	vdlLpBP8Cyq+IgXbT1JsheuOIYV3T9PfI5Jd0Iq5zfr7u+YrTE7WAIHadCHegcvXjT4i7hNxptfK/
	L2EFIxley9Ex0zGf79KgobLbhJ/Mg3LwWFjE+K/3iqdPnmtp0g5Xy3T9C/NrxoXJe4/kN9bnTB5aZ
	cQ5pk4bzrcvl/Bdvautw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCe3-0001vw-19; Thu, 31 Jan 2019 13:44:43 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZl-0005eR-6T
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:30 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so3322363wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w2Xh/bADBzCrm3hKxGT4g5SPR6uE8yywQw4yqUJgRK0=;
 b=LDQuT2ptEwh9NF1JFEiGkKxl7h2tRCIljF+tOMhMiKr2Fb16f/N1+bb0JNGMVFX70T
 hrMgSazv1p25WG6lo9thtuBjBPYV2/n6ixKUiL5Dgvwh0rT6orexRJOmNel3dh+BzpD7
 jurEFlxuK7vKUAZihSUt/l9oN5WQWHc9boQC1b5pkI2fxD2dUQZHbGyv15NHB5oHCuNi
 a1GrJPmy3SMd1dSOvu+IAspEk8wRU1J08XyLbaJluKhwWCAQr00M4MhvhTIRL6IbJPev
 3+2kTrgRsXxvdWQ5xof/gpQ07DFY2aLMRlxzNfmY8vuWONTJqfioHQkonY0+kMA3E0le
 Y9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w2Xh/bADBzCrm3hKxGT4g5SPR6uE8yywQw4yqUJgRK0=;
 b=DY1hChksONA3zVvoUrAYrbyQGHk5YL4OweevQNGt4fxAnM0SwRADFXRWFJtAe67/Vh
 QGqblj/ZTA/6luthF5hSL86VlWaX+EEY5iUsU7VVmE5XiF9OlJNHlsKbpKHAU+QEhGLz
 nfEvcf7IfI6krdG8cTDSW8nPm8zxj0ETMhtf5jVS9KcDhlZ5c2/o507OZI9T7UJ6suVg
 KKOtXurHJV1KdpmdPOI2eCpNkcevQUHxNsr9cnnakVR3c53LVkRJVVgL5TiJeadpgb65
 L2TPaDkWTeano99s5fR7dTb2Oq+g9rj+PqP6JBMwYVjS8Iw1TXucIwmCqgsW4Iro1qKs
 dzJw==
X-Gm-Message-State: AJcUukdnwmnhXa/8NONfgacpReVpqXSCGPK3mvsZg2BHn3YWl8e1tD1G
 yf+TmicXXruzGXNiGoqAxFk7CQ==
X-Google-Smtp-Source: ALg8bN5h64yQsKQBbQ0yLFAe7JMo8Th/nncaNStYFuEj0CyTQd40wFF+daLlnxbSRiE94SMeJfoR+A==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr35274858wrw.123.1548942015818; 
 Thu, 31 Jan 2019 05:40:15 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:15 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 29/35] ARM: davinci: cp-intc: drop GPL license boilerplate
Date: Thu, 31 Jan 2019 14:39:22 +0100
Message-Id: <20190131133928.17985-30-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_054017_613301_898882B2 
X-CRM114-Status: GOOD (  10.87  )
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

Replace the GPLv2 license boilerplate with an SPDX identifier.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 812e49fcaa8b..780b3f57aa59 100644
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
+// SPDX-License-Identifier: GPL-2.0
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
