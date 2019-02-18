Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE4BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:10:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED342173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tgzN12GB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI7kUcTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED342173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FEUzzEXrtmeI8denu7feouVTuqHbQV1fQxiHj7RGpdM=; b=tgzN12GB7YfCjk
	Dsg2XqIw+s+lk7wQ/Y39pg9ThItn+20jH9BGe4LRfCFqbetIF0MsEA1sTIsn8AjYNZ6hTQ2JsaZ/y
	WrXGi6eAXSelYM3ZruYjL2+HQ4Qt6+LtwR3gPZuP9cvkzz9FmdfCaRUChew6zMpfvKhpT0TRlAq4/
	/4nwJ0eRn5gdQGUQJArTXlbNAYc+Iked1v/+96A28kN1vboxS06QmO2Uwte6e8ahtWQK6gL7jmimI
	OA8cB4CiPNt+NFYS9DMmnPkvzo3wY9GtNQy/1TieKHA42Bg7sNA0zHrw8YQvfJm7o6pawQp9Dc1Rx
	gu83zPPTXmcAfMxIUwUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfsJ-0005nG-9z; Mon, 18 Feb 2019 10:10:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfsB-0004m7-Db
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:10:09 +0000
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 791212147A;
 Mon, 18 Feb 2019 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550484602;
 bh=x2YxbIibcRpS3JCBBhmlIUFNRtqMc538gIKyPVT69z8=;
 h=From:To:Subject:Date:From;
 b=MI7kUcTne/D/wZ7869PqljelgXNrTHvJl2rCXEEB7ehtFrGr5YaMvm4k8gZGjOUk1
 prKJd1tVluksweCxNY88D6ZpEGnJlWjJ6G06CLS0aTje0i6Uafya/IqADOrQHbqq8m
 WFnrKRvpbzCW1W8JmKoEJ619X/3wYWR0yqoGeOHI=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH] clocksource: exynos_mct: Remove unused header includes
Date: Mon, 18 Feb 2019 11:09:58 +0100
Message-Id: <1550484598-1952-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_021003_485786_69ECD246 
X-CRM114-Status: UNSURE (   9.27  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The driver does not use sched.h and platform_device.h.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clocksource/exynos_mct.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..33fc4038da06 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -10,14 +10,12 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
-#include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
 #include <linux/of.h>
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
