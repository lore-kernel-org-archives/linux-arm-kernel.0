Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4CCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB391218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Li1au+xT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzEL4kWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB391218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gG7mJYauJTsz2rOJUaTYAv2PsG1tEEvtMyZ7v/Mwi4g=; b=Li1au+xTwq0/ed
	tKbz26K8Cp/GA/4SuaDpKF6LfJsKOAHRJbrzGnPMYHVBPvYhguOQVdQrHlNPAr6NzY7xWb6M1RzkJ
	/zn3kOV3PDTBkLpTVjBBgwledS54/cmo37uXlNobiv5qsYdrqIMJw/SprGuSPRquxr54pF97UiiTP
	tpbj6TH+17YDLhqJYi9Ju6nzc+M6NzBQmS4cm4GLAs1PiB3g4qv52eZI6aBSXubJultqQ12t8+6OB
	S4HTG7pOXS+jQdReuIQMIGvnHosEzwpWpE2lSQdp3hv+z4u3u2yRDxgihxQe1odlRVaAkyDIvujD7
	SlLpQqwR0rvN3hL2J+Cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWfY-0003aa-IA; Mon, 18 Feb 2019 00:20:24 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWep-0001Zf-OU
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 00:19:47 +0000
Received: by mail-pg1-x541.google.com with SMTP id u9so3990056pgo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 16:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
 b=WzEL4kWCx33847OA62oJO2Wr9cM2nJ70TgNnaqK8kNY8pt5dl6BwVdjYoffp2DEfLM
 XT9um9KQ782bFnUcUBez6Azds+lfhwXa11qb6R1DJ7hMIl6aAunvy4FlFCnt7p48UETQ
 dhEkEwt4EE3YJUExN0fP0J5sM/ezttnJE+8BvH3H8SMNAARvXDChNsQksp4KtcC7yR1Q
 14p2faN0pVd7wGQChe3awiNYPgyHU2N0TEz8GJEZBJJwTXIrD5WnYHOj5/EOB+MyLTuq
 at8e+Gh8yyAxV2ygRGUuhY88sXvkqbyNCRjjm8H1g7v5Lar1jkoW8WlvEYP6jS/UbJvi
 lE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
 b=EabcwEEt0H5V9U9lc3YJ2twe47+mQtt4GwIV9QLvgu+JyHs2W7HLQbsPdF3Nk4Nc45
 0mblBqS47u6mHpcgtXGXaLs/JzFCGc/f16NfqnSkY6i+UzjdO/lattgI+QKkwF9yikBm
 DyH9L3UN3ieqV7t+id76jJ+EQMVLWVwcFO8WXYTj0A4ecDFqf2G/0AcR8mubSyHPJXuW
 ICKa6zdrl7jVn2cIgGNP+Va0WxEvIeGAWn9Al+d872Ur7jZdAv7ijcbVAPIYrK64jq6T
 2gzUt2Xn38gCDjQmNcrbYxyZ9RKo7SjjOwC3qiO1ZqZ+kfhlAXHqb2yFKTee4s0AzVKg
 zR6A==
X-Gm-Message-State: AHQUAuZD/N8wZ8aad7miHVm51MCfX/axPXnUFGAj2JuQxC22lZ5ufmLW
 63yn4U2H4t9PU4+glldN8L51kAsb
X-Google-Smtp-Source: AHgI3IbFVYQxk+UFZWL1I+XcGnUftENqMcDIkh5oC5TY5Lbla+3d4kjnIpLE+JKYOIQkawf+o4YdUQ==
X-Received: by 2002:a62:d281:: with SMTP id
 c123mr17106376pfg.210.1550449178969; 
 Sun, 17 Feb 2019 16:19:38 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 16:19:38 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 3/8] ARM: trusted_foundations: Provide information about
 whether firmware is registered
Date: Mon, 18 Feb 2019 03:17:21 +0300
Message-Id: <20190218001726.16785-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_161940_189736_22BB0AC6 
X-CRM114-Status: GOOD (  12.65  )
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
