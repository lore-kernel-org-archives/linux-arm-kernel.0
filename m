Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611E5C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA122077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c35sNUQU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8+KBjQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA122077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gG7mJYauJTsz2rOJUaTYAv2PsG1tEEvtMyZ7v/Mwi4g=; b=c35sNUQUtHu3Fp
	fx/u0Dm3sB/wHy9KcJ5UFyA5lu3YSKIVLSm4wU0rz6tmD046U+x7Chu/24CfFeN2fQRAhOFz4fL/Q
	e2eNNaJBEMLc45EINJqcVMCHJeSgX+MFv5D/1m3ix99HHVYcdMOmrr8eEipCoT5id5yYyNUIyMydK
	QK52cmkdMTFcRzogpqCvXq7vmnX1m3n8ZK7Bw62WIW8YysAt/CTCOiEs7dT1t7OUZPZhQE8bqCLf9
	qG3Gyw/t0vOw1cmRdMLiJQfAfWHt/4K8P9Jxe28RSaxq0eqYPKQfW53UJj5uDOgw7a7rlzyErIv2r
	2+nJFlS0kqjusp2F9t5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFCX-0000Ne-Cp; Fri, 22 Feb 2019 18:05:33 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFBa-0006jl-OB
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:04:36 +0000
Received: by mail-lf1-x142.google.com with SMTP id j1so2374897lfb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
 b=c8+KBjQgBZFPJYZJLcn6IF4jWIkQTuF71Jjw05YUUPwrP9lUWRqesQ3UDx2KsPvLyY
 IcrrtRp1+hWPNNYCpCMKOUvV7LdJqqsNiUuVJw9EByv7wul+MMshHj9fbsNIi9zeaN9k
 7+ZBsHnpSJGEJodG3SEJSFOm6qWKyzooRvc93gjUhyi22qSwO8xYMEs8oH2DymWQPCLB
 iXjppVv8GCbqSsesIBsnfdTedF3E0od9Yc7G9Q+lgUYXFdc4uniHVtU2Vm3DAqZC/c/K
 7N/mh6OXQH2Y7EaloRfAcgnZiMz3YxQ7FA+7t7/4tZRQfWtSe5wR2c/cO8zqUSsqk8L7
 sLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
 b=cuvNzL88vGvtetJ/jWH0OB517LGXVOdOHxie4Zt1HlF33P7HfhK2VqBRIMSgVe931g
 zGbjq7zpdcdq7aDkvbyWBUl9WhiqU+szPZKyJMxWkiIntDo7vLdmRRpnFFE7KKwfZF33
 pIkPnIPU3VANgExAqbgwfjp7cp9Y0B1ebm4j0yZu/ydP8QN+9iA4T2tCrSHRbELDcCbZ
 oGrzoL8EJgKOriPKDBRKIEnRwmwtimfqsV3W2/BKCSriO+mNOH8NX15YzsNnnhMw1jsy
 rhO4WfkoqUZsCRpjj3tinFujveU50D43s1ELIapL5Z5r7oYog8y0mZ28tDYJtTrYzGwt
 eCXA==
X-Gm-Message-State: AHQUAuZO8GhXO8oC4E2gcJOzKeps+9XNMgkFM9GjpAVS6jngWUWY3qSD
 7joC12truYmz6qlkfg79cU/i6vTE
X-Google-Smtp-Source: AHgI3IYt/9wxIsMPbVzzRAw07l6thGsIrsOiWAYri4mv6meo0FXtAaTrSIpifQBqtgaWishzPuvYYg==
X-Received: by 2002:ac2:415a:: with SMTP id c26mr3438477lfi.62.1550858672826; 
 Fri, 22 Feb 2019 10:04:32 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 10:04:31 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v5 3/8] ARM: trusted_foundations: Provide information about
 whether firmware is registered
Date: Fri, 22 Feb 2019 20:59:21 +0300
Message-Id: <20190222175926.23366-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100434_780527_51CF66F7 
X-CRM114-Status: GOOD (  12.46  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a helper that provides information about whether Trusted Foundations
firmware operations have been registered.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c    | 5 +++++
 arch/arm/include/asm/trusted_foundations.h | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index c496f4cc49cb..d795ed83a3cd 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -172,3 +172,8 @@ void of_register_trusted_foundations(void)
 		panic("Trusted Foundation: missing version-minor property\n");
 	register_trusted_foundations(&pdata);
 }
+
+bool trusted_foundations_registered(void)
+{
+	return firmware_ops == &trusted_foundations_ops;
+}
diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index cdd48ab7d191..3f23fa493db6 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
+#include <linux/types.h>
 
 #define TF_PM_MODE_LP0			0
 #define TF_PM_MODE_LP1			1
@@ -47,6 +48,7 @@ struct trusted_foundations_platform_data {
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
 void of_register_trusted_foundations(void);
+bool trusted_foundations_registered(void);
 
 #else /* CONFIG_TRUSTED_FOUNDATIONS */
 
@@ -74,6 +76,11 @@ static inline void of_register_trusted_foundations(void)
 	if (of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations"))
 		register_trusted_foundations(NULL);
 }
+
+static inline bool trusted_foundations_registered(void)
+{
+	return false;
+}
 #endif /* CONFIG_TRUSTED_FOUNDATIONS */
 
 #endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
