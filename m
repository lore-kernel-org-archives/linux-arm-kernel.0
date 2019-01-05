Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3AEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:09:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDCD218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XjLNZC/i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1Kkj59+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDCD218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4AH9vYbKAWpJwRcFcF5OwKKvAHfymOm8HVs5X4gBrHg=; b=XjLNZC/iiCXaTz
	2tBdDFVJtfz57OJ357yc8qgX00gDAoTld7CKFB6Rq4JZAXoSsxSXm8XE4HrRIWnsiK7/SRzYICCGc
	UgpkeBCKoLK4naFCsgWVvn/Z+1WO/yh8I8gMeKnpIE1wPPouWpwJ/H9n224F5icgVsOoitCT2E9Y1
	y0Y5KcPeZuOy7RroOc0rskZlxSMTGDQO46d9A6EXd4UGYCcyIFHX3lhp38d89BfGWkPKJ41UwriDl
	KWd9z6LFjEkrpEfnmJUzkigJu2ffmWp2ZMnyFT3djGBrpLahH9VmSduXizEaOuj+bcfGWTIsKISIH
	EYJduH8qutOx3OgexkEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfeD3-00015n-TC; Sat, 05 Jan 2019 05:09:21 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfeCy-00014U-Q4; Sat, 05 Jan 2019 05:09:18 +0000
Received: by mail-pg1-x543.google.com with SMTP id z11so18346124pgu.0;
 Fri, 04 Jan 2019 21:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=MNMzRwNChS0yPDlWA2Dlmnwr40HNg0+jMjhl1JKiHgY=;
 b=f1Kkj59+ln9J3nnrnqDXLOv+nIHmnhOvjscxdvptJpwNzuosYtcF1SPdJ1CjiQHzZP
 oKcd9xjJRtsfDmfLHRekkheRITg3E0l3OaBoFLrcvqER06frNRcp04xUia7VsmR3tB51
 T+8jZdN2Vu+HpLCD+N/nsynS5EC5KoQA7M7b31cR88Y3JB6eqYpSqWxjvKKilMzpTftI
 EuQpES2BQvLjh7KS6W3Q+dpnos70vcEMZUOy+CbOTNvzUmxnZOBWqjbSG6pS/RYNvg6u
 v/Cn1Cx15e4xfWT/N0KjoqNUZaf9HUiSmtUbmK9OViMAmuaRWPQF/woilVe0QrVjn2mB
 c4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=MNMzRwNChS0yPDlWA2Dlmnwr40HNg0+jMjhl1JKiHgY=;
 b=G9jKqq+ZKFMjVTyOAy5TMKNmYxZGMgQ01uGlbnnzqCX8xSJCFqspgKeT9cdIErNx0u
 tWvlPW9dTUxw7NAGICd67rlplxO98HENrD5Q7sUrqeF0LouLrbnb8Q+giPnZoX5XWDrV
 rG12+g1B9YFBHG6m4lkatP1wynL5P9N+QGJwSJunh0ln1mYaDhAHZ/U4wAI4P1aQ0vHy
 4PhJpO+5IDbmkiPQaF6XyD74rQflXsJKy0bjdg/otyFYwTEk+LjS3KN/k75kkgGrpJ/R
 MHlA/0C/8WfIZEGP6vMi18gx3Q4F2uvgVm5aSZu2l6m/zr2SGUKGn7wG+8wCCtMV1Qwx
 DyHg==
X-Gm-Message-State: AJcUukcHGHEb77gZQvm8C2VDYfEMLIF4c60+gX+qQl8Os64aYAsZpcvK
 REvXtDiLcu/NHbPapZ145KU=
X-Google-Smtp-Source: ALg8bN40RhT3ULq0Y9oDhTYS8FDRUSP+rbNeBKpWvQ1pNG1VajMUFqyKlNuZo1/pnz4nKbg6K3mtPg==
X-Received: by 2002:a65:5c02:: with SMTP id u2mr3856226pgr.13.1546664953278;
 Fri, 04 Jan 2019 21:09:13 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([47.11.225.208])
 by smtp.gmail.com with ESMTPSA id m11sm77147259pgh.51.2019.01.04.21.09.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 21:09:12 -0800 (PST)
Date: Sat, 5 Jan 2019 10:39:07 +0530
From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
To: dmitry.torokhov@gmail.com, matthias.bgg@gmail.com, lee.jones@linaro.org,
 chen.zhong@mediatek.com
Subject: [PATCH] keyboard/mtk-pmic-keys.c: Remove duplicate header
Message-ID: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_210916_860768_674D1BB5 
X-CRM114-Status: UNSURE (   8.38  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 jrdr.linux@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-input@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove linux/kernel.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 02c67a1749fc..5027ebb7b4e8 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -19,7 +19,6 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
