Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF33C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFE6206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dnZXCrfQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9JykKxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFE6206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GgO/TRLL3hUMPwlOcR2gcSHVmCdQ1u+KtEcphtbfMo4=; b=dnZXCrfQyF+UxweBtddpbSRTS8
	DqzNB9zJRkVHqdRZO5w1bYw7jHuqttIbgYHO1QItH2DlaiLdsAEa8D4NkwjqrMjsnv0AdUaEp8uV0
	iuJInFv2hr5yQqzX63KYlfVcBsQ4vBiao0UCxDF2OC1PBUkjnmIStqiVqdjGqLx45KqzMM22uVhHU
	ALglwyNI5hAyjUOHamu52dCqrwJAuUhah3Mb4hZ69F4cBmtZL46A+iVGEUSFnsi/mC1Do/IbKjDNO
	6tnLNBelrA5R6vRuu5a1C8thzgZ9c03YNfQXuK/UhhC7ZiXGC9DKGWMMcbyTuPy5XKzXxTsS1HZY6
	z2hgsDMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx67g-0001zC-Fh; Fri, 22 Feb 2019 08:23:56 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx67V-0001lT-9d
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:23:47 +0000
Received: by mail-pl1-x644.google.com with SMTP id bj4so762259plb.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 00:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CWZpOa7KU5IoSG9K/3vLaR3fHpcin2VffNYLaVd5Roo=;
 b=E9JykKxLXU3+k4vQJjpERuNJgwqlLMYvxWPzlcoDPM4s+cbq4WMQ0swQVCbYdMDISL
 iJKV68RQ/EIyFU3hfa8393jPd6Aqbq6IBo2ph/gROiRMlHFGhQSyQ/UY/+HBwhDWK967
 Ayz64rJ09cxSRy1x06vCxiU9EaBJCnx8LMa5kzfj8e+zbJpKACzO4ixm2dw1JCJ5rwR6
 N4wHGXkLrKU50tsEGFyYyRrAG5kmj/J+HvSLF0lDGv570H6htjawDDrc5ZqhxrhU2IzK
 tI2juO2pHVCJY99UuLB+Y5mU13QgvatV2cyQWjrjfspX123dEnZifYcd8tNqxYU/DOj+
 I8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CWZpOa7KU5IoSG9K/3vLaR3fHpcin2VffNYLaVd5Roo=;
 b=Wr94DL6k9qV8h62AEOgkSGet4/qGU/8Ub4nQ81Qr8cQZHl0nNA/IjlriY8EqOf2wIQ
 okmjXgbogjmKZ4bAxa79smWVid8WHaOXLl3b3lyNyabMmcsfWSQS69nSXa8TploCHYD3
 S3qWHAy0p8HwerEtfbYRNgoCLE2hrC6YQNfGbX58TZCm2vfxjSaDb/I3t3a1PN9Vxi8J
 YmEp3Lf2r82tPm0j4f1dsHoLo7s2rBnt+buLeCvIgc3vDeuQStGM2c638JOYKfRIRsGE
 ndUsxjDITtkceJ9WesGHQC2BoVUfdRKhElHiWdSKHf/k3TZtLrjxgPzX8T8xljq0FskH
 6c3g==
X-Gm-Message-State: AHQUAuYi/nVCxV4LTFAJoyp9k1SjuNLj5HPi9KhPFKwO+Fom+K37XKHF
 rvJxTHRmv5Xwq7LFvz7imkXJqw==
X-Google-Smtp-Source: AHgI3IZAlCgx+vdzMMXnYCfqie9DawIRzNKTXpKS+YqirqUzOYE8VP/uLh0i/02vD5sHe2HBX09mbg==
X-Received: by 2002:a17:902:45:: with SMTP id 63mr3010111pla.281.1550823824594; 
 Fri, 22 Feb 2019 00:23:44 -0800 (PST)
Received: from localhost.localdomain (li1195-158.members.linode.com.
 [45.79.96.158])
 by smtp.gmail.com with ESMTPSA id y22sm133821pfn.136.2019.02.22.00.23.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 00:23:43 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 James Morse <james.morse@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Jun Yao <yaojun8558363@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] KVM: arm64: Use macro to replace hard number
Date: Fri, 22 Feb 2019 16:23:23 +0800
Message-Id: <20190222082327.3312-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222082327.3312-1-leo.yan@linaro.org>
References: <20190222082327.3312-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_002345_563490_E1318588 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: Leo Yan <leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use macro for ID_AA64MMFR1_EL1.VH bits shift instead of 8 directly.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4471f570a295..3ac377e9fd28 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -490,7 +490,7 @@ ENTRY(el2_setup)
 	 * kernel is intended to run at EL2.
 	 */
 	mrs	x2, id_aa64mmfr1_el1
-	ubfx	x2, x2, #8, #4
+	ubfx	x2, x2, #ID_AA64MMFR1_VHE_SHIFT, #4
 #else
 	mov	x2, xzr
 #endif
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
