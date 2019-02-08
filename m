Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7A4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD572146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DLUiypuG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bJ0zy4k9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="y4N1WMiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD572146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZBEGcOfyTcfn/cJ2nLalyaZOtHNyXNGmracQVMM74Z0=; b=DLUiypuGDKE2jL
	j7saqTRBfBkJMdBos6vjTJxNka4rDM5FrjLuBdFk+NlM0FP1KkiYBhMfHhr3PlT8cuU+XYlKgBsjR
	O0llCUdXszz2OrfNcEt8wWw0jKmtRDWK5OzmOPTs3CSHUKR6VM1teNMZ4ic6iGtQiXK/hwnsewIbe
	57MafREdP8GIiiWTSPqtjYZVmb0d2lzc3yeHN2aBdX2tjUdg37ehlQnezKPwVn2SzFQpJINSNcY/h
	PgBcvtaqBXmwtCvFKOJTddoGIkLw8C7I9kRMo+T6z7xKBnCfHXkQharuGHZxsBkcdqA0+uZmzOZdi
	Pffdl/+ULrA5ms6FDb2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA6u-0001zN-6Y; Fri, 08 Feb 2019 17:38:44 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA47-0007pG-HO
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 17:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DCvcInryiKJ5GrPJy1j5iG1WoHmXy8a7aJkXnmpsZFc=; b=bJ0zy4k9Pi77t2ap95tvSJXsVj
 jQLrHZMlfwXqDBOFiBwBnQyKopg4fUAVoTfG7pmErM9OZTdEI+6SVFwN/HZYpN17QBVWhkiLYdEtG
 dtDLVzq9Y1lvVqojzKjMIpKRc/6tCbvw0DLPTt2yquph3cGE7UiCEHVTCr9XxYMbZG4pkQ8hYZSA6
 sDgOgvoFZiP4i3l+pkBNIAwFptN7JqcLhcKkbf4rMqrvxslTDgd7sK+fZseTWXDohCZg1KxrwB7D1
 NTxAe8pDK5K5D92yrcV7u7FNwxEK47e3RY6XiWVNX6QgN+lMLEbpm8jHH2H4FZ3ujuudBaeot4K1/
 LyOgs+Kw==;
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3z-0005sA-Tc
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:50 +0000
Received: by mail-wm1-x343.google.com with SMTP id f16so4305106wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DCvcInryiKJ5GrPJy1j5iG1WoHmXy8a7aJkXnmpsZFc=;
 b=y4N1WMiLVk4c5d1EH/eZBPxa1swvSZh6hsrRHejgMW/Ko4MWV0Kdm7JVpTJlp2McBz
 yY2zewtIRFF/IPHNLMs1HtFG9cQsPQ2jV77ncrQOmfuGr1pQ+gpt8g8nHXHd8uUDnCkq
 0LaBNxr1ySH4nOPtF/KADGhob5HRqItJFbLfmG3gk4+bsytvaWwV2WcHeHL7qqwTAjLm
 RecOGFo9KtVvp3qg7gnmWAMDpNdsBS2R1N7k10FZwuB4FACzpWeaW7dKibjnO3erxEzo
 7FVGY7qbbppf0b5sw0hKg1v2w3cvg2KAFuqBbXehZ6S/YQlG5sKFhr94EUy2+xSI3LWR
 Fbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DCvcInryiKJ5GrPJy1j5iG1WoHmXy8a7aJkXnmpsZFc=;
 b=qFgpyLZfToNMv+qT6djPmDQWNVYQzDn15niNB5k9iGwEghoody0KAfUKucuvAER5hq
 S7suPuJro8n/R7XK8QxnaEPJyxKKLyLbemAPcCcioCj1W3s2SmBHEXzYVeYg2vIjEkDk
 B2LIJYIJyr+zmc8KL+GSHxlSKhO4q1V4QumkZRr3AxKZ3HJIPs0dUHm+5aaY33DuH4sZ
 yYM5XEefUu7J/wG9QjBuKISemHaZNQthLgY2MzQltve/EIwczZKbYIH4kX7TJKJZ6ixh
 AUX27OhUJnKtFLf9TONfJO2CCfG2hbZO+5OFbLzCdJ8cCnYcGYlyb/nKPXL58pGRVoDb
 5azw==
X-Gm-Message-State: AHQUAuYRir721ucAKSL3t2cXuNaovoKg2V79JDULo8svJd9DhH4Ag730
 DJkLZ1qiFxJ4ZRPeQ3zU0i+/XA==
X-Google-Smtp-Source: AHgI3IYsyQq0D/k2rzm+qjhpLW0sohd3DtivCeCHVbXGyN2yLySwVSdqTwIwvhSLHCJD7F9Dm/0w6w==
X-Received: by 2002:a5d:6244:: with SMTP id m4mr16924387wrv.314.1549647342125; 
 Fri, 08 Feb 2019 09:35:42 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:41 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 30/33] ARM: davinci: cp-intc: drop GPL license boilerplate
Date: Fri,  8 Feb 2019 18:34:55 +0100
Message-Id: <20190208173458.4801-31-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_123543_992727_3A85FC51 
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
