Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D8EC10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D2B2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YsA0/h1r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fo7WDiek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D2B2229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DrEbh/e73lLkl0shP2BpyMhcUiQQqRAsY6qmQo1rQUw=; b=YsA0/h1r9ajlZe
	M2gycYT2H2YTS9fv6Z/zs/o4gWXxw6kec3ICi1YS57Nn5O8HWyUTeoAYiMALDRRN1lRfcAcNc4h+X
	9BvWGIahQ2/nXQ3vJ6fhFw4eSLqTlKI0kWRyvc5q/3Ln1IMrcwsA/sce2cYmSzCLep+daMXF1Qrtn
	gJ+uU5rIzAY0zmyKOIYAIXGIxOh/Vx9ty+g5gLKml6OQ3rrWn1cqt5RU5NktPspFzuX/nmCWuXVbj
	iBPR7RiMZiAvICgAvnptUrqQKpYNwDVGwhU0UDUq3p2xBpma291T6kpv0gOaN3Sot/olKW6MD8p7V
	wQQH9AyONNZziDy2bjtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIQw-0001PR-2S; Thu, 14 Feb 2019 14:56:14 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINk-0004yQ-5R
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:52:59 +0000
Received: by mail-wm1-x341.google.com with SMTP id x7so6563426wmj.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KqCZkQam34X7Bd200BUIwd7m0iyaXsOBKajs3xqc3eI=;
 b=fo7WDiekD7IpoHzdaa0atbQ/BSibpvghz63JMbYbaE6BdRtzwBaBFYCIRdJ8PcBDar
 OuqfQB3Q4zCkJXWLjJHfdciJ4rtO5INFK+BJWSMG11UBJmCdv18mpPtrff70GrbmQjZT
 uzaIJHIUPNef5+YF9Es+4daF3zzM5qV8DiWO6T8S0XFoAKM1mJEBrhQW4AqFhzPVXxUc
 WpYVgBDEl3s6dO+fYBfEwzEJbD4NGjE7PvDB9vm1oypjRE0kupcg94XyN8wiDs7esBDa
 TC5wdIcgPQcziqEYRs5pMOfi3uTZPcsQdSn5oBYimSgFcVP3Q8rPxOfS3l2Hx8Y4cP3Q
 Obgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KqCZkQam34X7Bd200BUIwd7m0iyaXsOBKajs3xqc3eI=;
 b=CCPXRV8E+F8fiq++PW6R1hqUlZZZMdcWm+w4Et1TGn5UKRfoSFBW7/ATTHGjhRMu6Y
 b9Vv6PQJC5gcW5cPHmMHVDbsA4lWG6OC+gMWPBwPBLildv1VS++MbO57Rf+fx7LPF+6k
 aqQ9cH4GNdufYIo2Bqi7unOjaSN5joJ8fQ/4hH8W+19cMei1J8M9BQbUlcx+VF3Qj9lm
 tftv9zYZbXm/m9VeHOYe+IZpR59S1/lfT6MGP8FHH+XFv9tScEEcV/YuRWf8HHdK2b9q
 5DfUkkfATWF1JPehCNQV6GwSG6vJJXNB7oqiIs+ZZ6MAm5SV1RkWyX3EttvBRnaQWr/8
 Rf6A==
X-Gm-Message-State: AHQUAua5wrJ+H4fVJmsA6zxcXuUPZmGM8kVNGd/29mOv+a0hGp5rDrEE
 7AurTmaKiT8QhVGVYK5FQZaU/Q==
X-Google-Smtp-Source: AHgI3IYESV50SAOR0AHkCFB8svKvmHkqSd9N+lmUd2L3OrHls9MpA/SDQjrgo6rLPXZtFq1j4+gr1w==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr2930963wmh.86.1550155974782; 
 Thu, 14 Feb 2019 06:52:54 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:52:54 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 10/37] ARM: davinci: aintc: drop GPL license boilerplate
Date: Thu, 14 Feb 2019 15:52:04 +0100
Message-Id: <20190214145231.8750-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065256_439999_D1F4A9FC 
X-CRM114-Status: GOOD (  12.72  )
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
