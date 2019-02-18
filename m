Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F25C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B7D21901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rSY84+BU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="lPdVLPON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B7D21901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6CURvs88j4NM5Vi/t+9HucT9ToqFAl0ejNf2h6Grqe4=; b=rSY84+BUzuBYghtZ4BeznB5VK2
	N7h8BfzZRViElYE9JsXwOh8SZEpzZg5EkloVZvTDb6N1ssOLH8EMYg4xjj9nlDAEQeb1DGZBFSP/J
	AgH1Bq3KkwpGBoZe/vYizdVrUxaZf2MCv2ps0Ktwke0KEYg6rG79FddhSrH15qSkI8bl7sJhINhbF
	LeNviteNZREvZlVw6OvKRSv++KKVZ37M8bQle4qjgPTk58OwLiNBa2wKr09X9pPkzIC1JsXKj0+h/
	YO88tsqZTHNfpC7xWAaQSxHAUIv4QgKB9joAJLRjVWQ/dyFZG6QEtK2m1D9mcH93KPqVBEYCI0ko/
	sJl2v3eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjXY-0005ni-Ge; Mon, 18 Feb 2019 14:05:00 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjWR-0004Wr-IR
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:03:53 +0000
Received: by mail-ed1-x543.google.com with SMTP id m35so9950540ede.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 06:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kDOvI7KHRas/e++nV1MAoAVesXibxebovw6lFI3t2LQ=;
 b=lPdVLPONMX15tVFEdOGTWdO0qWE/4jq/BAze0ALMLuA0nMhYdTscqDSDouBdQJMKI+
 9P9j1Oo5wGvSlAFqwJ5MbsxrTSd68gxajlZug9ZW4tzsNll+n461GjbggeOeqUQpgDm7
 W1pyYQRMbpuwsNn1TXoxIgHxqzMBLkEm6z/Mm2OFJDHKy3mdBVweK2p66YcDrrpeiyKy
 popuvplA8CMeHuToUOieTP7qkuHWUthsRGN5rVdQwprYyfywzPhUboAT3lTaCfKDFUXD
 GZCmTGPgJsVS9ZBLdp8t6SAGMuf9SNrpjtxDkSgWKiN8DRRDgz3mzZ/37doMnbxznzr/
 OTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kDOvI7KHRas/e++nV1MAoAVesXibxebovw6lFI3t2LQ=;
 b=deSUs7/NpS/55FNgPJ7VEM64/5PkxMYgpRIZtdUqsaTYWcZVmGv/Ly+eOSJ+eX3U8B
 YPd915IjeHyI9H7UZpAFeAu6+ZuoHVFC2ZkqHpT5FUiIm6Pp1+nwlbJSG9tNUEqX6b4+
 jfpNHzoqILB6qakaWNyvkc0qPIOPDRexFQCRAfJRpXhcym9ACODvOw9ftGnxUdFB2G7g
 6SmdkoEN8wg//JE7lAZL9IIo9hsP6fqDX8C8dLrnYRaDKyYsL2jQ2/Mgy80KVRy6v2eI
 ArFONSNJ90bU3sJA1phrpckP6XL1Q9EpDAsCwj1IyVHV6VzJ1OtFdO47taNNI+/xCnX0
 W4IA==
X-Gm-Message-State: AHQUAubOPOVKI+m8e0+2+IghEcnWSQ4EitiAiHl0VngRa2ZisvJe9k3S
 n5788mGFjtK5iqnlr6+Sw7lBag==
X-Google-Smtp-Source: AHgI3IZ8OLgKjAeX/g4O2478yycvuHIzPgfc0uD5abEOkLT1aY3Iky8/UzyD7nuf/AReqmoOjyDzEw==
X-Received: by 2002:a17:906:791:: with SMTP id
 l17mr13001446ejc.1.1550498630266; 
 Mon, 18 Feb 2019 06:03:50 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:03:49 -0800 (PST)
From: Patrick Havelange <patrick.havelange@essensium.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] drivers/clocksource: timer-fsl-ftm: use common header for
 FlexTimer #defines
Date: Mon, 18 Feb 2019 15:03:16 +0100
Message-Id: <20190218140321.19166-3-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_060351_603740_08822C15 
X-CRM114-Status: GOOD (  11.91  )
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
Cc: Patrick Havelange <patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 drivers/clocksource/timer-fsl-ftm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
index 846d18daf893..e1c34b2f53a5 100644
--- a/drivers/clocksource/timer-fsl-ftm.c
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -19,20 +19,9 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
+#include <linux/fsl/ftm.h>
 
-#define FTM_SC		0x00
-#define FTM_SC_CLK_SHIFT	3
-#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
-#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-#define FTM_SC_TOIE	BIT(6)
-#define FTM_SC_TOF	BIT(7)
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-#define FTM_CNTIN	0x4C
-
-#define FTM_PS_MAX	7
+#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_MASK_SHIFT)
 
 struct ftm_clock_device {
 	void __iomem *clksrc_base;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
