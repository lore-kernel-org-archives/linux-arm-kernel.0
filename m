Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2A1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF74820700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YH3NfFuR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8JGbZ4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF74820700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gG7mJYauJTsz2rOJUaTYAv2PsG1tEEvtMyZ7v/Mwi4g=; b=YH3NfFuRyecka3
	gr8vit1OwnKDH4aIPR4kF+7ZT0aKBHj/eCX+4RyktoqPE2vT/UbJI93EIPBgx5gU4D6DJHsL3U5H2
	nPFraihjwM7jNW6FfNVDS2hb35K78oJG92CZYTdo4M9vp2i/t33JNL77x1Jz+9PpMhfdiYia+I1yX
	k2J6vna0cfG8YlF/Qr5CnJp8abSMA+KJfjKj5vx+zFG9eDAYanUBfZqEiNIdapWVigSkxn35Tyf69
	RmDiYXn3jUkL6GEL4zN0gisghWNzAV5Phxo5Kx1KwIUtiy0BiQvjDHI9lrmo+xRuhD2wX9+ojUd+F
	kqGV9OIYyO78oaadZ0NQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGcP-0004HP-Vm; Fri, 22 Feb 2019 19:36:21 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGbt-0003fF-Sw
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:36:03 +0000
Received: by mail-pl1-x641.google.com with SMTP id o6so1503483pls.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
 b=r8JGbZ4cedQpU+TsVBmmNU6DuFUVST/uPXUUDDz34UwVAoCl1q+gn3LxWYYKcgJAMq
 S5Vijg+67p8aHBfgeZ/H1jRFqL0ZrADSF+fwf8LS38/GBpB6r5/0hZSsveK5ICXegT0N
 l9MIT3UYA1RIMcoVdS+/NQe7ZT2qwPMtwDsrRZ5GcywK1eDhg6b2xwA+srSuYEuE10ve
 w2Aagxaa5CsYTJKtF3xNF8c+zpSGcgA/VvP2AL4LXREjt7ghzF9JorvZDRkstY3AHXJm
 tU5RolPRIYUudpRJv20PxEYKN/8qntVAYBr+lOd4ZeLSdFeQ6J3DP8jG+WSWevqLvLo9
 aeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
 b=OhAzo2loDxhK1Wzi1NJaMdMiX5QDZRtI6uDNMjsh0LIQpDsLzSYW/SngoBwm6SsQG8
 rgfb6V/1qq79N5oyhQVxYg+pYn9JAKz3QLLRHpdp1Bc6lcpwz6PmFHQIO4bl61tyqon2
 e96qMk1434wrHp7ZCowTCTGBnHChf/7y2gYx3h6A1KC9wf+LtRxlCMWGNiCKIBWnRlNm
 LS5Md3lqJnqpv7THuzKJOMcM2i7nptWxcjGNVXy69kPJkgG2qLNT0MyqfB8t47+YSArX
 vxZ/0QL60ZZyRuAW5WNjso17+aGB9LxlOzejUqNXP5AufSjZZT/m7FqpfTkePL+oeeNx
 EyKA==
X-Gm-Message-State: AHQUAubz4PTEcEB0Hl0wlsasSWb0xP9QGvN0tXcQtUNoI1T6MeWORl6K
 qGyv+L4ItqmZCJRS26/BkWy6UNAI
X-Google-Smtp-Source: AHgI3IY+BUtHdmtO3Eb36AeX+sI7B2m8HCIDEnYZtagtrhsUxsTxrLbBcw+v0eXo8AW9LfbPmK0eJg==
X-Received: by 2002:a17:902:8b8b:: with SMTP id
 ay11mr5830228plb.162.1550864148976; 
 Fri, 22 Feb 2019 11:35:48 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.35.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 11:35:48 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 3/7] ARM: trusted_foundations: Provide information about
 whether firmware is registered
Date: Fri, 22 Feb 2019 22:34:22 +0300
Message-Id: <20190222193426.10747-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_113550_153642_8AE04C3C 
X-CRM114-Status: GOOD (  12.15  )
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
