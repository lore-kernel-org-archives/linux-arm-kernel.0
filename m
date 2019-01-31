Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054B3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EA62085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L8kcMYDV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="O8/RUD7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EA62085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ac//UrHGEAVHP1QSzx7jfBlvpa/QY4JXbM9j0Vzuxr8=; b=L8kcMYDV9zcBdB
	A8rL/7NkbSZQcAYa7jEchnKbgaxxAE1fRsgvL894WVWulS52ryvqD3kx3KyfNYbnb7SMtPNnX0fN1
	3G0V3E4GUOiZmuTjWdkG9QjKxb3L0AeV45NoFw46MenY6XCsAL2GJLWcCBWsRB0k/x3KyCxha6SoI
	PXpQSShgGWcucjhUWy3CnGZnjmwW5d0ho98lI4n1QhnQgiR4Yb9kIAIIIEXE5detG0D3L/rjnEMjZ
	fkkaFpT9C66+DJHmRWV0HLVb5VPAM+hMmLnwx0SeswKU54cvkYzRW4wf+9uPBqyhYbCjFalHXbmq0
	LdpV/rYHOUk7SCcJjzgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCbE-0007W7-97; Thu, 31 Jan 2019 13:41:48 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZO-0004fT-AM
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:11 +0000
Received: by mail-wr1-x442.google.com with SMTP id 96so3370892wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C8H9cxuoVpV+o/EPh2jcV/8Q1lf7tmeXG7dsABKpPJQ=;
 b=O8/RUD7KsWSq63NEF7YF4QVRbxNAAYhzJ9MInh1aFoEeR9KnKjgSNjDsUp2a8jCF3c
 Mpat2znwaoI8ALGlLxC06g95aRfuPjSupU7kY5wpSyKtJ8Qs7HHu+9ZV6f/Qg/+1QTkD
 Z0swP/zvqkMEE3Lqx/NA/mwt4PMEvZUdc/FcOl6UJKY6/5KfOs4A/2dI/jfcuVtQ3O1L
 FOmD1XE8pRQac+zl8ck96qwIni9ju5G0J9C6nWS6hXvm7tKOsFLykK2HCIAYnX4VX0SO
 0VYqhM5Hj3UUZLB/j1QoSAn51uzsmYeRLrVUE/4bUPMXpxZ4JeyRMb8x8hUHke46Fvsm
 ZW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C8H9cxuoVpV+o/EPh2jcV/8Q1lf7tmeXG7dsABKpPJQ=;
 b=Lxgxt64HYeyWjxXw2bpEO3ZnFiNYu462G6dACFnHUy7U3c1KyrV3MnP3AJm7CTTTiR
 2G/bDsO97D1h/Pqqf1OnJ3XIjpp7MNT+g29qar47oti3qKg9M52LzIGlIXSV4VTqkw81
 DaFNZEH2em4Fap2WF/X5m6Akpx4ZcgnisBUIhlnwP+6t3B6ZndZbqbKr+XpW55OEx+fi
 XtH8eYTgnFj/THLaqdvug4xWgUpZPgGZwAzNI4HP8P3F5i4gWzjvwM1yYyphcda0KFXq
 ZICqIoi9cXiPGYVuh5uxbLvdOSoC0hXUWG7bacIJgV8yNLUXLiUBAGRFB5UmXyzYkPlb
 nwsw==
X-Gm-Message-State: AJcUukeKw86YnUoHmSGXOjEipZpw2aD5Rx1lhTL2ORXrjFmbESbv9awz
 eiMnYHIuAPecPjE0ouvtfTX4dw==
X-Google-Smtp-Source: ALg8bN5VrZ8UZaJpfQfNa4qk9A8vu/HqtkTiKWAu3qNrzR7nrldhvcUyLZI1TKuQUO8unm5xrsumkg==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr33449692wrv.202.1548941992672; 
 Thu, 31 Jan 2019 05:39:52 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:39:52 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 09/35] ARM: davinci: aintc: drop GPL license boilerplate
Date: Thu, 31 Jan 2019 14:39:02 +0100
Message-Id: <20190131133928.17985-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_053954_848604_8E877D19 
X-CRM114-Status: GOOD (  12.33  )
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
index 2b8b653aeb98..b908b4903b9a 100644
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
