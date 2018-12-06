Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEB8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F44214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kVa3i8TH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTafQJUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F44214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6dlvZFPTJiY5aNZVNJuTLIndVxiHErYZKpw2vNE0qvw=; b=kVa3i8TH3fJggO
	4N2GcPgGkQ89X5uvpoq0hDztzJx8vW19YgvCWrt0NXlM63LttOVYYkzn5iFi7mPSwl4INcd4vDTFj
	A4rLrvpHsznYlnw8IE6RwIDvlsrSqwx8wO1Q0RHNfJjXwsJ4i2c1Q2QuBltFFbkHGxPGToMhzfQA6
	Gmv1sUPZEjOOtev2F8SOqcIi7b6hJIImzqIP2QZgeqYj9clmfh1A3n0wUjMycuyjHHmvIVGx6InLD
	pyDXorGfknjxX6PLnN/vmtEPJUBNRo2wJ+zKugwB07Li+lWnx1oP5xGjyO8oa/ax21XxnzlS2IQis
	YEJC/f04QzGPfJ1gcSHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUw4S-0003qg-Ig; Thu, 06 Dec 2018 16:00:12 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw4A-0003BL-Ir
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:59:56 +0000
Received: by mail-wm1-x344.google.com with SMTP id r11-v6so1490600wmb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wpw2u+vd9657tht5bV1UNpmFvYbIAJm69uSezSpG9Ao=;
 b=fTafQJUWvloms3Jzq3/B4I3D4zX2ANxFQwunJyp5pR6sv3hRU4IVk1JpJ8FsIJKO2K
 QPb0bek0z0OHe6JFTaM5W+uS1oa2eopKgztXOzHIeeHhHXr+FgYIO/sXMi+vx5VCaGAP
 NGf1CTJ4GtXAbZq9WswRDOtXlym28H4oKCc+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wpw2u+vd9657tht5bV1UNpmFvYbIAJm69uSezSpG9Ao=;
 b=pRGNfgWBnB+HyEQEmJu0q+h4Q3gFW5KF5HDtOQqrioZz7OAPlCWCMzUbQvffwcTXaA
 b1KRj0Up2mNgcUAwKdwWKUPpEdm4qNNH8WIdxCH9y42u2/mqREd19e417LBnTdlbIOmR
 Sip+llv1mQkp11ykLxB0cYiVnk7BUH729LJl/WhNWnLEw3Io8S6W5y4zutpRepgVsuXn
 /uEQ9DaaP2/gAQqtQ29W7l9f8BRYL8lkeXk7LdUY/OXTVXtVOf2BsA5wBi9jFGDgQkfq
 7BtTZwDqTXRfUj0VHuh2ZPcLvBV3V3YQplRsxgMcwl4sjxxBL4UWQp8UZZsTbeP75NQH
 ia8w==
X-Gm-Message-State: AA+aEWbzwcJJ4kHNExIvQbVCEYf1VoW7lTbbTCD66dibHSTsCFtXAn9k
 lTUj1MnZg0H6dCGz1mDrHaKSxg==
X-Google-Smtp-Source: AFSGD/U/8K3Ee5ipPIKObnWbkqdw/St+p8KIU4KkxWhfa07dAZiz2aSbUVr8PaxfUg7CVH26FPBSOw==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr20445248wma.68.1544111986633; 
 Thu, 06 Dec 2018 07:59:46 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id y34sm1525233wrd.68.2018.12.06.07.59.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 07:59:45 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64/assembler: use callback to 3-way alt-patch DC CVAP
 instructions
Date: Thu,  6 Dec 2018 16:57:38 +0100
Message-Id: <20181206155739.20229-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075954_673626_F8DFA998 
X-CRM114-Status: GOOD (  12.20  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use the enhanced alternative_cb implementation to reimplement the code
patching logic for DC CVAP instructions so that we don't fall back to
DV CVAC instructions on systems that require those to be upgraded to
DC CIVAC to work around silicon errata. At the same time, we don't want
to use DV CIVAC needlessly, since doing so may adversely affect
performance.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h |  9 +++++----
 arch/arm64/kernel/cpu_errata.c     | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6142402c2eb4..09c5a5452f60 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -390,11 +390,12 @@ alternative_else
 	dc	civac, \kaddr
 alternative_endif
 	.elseif	(\op == cvap)
-alternative_if ARM64_HAS_DCPOP
-	sys 3, c7, c12, 1, \kaddr	// dc cvap
-alternative_else
+alternative_cb arm64_handle_dc_cvap
+	dc	civac, \kaddr
+alternative_cb_alt
+	sys	3, c7, c12, 1, \kaddr	// dc cvap
 	dc	cvac, \kaddr
-alternative_endif
+alternative_cb_end
 	.else
 	dc	\op, \kaddr
 	.endif
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index c5489b4612c5..a63e362da307 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -755,3 +755,17 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 	}
 };
+
+asmlinkage void __init arm64_handle_dc_cvap(struct alt_instr *alt,
+					    __le32 *origptr, __le32 *updptr,
+					    int nr_inst, int nr_alts)
+{
+	struct alt_instr_cb *alt_insn = offset_to_ptr(&alt->alt_offset);
+
+	BUG_ON(nr_inst != 1 || nr_alts != 2);
+
+	if (cpus_have_cap(ARM64_HAS_DCPOP))
+		updptr[0] = alt_insn->insn[0];
+	else if (!cpus_have_cap(ARM64_WORKAROUND_CLEAN_CACHE))
+		updptr[0] = alt_insn->insn[1];
+}
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
