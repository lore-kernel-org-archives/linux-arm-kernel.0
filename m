Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748BEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:24:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449AE206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EtP5mcaf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv7C30Ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449AE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/xtnLJOmLSRzlKNwi4yCwLh9RirEtqpxI2NVDgW/ovY=; b=EtP5mcafDkvX3Qg5kpoDbhqL7f
	i9gw4LzjYk18RCxmb8sifjJDlMpFWqM1CSwf192ZjKhGGlu6hCnCxAVzi+cJsSqgZk8ClykY50/oV
	wbcDwMOXgZui84H7hfwbp8uZyrIrMcBaDu+7woYwKuHyTbmiU6Q02zlzyKGIvmBZiii9lw5Aw1lqS
	1SXWUTu+WKXwgfGbJClLjA4lRKjkD6g1SWei3CAaQrdjw+l/CTITNMOdI1BnvvOFp+a7VP3qDxWOd
	uu2M5UVzt2hza1d9l6JV1oY3JyHGcgjSuoemLPrNLreyL69Uo9zmgteoskCl8ymVEEcdHe2Jna0XV
	uVF0IKrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvPF4-0003N0-88; Sun, 17 Feb 2019 16:24:34 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvPEN-0002aF-0V
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 16:23:59 +0000
Received: by mail-pl1-x643.google.com with SMTP id r14so7480332pls.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 08:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TmLBhkcwf93Bo4/fPKHDPdkbWpR65IQ7m7Ea6pG7oSE=;
 b=lv7C30IaiATp0u5N16KjreOaS2GcPSSYdyWlSvAY+yYDY0gFvHcS9MSRU5W+7pbHaQ
 vOVpYgfkeMGo4n2WCfVAaqcMtYeSIiiykov4/aITxWy31kc0cvVTGl2VEE1+h1M71k72
 Gkajh+LDUbL/xpEB+gnghnTprn3v/ccxe4XIKhjpYYQJRPt0h8toyL11kKeA34+bDnum
 52wL4AibfdBlpgo+8jn/jDF8L6xQskiJywOsuuvJNIUs/5g6cA8eaXXFmRAA5BM8h1nW
 aco/sZ5zQYzdqh1o1pWqO/ZcMs29yGBy4hmzjXxzqQ0pD4Wt4TrtDtihcAtZPaVpc8mv
 T0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TmLBhkcwf93Bo4/fPKHDPdkbWpR65IQ7m7Ea6pG7oSE=;
 b=m1nvpCEhzUDY2forP/I8wi0S+bS7twVtokkgtETEyzoShlkLavhz+0HoxnahZ7BwYW
 dRYsidvpSkiaOL8m6nXk37KuuRJ93atuNHJdt/TCQgNmBa0V0RvsXdacEeXuIyoAPyba
 dzBOHjzIvmvkvMs39OnSrwEWCMbWts4IcT9ZbE9l9GWfxlA/fUwxroR7WU9ppz8Q6KuV
 Zh+/p6pqdSaf1l+XuPOX+j095N1RrmaqN+jBUoBvt9J/uvLWpCF582+RupDw44UZAspr
 PUoGVjeQ5vbwASfA32aeIwVxpdkDLoSdFFdUuJYCoJ3SPd7M9MGbmw12cQzSTXnblnVm
 jMwg==
X-Gm-Message-State: AHQUAuaXttbALlYWwWcAH/0ixtxCq+b5988kXQDED3fachFLogbJVQbw
 wmHSp9QSJAJm38PHI5t7WwiL9pkd9ec=
X-Google-Smtp-Source: AHgI3Ibsn22Xygm1ibYW5QODahFc//NMQiQJ1c5JMNPNaSKAUDCDzxZXG3dWNqGc3/QgAlru5bkYvg==
X-Received: by 2002:a17:902:2468:: with SMTP id
 m37mr20776467plg.314.1550420630579; 
 Sun, 17 Feb 2019 08:23:50 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id q21sm32884737pfq.138.2019.02.17.08.23.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 Feb 2019 08:23:49 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: srinivas.kandagatla@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 maxime.ripard@bootlin.com, wens@csie.org
Subject: [PATCH 5/5] nvmem: sunxi-sid: convert to SPDX license tags
Date: Sun, 17 Feb 2019 11:23:16 -0500
Message-Id: <20190217162316.14111-6-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190217162316.14111-1-tiny.windzz@gmail.com>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_082351_830774_F744E661 
X-CRM114-Status: GOOD (  13.27  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Updates license to use SPDX-License-Identifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/sunxi_sid.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 8692b58d76ce..f56c9f713cb4 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Allwinner sunXi SoCs Security ID support.
  *
  * Copyright (c) 2013 Oliver Schinagl <oliver@schinagl.nl>
  * Copyright (C) 2014 Maxime Ripard <maxime.ripard@free-electrons.com>
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
  */
 
 #include <linux/device.h>
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
