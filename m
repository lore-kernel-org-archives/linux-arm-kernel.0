Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22285C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:44:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80D92085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p6pYZkJn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w09mFQU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80D92085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vJQozKv20cszLeQJ3wGqJB1hc28ttBTAUg73lYjExHs=; b=p6pYZkJnw5EJBP
	Q1A+Id7BoYp2ROqk2uzbavvVzgLPtlIOEmMlYnLVb+NblI8VKcrIj18l7a+rEH5iyRGzMCmgVWodM
	1musLxXRA3FmN0vllX/uX4PsREsvLIcNa2t5NigmsOx3mGfQHP9G1+H+wa5fHESFLz0fR8Aye6xnp
	MTsD1LIQ5HSgxEo/l9yqNGs0/KjOoj3nTEETqF2aS/J+9cruiuAw0wL/Wprx2AuzcLY8J8pmq0EeF
	pYL6RvUbI40n+keh61n1wnIg1hn1goju3xoTXtZPzovj5DF9NIUuheruB9rhxK1xRboNNJiwHXMtE
	hnCPFjm5Th8hLgUGEwbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCdZ-0001VQ-Es; Thu, 31 Jan 2019 13:44:13 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZX-0004rP-El
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:25 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so2634982wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cdS11IbVgx3eQtG5n+0kNrZKOYHM3MdE1VC/tnZNKak=;
 b=w09mFQU/c14b8cwe3r2NIU4j9ZpMcKNn0VdnMKiacsTVAYwUix5OAi4CUmpzns4z7Z
 KyV1XGsbEm/vyPAkjH0Qj4zDyd46lk89NGVHgR8ui8/2qQc9cQ0BcUdhRKJSsaI2bxCv
 pxApZlTQcXYh4frKtLnFBUxk0iPbBC6jl3ftnn9kdVMMO0GRkOvpDhA46WOuT7PkUW0i
 Nf5cM3jb92ZpsbdmSELHsYFVRwUnz0Y+zMYy/dWR2RaHcLz2SBhMCyNn3zK6U4F56HzY
 WSzsrO2FGaHNl7t6log1dzt8r0d0TWM5O+jwwL2NhN9wfMigR6xXe0dGI/lSWC0tYl90
 fodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cdS11IbVgx3eQtG5n+0kNrZKOYHM3MdE1VC/tnZNKak=;
 b=EZ1uxJzGrVUj2uAo2WeKZhKO3VbFhiOVjJPHYvBmCmeZYD/bQci7sgg20jT2tkocY6
 deKn4FOWjBRL72shz1hAVq1JIuRO3DtomxsG5kBHaz/99M0leuFffTVYvRS/n2QL9Pw3
 g/EI1QdG95tq7g0YR0fvIS9lU9T2h99ieCW6Ilu5Tayca+EvYoc8d/jhNo7n0/P177ya
 VpmO4ep7ZbeZ/VL1XZVygawaMaAIDV9Dv5qqF3+ysG6YfAKNxD8rVjRJhbYyvXhhXhru
 rQ2jvRZKYyh85udpA8uvDB0ZHGp0XnH/v+rd0fpt5u2/Wix8hg2Maj3YXpulH+koofQ/
 31og==
X-Gm-Message-State: AJcUukd8QTTq0gD2ALvvAi4cvI7mNylg1gBxXZcto4VFz81SvY+nMqoE
 ejmP49F5N8V1J+pnw6VHjfvPxg==
X-Google-Smtp-Source: ALg8bN5L9iqGEJX/cb0kOiO+8fhnfMfovehjp1UwzR9NL2cH7gITxMpcgM5vcOjp9rwiYUDWNz70Lw==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr29595614wmf.8.1548942001998; 
 Thu, 31 Jan 2019 05:40:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:01 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 17/35] ARM: davinci: aintc: remove unnecessary includes
Date: Thu, 31 Jan 2019 14:39:10 +0100
Message-Id: <20190131133928.17985-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_054004_422793_75C99EFF 
X-CRM114-Status: UNSURE (   9.84  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

These includes are no longer required. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2e114ad83adc..ce4625d9cad7 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -12,11 +12,6 @@
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 
-#include <mach/hardware.h>
-#include <mach/cputype.h>
-#include <mach/common.h>
-#include <mach/irqs.h>
-#include <asm/mach/irq.h>
 #include <asm/exception.h>
 
 #define DAVINCI_AINTC_FIQ_REG0		0x00
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
