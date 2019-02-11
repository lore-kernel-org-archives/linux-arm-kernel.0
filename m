Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEE7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:38:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A96218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OPIs7XvH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VlkGnrQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A96218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZBEGcOfyTcfn/cJ2nLalyaZOtHNyXNGmracQVMM74Z0=; b=OPIs7XvHmtBJ4O
	h1aHb4jbw5Y+8n5anuj8jMIMyBxVXBbF5eND3xG891ZP4F1G371JRtA0u/aGynEt4ResvJ/1UE7me
	uuetQVcH1XEAfUX7Y8nwHgs2T+mbbn8lLQRf2XmLfQMzqDVwppCepDgaK3LFJ4DIWPLP14CaSseVl
	L+cUZVEYGahWBhkiGjecb+kHQdr/9Esen0itL4tJ+RIMF7eryItcErvfWgk4d9ZfNk65J1pe4sFlI
	nxmjnhhHdZyheqgrq7A5o6V+bMEsnSo87X05rUejvkjcylrJqgXieGJb5c1qhuETbpFWlVGDmJ+ak
	i830sq1HixAQarRj+2iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtArB-0001xE-GV; Mon, 11 Feb 2019 12:38:41 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfj-0007my-Cp
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:27:29 +0000
Received: by mail-wm1-x342.google.com with SMTP id j125so2060685wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DCvcInryiKJ5GrPJy1j5iG1WoHmXy8a7aJkXnmpsZFc=;
 b=VlkGnrQj+iKhYagW+8NaIpzxzLiX0jmOsaP1qvF3EGXmjioAW3T1GIW7BxVORPvcYV
 upa14VKaebAjMFNy5HWv6HchTmjP4DYWOXUE8QGLa+ZsxrGH2RdrcuyAEOr8YoWBWxo9
 YBrJGI1wYtxqsHB0N3eUoKj1h7UHieFwrPCUopUQtY9ya7ybPGMSxMDfaDUUSAKsEKSX
 F5wvLI4Fuz3HC1a1wtaMlRoam+jD+63Iye/OrWmj5jiTp0rFU1ZlT1L90qISv8v72msw
 E8YDxc33MLFq3W79cjiIxYy/KR2/6pWOM7LbHlSdg6MPjpCmmDfdCdWdQLlG6+lJJls/
 UVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DCvcInryiKJ5GrPJy1j5iG1WoHmXy8a7aJkXnmpsZFc=;
 b=p5Ni2ySoWML72SJ5hanrrT/3xt16SdPWsBeYmb8/wd5EDPLx7ZYEQrXUA2DMHfEZ1U
 3bmsJWi5T1uBfcTSd+DJbb0iAVSZz8iQ6XHSioKETmxwaWNJSPgNcR7o1rCP4yvp2TrY
 sVTxlXADEjbm1guGHReYKs8CdRSjmV6hQP3gPs/Hkse5KzK6TSgX0r/2IJ8S43N6bNrj
 ZMWqjkO3iwBFP3hFOoQlGAawls2709xlxxYJSUsxmcMXAFJxRkqvafyeNPP1Fx6Vvh8U
 sLn6qvsZ7hg0iFjJRKdDJPOSPEsaAee1Nv0Ov+JqM/yDrmC+NbjYIRVg/aUujGnCCDk9
 RWow==
X-Gm-Message-State: AHQUAuZGV6FJB0vqYJIzfwBnSrl9nVfpp7pxd268QxamM8n/vrINW9gv
 RCc7QYfyENdY2ccv3PrkId+7SA==
X-Google-Smtp-Source: AHgI3IbHzd9R2IslrKIbcbpFUurSzD1upkfLg0b+KbF5FD6TzSPo8J2Q/fh80YsGTJ6isj8xoALnTA==
X-Received: by 2002:a1c:6c01:: with SMTP id h1mr8987592wmc.113.1549888009977; 
 Mon, 11 Feb 2019 04:26:49 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 30/33] ARM: davinci: cp-intc: drop GPL license
 boilerplate
Date: Mon, 11 Feb 2019 13:26:03 +0100
Message-Id: <20190211122606.8662-31-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042651_927674_09CF148D 
X-CRM114-Status: GOOD (  11.49  )
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
index 4bbf0eba1920..2040c974689a 100644
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
