Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0AFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EBA20449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kNWTfv4h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dltVY8Rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EBA20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DrEbh/e73lLkl0shP2BpyMhcUiQQqRAsY6qmQo1rQUw=; b=kNWTfv4h+dRSTl
	jjg6u4tN4W/1GrW5bR/ug5rYGiToYvRug6i9KHAV/X4Vx/n+9T0vPFuf1nJzX8VlILpJwL4Cn2wJ9
	PnZmsm/BCIEnoVZgrFygJ79O08R5C4cV6yph+ifWDnTIC1abv1DfbKRjyZ6qMEdfSQtJQgPZMYsTi
	OKnCGv2lqeTVIDVzY/3puJulmC+9cATnZ6tvxU8ZERY99+HRVXHapvIpQA2V57OFW85i6m1r5fbN0
	SjyFX19mfQvrNxvK+vBxzRkHn4oNTyfKAtSVNECkZAl+fikznUW17ZNZ0796IxKucaiixjWVGsNNA
	sHm4y/Bd1XL7K/3oKX4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVUl-0000Tb-K1; Tue, 12 Feb 2019 10:40:55 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVT3-0005zh-T2
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:15 +0000
Received: by mail-wm1-x344.google.com with SMTP id b11so2367324wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KqCZkQam34X7Bd200BUIwd7m0iyaXsOBKajs3xqc3eI=;
 b=dltVY8Rg9Jt6pvWMqt4mQnCPaY35Oj1OYdIytpSfageeZyQdjxWEmzC06SRbAD13oq
 MwRlr/zdYfEL32h57Ni6Gn1Awqhih/IZHeFUenxtdZ9lOhue+rAnMSx2CBHTe1QsIBoo
 r83Cp/nifNT5AtfHbKVC0ipsTZp6ycsDtdZAOhH8AXXuyeudX6W3JI/NW1sHAPw+tsqq
 R52zODkbXnUJtyGzY5NgJLvmqWtBK+AuPCPxeUmKdLv3vEccM7uNADI7Sc7ZW9KlMdfk
 F6ZcCBRu9l//0c9505kXf4a7PETbtT4y0QfMxJaLz4QmeEpeS3axILCck/jlSEer/hbG
 YAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KqCZkQam34X7Bd200BUIwd7m0iyaXsOBKajs3xqc3eI=;
 b=d9EKuvzBpuM7gJBXmdoWf+L59tUd7lbTBEYeZbeAk0i+xJRVGbvs6lh+B9BQ/51DHq
 73vTB8+mWAZGoygsRfEuMsp5/WouB9LprK0IR4xPzWgKNtStEd7jNmEIDkxd2MWb0cYq
 JOHSXZ1aIJZt3YIyyBldiEyy3fu+Fw8FzOVMba5XfKiaxD8YMCmVYs/g+Pej3YDIb67W
 3IkDWKlIZ+JKZ/c+W0OlRIFPG5SRv15nQc2DSwbWuTPWA5/WhIO5x9uoFokn+fTQOmsz
 nTryFONAy7Da+fyDrEDN4vwy0DFoXjZUyA6L1PBgD5M9q7JPFd46o4b/1fvVIsL1s37e
 fFhQ==
X-Gm-Message-State: AHQUAua7J6IHfmucDXiBIMDoohXeM3OldNFD+UZ92z6l36XMjC+Vjnql
 uwgaRzIRHmMXNDzEtXCo3+ECPA==
X-Google-Smtp-Source: AHgI3IayhylVm8s5vzLnSD2obQATi986qVmsxzmPPX8fbDSSNN9weyF77qA/hPaXkwgx4e13YDKSYg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr2302570wma.32.1549967948526;
 Tue, 12 Feb 2019 02:39:08 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:07 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 10/37] ARM: davinci: aintc: drop GPL license boilerplate
Date: Tue, 12 Feb 2019 11:38:08 +0100
Message-Id: <20190212103835.7768-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023910_689302_981C7FFE 
X-CRM114-Status: GOOD (  13.13  )
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

Replace the GPLv2 or later license boilerplate with an SPDX identifier.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 5bfbd9c70a2e..eadbb9d75415 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -1,23 +1,9 @@
-/*
- * Interrupt handler for DaVinci boards.
- *
- * Copyright (C) 2006 Texas Instruments.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Copyright (C) 2006, 2019 Texas Instruments.
+//
+// Interrupt handler for DaVinci boards.
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
