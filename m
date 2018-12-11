Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B413AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:13:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EA520811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L7N7H2nN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikWCdNU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EA520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9DYImP9d7Jpb/fXH+gboQXmXNYQF0LpbmhKenly9PNo=; b=L7N7H2nN/DjtIl
	8VEBIJIYSF/3TGeusxm7xKA6j1jTYKQfLN2Z/W4BPlvg5EsqYw65SE6Qn6RxYLPq30Tn4mB78TKQE
	J8RQtMmVnv7FGTWEqlpzluOPdDDyLPLMX/maIND5h0GottVwJpAmJ104wJQRVyGuHQCoqimQhbF9c
	qqvZnpy8PWGe4W9lh4B5wofx8bNoPqRj9/EW1IqO292FFLaD+ZhGA+ajII00QFCfVuQfJfY46z1P1
	pq1bIysZTt4VH8RfdkwuNtPNcugqNR9305O1w2DG/dYenMygwRBHngYZTzJyup42GTPkODEcZR3zP
	285qs82b4h8Dj121xJhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWdAT-00081N-IN; Tue, 11 Dec 2018 08:13:25 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWd5Z-0004gk-DU
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 08:08:24 +0000
Received: by mail-lj1-x242.google.com with SMTP id k19-v6so12066745lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 00:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WrfjeVHZmNGYgF8NI7mXmKd0jYmieaU+fE1eNbpV+CA=;
 b=ikWCdNU80TCwkfjjNRgtSpWV1l5H96ecG0i/RN5lZFvwBDFvhRJMnmrudjC0trMfpr
 +MaJAK6oYJESrkRGqfDwJLchd36Sm3EkfBqDR1VhvnpZYcJdF/Bfxux5J4E74Ap5vjXJ
 jlgrBQ+i2PxEMxGPqfr+rnqD7LfGiIfWMQc00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WrfjeVHZmNGYgF8NI7mXmKd0jYmieaU+fE1eNbpV+CA=;
 b=Iiov+hkRAf1LEFFQZFy1KJ9AtVg+31F+xO7LtB9XlArwOWzrsOSN/3auARonA1F2Pe
 bWvwjbL1ZhqzjITE/JM/UauG2T4m1FsBZdFVnBuA1zojTKuflWwb+sBx+8jvQExjkhTX
 6vlqBeaP9eBW80DtDBsjefPLcs7VNPQ5f6CZnEDJoWLnAirDpFeFYazCudq1QeXsI3q4
 D9L3/34esiGU4uqpQVg/2Qh8hE2eO+Hi878fU4xjnPjfZQyHu1399UzBcdAGtSge6bz4
 pygLkD4G81iwlK56UfnxdU9g1F9YnJtpYx2xbgbvQxIRyMjQArSBxdwAlPKw/cjwtm1k
 OhoA==
X-Gm-Message-State: AA+aEWY8cLkimNZA4DoyHehrwkpNMhcE9i7GraAHGPCc2bF2PSMjtDG8
 Lq8yCXx8a0xueiPlz5u4438lUQ==
X-Google-Smtp-Source: AFSGD/U4s5f2BX+HNbcfu9mqermVkJWeqzKAdnBPqAjtHcpLJ6yn17wsU2Wuna6lDIotVi91Yco9eQ==
X-Received: by 2002:a2e:6594:: with SMTP id
 e20-v6mr9885207ljf.123.1544515694006; 
 Tue, 11 Dec 2018 00:08:14 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id l21-v6sm2524424lji.6.2018.12.11.00.08.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 00:08:12 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/5] ARM: actions: Set possible CPUs from ncores
Date: Tue, 11 Dec 2018 09:07:58 +0100
Message-Id: <20181211080759.3150-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211080759.3150-1-linus.walleij@linaro.org>
References: <20181211080759.3150-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_000821_738500_A1504FBB 
X-CRM114-Status: GOOD (  13.47  )
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

The codes figured out how many cores the SCU is reporting
so let's say that these CPUs are usable.

Possibly this code is redundant to the device tree parsing
code looping over the CPUs in arch/arm/kernel/devtree.c
but most other platform do this and it looks coherent.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-actions/platsmp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index b66a768afedd..26ddc12ea4a7 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -111,6 +111,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 	static void __iomem *scu_base_addr;
 	struct device_node *node;
 	static int ncores;
+	int i;
 
 	node = of_find_compatible_node(NULL, NULL, "actions,s500-timer");
 	if (!node) {
@@ -162,6 +163,11 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 		pr_debug("%s: ncores %d\n", __func__, ncores);
 
 		scu_enable(scu_base_addr);
+
+		for (i = 0; i < ncores; i++)
+			set_cpu_possible(i, true);
+
+		iounmap(scu_base_addr);
 	}
 }
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
