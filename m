Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D2AC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:37:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F8A218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r4oBBCO+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AXEDg7Kk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F8A218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XlsvPdGFXw8axIRDKfZayiEOdhjdtjQ81cM1R3tj7Ig=; b=r4oBBCO+uwLiRO
	pcXX/K3CMcsrsTniZkVFGa4QsCDA0641F+IBrCF0AW8RhPa2ALuhC5fFUGmrPOOzUMGfQTS7ymQeh
	vMHFec6RkAKB7qVlpkn0q4mbqLpE9iongzHEGLxmG0Ft8PgY23V6tWdKRkUHXy48m/DYUWrkghL42
	/PvF0T/sNbGqOZDeJiFxaN5Ola5Tw/veTeV/NWToBY6dSav0+O6jsgcuW9US21vphIgJAW5WH/aOv
	H0AEy3NuWZa98dmfCQuoHtRiUQtzdVYSgecgf1CcF9uylYc2XvOeh9QYy2OzhZkDEjK7VI7IvfMq/
	iiHHStgTsQ+VIjq8l4iQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtApP-0000D9-Gb; Mon, 11 Feb 2019 12:36:51 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfK-0007K2-1F
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:33 +0000
Received: by mail-wm1-x342.google.com with SMTP id r17so17359728wmh.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EVbb/kmDGnz2R06A9Y+sRzR+uJXik+IbWekFAYRY3NY=;
 b=AXEDg7KklUenWcoBF2Tt9JIwcxAg0z5HlJa0TWbNeQNwbacsdqkwMeXuuyqsCOc7Ms
 IMPLR+O3M1KC/1RqnWOSCspIfZeNAXxmm5Rn6HmWUybW9Pretx6s1cJgfp0cTotrZQPD
 LCFoVwW52YTdE28yKm/wZmu+ogrYs0RlqYtR737s4i0Vg+DjnfjU+Xqf2iSYzYFiwci8
 SENRBCAilwDZnPHWJxaFPJgJg9r495z9T89oxc8scpgP7vEiVEquLXUu00rBNbv9k2eM
 6zYLgCT4BuqtUofPvva7KxVeWC/H9GPzhgwcN1V7BvMwzcx7nnppoF4jAWbseXbv4pEw
 V33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EVbb/kmDGnz2R06A9Y+sRzR+uJXik+IbWekFAYRY3NY=;
 b=CUN5PFjt/Pl4IAzEkp75HN+e5yphYiajeWOtW1MU9aP1WsmcyCMN81BtAr7AYYoKLO
 nD6qR8xLHDAyCQHMRUlwpLuLguCZUnBNvq81zBUFC0MF5g2Cnhe2g7dcwU0D6+5KSOmb
 BvY0nCYNFk4q0GMJiupQ2tt9I/45nVl48T6QpEqnLCuMv6saMAqgm5JEZ9Ti3p0/LLhR
 LJeAli6GPSXPdQ7xMTUbgWvVFDRSXmMigmXuL9+j5Ry4t18IEogK6/FRTUFFLL8iCqCL
 YqzgbwDNi81Y7X60Dg8pamZ0DTv9sHz3fC27Z6o0K+JF2Y9SnX3zK9nrqu1u3ohoZSJW
 pPIQ==
X-Gm-Message-State: AHQUAuZ5nak7W+NN9P3B/Z2OtXQOLyyZ5eLdekiWrFLqerrw78f6iHyy
 AuBmHmHcPUxIVnk9kYp+0R7ikw==
X-Google-Smtp-Source: AHgI3Ib/DPvgBo2reENCghlhxMh3WiDOjeD7oK6R0Li2KY+cahwbev0DMRk1xiQehHjSAv5CAD6R3g==
X-Received: by 2002:a1c:7dd6:: with SMTP id y205mr8674098wmc.121.1549887984740; 
 Mon, 11 Feb 2019 04:26:24 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:24 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 09/33] ARM: davinci: aintc: drop GPL license
 boilerplate
Date: Mon, 11 Feb 2019 13:25:42 +0100
Message-Id: <20190211122606.8662-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042626_679527_8AF0522E 
X-CRM114-Status: GOOD (  12.78  )
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
index 88c30759d1c5..1301adc569e2 100644
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
