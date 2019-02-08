Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82CBC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C9D217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dmwbhQHH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Xd4FqMO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C9D217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XlsvPdGFXw8axIRDKfZayiEOdhjdtjQ81cM1R3tj7Ig=; b=dmwbhQHHkKKNKx
	ePyaBmGZgsorOZDGLkUh4Hx8P73oEvh5wRBlF1UlLpEShUPHFyHC3qj/2AKwiMVoOw55HQ3w4HTr6
	nnXFL84el1PwcTGRdybL6P1LwVZff7lD1ZIdR2qh0VyS4L/azbWbqa4n0ah0KSjfJwzAyoKIZhQOe
	+qGUiAyp8COyjLnBcZ8UeVeyamBfnCIBgo+tkP4orPBjizkRYZP/IZol6ZMm2PQGu5ZbKEL44UnW8
	5WaVf5dX5ICB1MZGJxb1o5g52Gu8oV/aijB+0pKWv/eDxNxVwXANIW/fBmkeFKPRMhMqOkHJvXSle
	N9T1GZeawMDm1VbAw4JQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA6W-0001dJ-OA; Fri, 08 Feb 2019 17:38:20 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3a-00079j-KS
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:26 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so4364503wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EVbb/kmDGnz2R06A9Y+sRzR+uJXik+IbWekFAYRY3NY=;
 b=Xd4FqMO9I6790JqPr79qSiqhSgCtZHQ1J58BNZs0T74nySxs2q+HXWouHipBL2wWKZ
 2YzZj0CD9aaoze2laS5JYLbbBCzfvokXAXHjlp454uKIgGCP4N77BWyP+ADjpro/VpEA
 F2nbwFdX76a4FDyzV9xO1GXEtX51noqw+Eck0sp4RTajjDExJiZ+CguPtidHATXrwsrR
 VLP3ujtFLNHGfhT2r6NTDJaqSpma6l5MOFP/jHOU9oCbpxZu0O2M9wYRUGhKpEMuOkWm
 o2j0tCkYmW6JKvBbEqsY08bE30J1FR+50rugCUJECd2H2sbB61C/4k3ODgntqPrcKsnK
 tzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EVbb/kmDGnz2R06A9Y+sRzR+uJXik+IbWekFAYRY3NY=;
 b=Zgq29XWRavQrtxpFogmqiHNEILkHVOjOlQdVevBjb2UDCpmewa1chg6pg/sulqHWOz
 ovMxAHp1dd1qESJKghirbtWXK3KLMg3I/HOnGQvFVSdA9coU8GmGOChL1Y/tdOXvn/S2
 v5ogB8kPmRGr4D0OJ4oHNO98ohtO8suE8VvvatQ/0/W0Gnnb6DILDgG2oUEMWn2Pvi/B
 U8u0FhSx6yWdiWBAZP7h3oMslgvKyVBUhwE77FACx+JIoZYJbQfjuU2qfmL4RQdTlXlI
 PaO29sZkAHOult1lJ0Kz5Xq1XylRF00Fcz+tKCxZUo8/8rvoU9OGZnH0h/hue7ynfhYF
 oAQQ==
X-Gm-Message-State: AHQUAuZUASGadLtVJb2c0mPdd7nMSQulrsokX1deOk7k05d7zOQwAELq
 7OrIE8UI24PoiUo7w5bButcfJg==
X-Google-Smtp-Source: AHgI3IaI0pnsdQtq6MqG/GmPvD6gDbPnXpMBFVIAGhp/O8zIeiMvo7WGh6h+OvsMvrtJ9on0JuoT2w==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr16665956wrp.80.1549647317160; 
 Fri, 08 Feb 2019 09:35:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 09/33] ARM: davinci: aintc: drop GPL license boilerplate
Date: Fri,  8 Feb 2019 18:34:34 +0100
Message-Id: <20190208173458.4801-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093519_208009_7790E803 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
