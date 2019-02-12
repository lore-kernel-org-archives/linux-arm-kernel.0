Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95704C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:46:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF1320863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S7/qF0Kq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="F1TC6wUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF1320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bipp2L1cCvLEzXL5goVf+h6uu41ZhQaW2eTM9dustiQ=; b=S7/qF0KqggbGI4
	XSYRozVjkuk4iXso/On3ttijvJWjzEdJBRCQOaO1CCrfU5wiyZAvJsBbrAVXjW/pBqaU3wDME/ZCl
	rYXSugjHJj9q/tPOPzyalZjdTWdRnUL3bz36Jxa8bbPs6NjfiXOgHIn8AfFM/QCPCAO1RlPLAlasa
	CZzMtWveQ3PFcmT5MK4lij+NueZRRzMe3zSQshjHDiNyDivJOrYZdFPJ6yZrsEU0mzSFEWxccvEUL
	X4Ax+merbPquv5/3AdQmPuHjMitXUh6BIkQnPMaMqp4PUkftlDIhtbaqzkjd78a5NndmJ1RAOOVyw
	LfybgxIDJp2UQilD4T0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVZX-00065M-VG; Tue, 12 Feb 2019 10:45:51 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTV-0006TS-KH
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:40:15 +0000
Received: by mail-wr1-f68.google.com with SMTP id x10so2070368wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D9OS2j5P+OKbS15xo80RfyEYHigP9NlBVGu1ltrl0zE=;
 b=F1TC6wUTuZmx3hKdIE4gbfz64f0JW8+QF+P44YXMQDzrl+ZBhjGVZO0GO4+6ffdt8F
 5x48PKSzX+kh5naABl8lfkxD/T5j5/BOWEKFwwGDPPfOGGqnKA8SxIsqDXGQJdViNFBL
 9GAokojxwam/FXE6UNscQO6MoTXrGdQDxSgjMzNimygLgy2pl2e6j5O06LiBmea4u222
 TSZHcvRN4wHQzbu4LgrWf9Lbjs9gzWX6bULWrkLegz37ZOUvDzOtfPLlW78d9/3fSNMX
 MDPF7PvX45f2j4KzZQurl/niSiJE6O5QHWY2Wuy5MoXjkYi8XyYIQelEq1n57w9yZIN3
 0PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D9OS2j5P+OKbS15xo80RfyEYHigP9NlBVGu1ltrl0zE=;
 b=q4yvsfQq9jrW9vEQxCK5qV2qNEWTR/6Ib1QFIcNKTkBBYtsyHolcWnDs/A2ou8SikX
 XKD6XKwvekUIoo7ua1ZqgRnnBjNj9b6/7MrqCNVHe6VpNFnaDRLjbVq7e35L9pDn5uzh
 vYkAiiXPItL587zLXVopNWcjEzRocbZ24JQWk/cXjld9mHAjtHHaw+sUPwQfSmv9W2Y3
 2UUcjy3VOIzQ8MlPSUpnLpoARFqia58N1Zdfw74aDXH3ye9RaoVSsNW3ZMWjXaUGMLLC
 YKw2ek+Dyv7x8rOABRhbK8hswv79Aqzy430NafJuVHmJ8A8WekzOEA05gGsFyWFoXOjR
 rjuQ==
X-Gm-Message-State: AHQUAuYMku5GuX4BjGgyC1XeGdX9DdfZu6mONyEW86mTrL2eovXwQnSB
 pDDN5PwecemqQeMLi6BSIfhWOA==
X-Google-Smtp-Source: AHgI3Ibkr2nA3t9C2V1RFFZ2AHq936lQzLE3d3F0gDNuxqWGXQOHOCtoHl4ZakDFuvsmP/Cexb4MZg==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr2264874wrr.202.1549967975837; 
 Tue, 12 Feb 2019 02:39:35 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:35 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 34/37] ARM: davinci: cp-intc: drop GPL license boilerplate
Date: Tue, 12 Feb 2019 11:38:32 +0100
Message-Id: <20190212103835.7768-35-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023937_895367_BB7098C8 
X-CRM114-Status: GOOD (  11.84  )
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
