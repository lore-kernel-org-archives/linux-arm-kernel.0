Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB4C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:13:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E57E20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cfGuy2ky";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKpEujbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E57E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NIWIiEedAbMVmB0tCKYweCshgyxc2QkH4OjrIGddf70=; b=cfGuy2kyYkmRlJ
	tWJA3KtmmE6xSzdvp4LdD1+QSFxoq4Gf1hp7/YQgqkZCA7+Vz77ri7po1LCUBVbqGXHc1+H2CB7+l
	SZPgdXdiwFjq5UOh8JBf11MdLTihEUpY/1bm5F4l6nTFeg0paltbpCWgeiKvA9xG9Q6anNk0NRL3E
	ku/1i2thSk+zLhLVrQ63u+ewjMpXXz2WTkHm9Ff4M4d87s7Ecn8kuz8F84AO3gIAmFxVh6eFNUv7o
	XbS98v2VDjIUwiSgifRj1iyKn4vXeeJsEXPtQyuUzb1YflcLo1eI7K8xe2m73tHwcypvRurPD75Do
	0TpItuvD/dAOUJAO45jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWdAU-00081v-Ox; Tue, 11 Dec 2018 08:13:26 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWd5Z-0004gf-DJ
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 08:08:29 +0000
Received: by mail-lj1-x242.google.com with SMTP id c19-v6so12111694lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 00:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+JAsYnyln2VqLSTi3KozM4OurCoIR6/by4/iWzllSMA=;
 b=TKpEujbt6VYSujJsnebtzwQ4zM7k7IGPdSHpPMbnbuLxU+/tpTTIJPynp3NS37XwE8
 cbcVo3BcJeiCPaBqfh6Fmkh6mxHDgY1mJdqShVtUbx15B0ZyL0k1s4/tOiTFL3QTdWcr
 6eQ+X0nRU1FEfL73upGZiZP+cMw8zay4Kh/M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+JAsYnyln2VqLSTi3KozM4OurCoIR6/by4/iWzllSMA=;
 b=KJ3fiIcHo3OUGYSKVCDhXBc68RHla3VsVkfpIX5lKcDzVjm8owOtchZvO5Z7JUrV7v
 2iEjL3xOrARBTY8GS5I/87vr7JZWB7X75V59ZHQ0aGHCjT9bO5yVWT5dDvQ7ceeEvsJs
 YTHMZQ99WAnew7JnMnDlCHK8WvX60qbcXw4SL2OpcU+V4ziU52Vx1eCbm+4+n+Mlipng
 TkN1D5SgxLJXmZLKAP6uE1t+u6A6dcMKz3poRkvVeOvCbi8M/8qbN2ZQEWVgdVkvh2y/
 smqnOZ2e0la22K7BkpSKFvuaWqOzmuva2f3KfCoMsYXOu/VKcK/4myqjbJrB93iUKy0C
 UbTQ==
X-Gm-Message-State: AA+aEWayk7MfSwOxJNj4+mf/LYazBbVEGxE6antCVb8e82vU0BVQJYO3
 kK3dOUSZTo+vDBJ0itf7EL6DQA==
X-Google-Smtp-Source: AFSGD/WUdPt4x4pBKELpHpPR9Iq4hFWa5yswmhep3LY1uVwDFUSf+5Ft+hutl4k/vNmzhv4sdlMrqg==
X-Received: by 2002:a2e:92:: with SMTP id
 e18-v6mr10043949lji.130.1544515689355; 
 Tue, 11 Dec 2018 00:08:09 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id l21-v6sm2524424lji.6.2018.12.11.00.08.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 00:08:07 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/5] ARM: actions: Localize some variables
Date: Tue, 11 Dec 2018 09:07:56 +0100
Message-Id: <20181211080759.3150-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211080759.3150-1-linus.walleij@linaro.org>
References: <20181211080759.3150-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_000821_761183_7AE60F10 
X-CRM114-Status: GOOD (  12.23  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The ncores and scu_base_addr variables are only used
inside s500_smp_prepare_cpus() so no need to have them
static local.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-actions/platsmp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 02d17ed0ca31..98fbcaa764a5 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -34,11 +34,8 @@
 #define OWL_SPS_PG_CTL_ACK_CPU2	BIT(21)
 #define OWL_SPS_PG_CTL_ACK_CPU3	BIT(22)
 
-static void __iomem *scu_base_addr;
 static void __iomem *sps_base_addr;
 static void __iomem *timer_base_addr;
-static int ncores;
-
 static DEFINE_SPINLOCK(boot_lock);
 
 void owl_secondary_startup(void);
@@ -113,7 +110,9 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 {
+	static void __iomem *scu_base_addr;
 	struct device_node *node;
+	static int ncores;
 
 	node = of_find_compatible_node(NULL, NULL, "actions,s500-timer");
 	if (!node) {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
