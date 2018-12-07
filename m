Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60ECC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688B120672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="APhayJJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688B120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=lO1QtQgkJBuzVNfMyHurz5hleWWx1ZpcKVMT11+sFfE=; b=APhayJJxgVuFmJ5XUE5EMNCGy9
	rr6BH9D5UQbZGFY/1BKxNwSLFqN/oLuhYXvHwc8uSM8E8wioDvpG1xryuHsn5YZ7ox7ko3pkJhw1f
	GAqIwWnWJlIk3TYza7tXLt69X3GWHMLdpB+rNgLyjSR7bTdDxwsWeQzUSTA29jU+RYfIcweydC415
	orLtHXtdIig4FjuGPydmdOQEi2fgzhQr6ElvWkoQwqljXL7/ZMspX56hmQhNnYQBvjZCTronEnUdZ
	lcOVwdYmIlO8xSTFn+wVTexbMKJ1K6EPF04s8e0TUhM4w9SB7Z9ECp0Pru+tBIUg9d6JiauoSAgyJ
	UWL/QiCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVL2t-0004cz-61; Fri, 07 Dec 2018 18:40:15 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVL2p-0003cP-Bu
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:40:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7253E15AD;
 Fri,  7 Dec 2018 10:40:03 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597523F5AF;
 Fri,  7 Dec 2018 10:40:00 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 01/13] arm64: add comments about EC exception levels
Date: Fri,  7 Dec 2018 18:39:19 +0000
Message-Id: <20181207183931.4285-2-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207183931.4285-1-kristina.martsenko@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_104011_407151_B97A9EC5 
X-CRM114-Status: GOOD (  10.47  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To make it clear which exceptions can't be taken to EL1 or EL2, add
comments next to the ESR_ELx_EC_* macro definitions.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/esr.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 676de2ec1762..23602a0083ad 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -29,23 +29,23 @@
 #define ESR_ELx_EC_CP14_MR	(0x05)
 #define ESR_ELx_EC_CP14_LS	(0x06)
 #define ESR_ELx_EC_FP_ASIMD	(0x07)
-#define ESR_ELx_EC_CP10_ID	(0x08)
+#define ESR_ELx_EC_CP10_ID	(0x08)	/* EL2 only */
 /* Unallocated EC: 0x09 - 0x0B */
 #define ESR_ELx_EC_CP14_64	(0x0C)
 /* Unallocated EC: 0x0d */
 #define ESR_ELx_EC_ILL		(0x0E)
 /* Unallocated EC: 0x0F - 0x10 */
 #define ESR_ELx_EC_SVC32	(0x11)
-#define ESR_ELx_EC_HVC32	(0x12)
-#define ESR_ELx_EC_SMC32	(0x13)
+#define ESR_ELx_EC_HVC32	(0x12)	/* EL2 only */
+#define ESR_ELx_EC_SMC32	(0x13)	/* EL2 and above */
 /* Unallocated EC: 0x14 */
 #define ESR_ELx_EC_SVC64	(0x15)
-#define ESR_ELx_EC_HVC64	(0x16)
-#define ESR_ELx_EC_SMC64	(0x17)
+#define ESR_ELx_EC_HVC64	(0x16)	/* EL2 and above */
+#define ESR_ELx_EC_SMC64	(0x17)	/* EL2 and above */
 #define ESR_ELx_EC_SYS64	(0x18)
 #define ESR_ELx_EC_SVE		(0x19)
 /* Unallocated EC: 0x1A - 0x1E */
-#define ESR_ELx_EC_IMP_DEF	(0x1f)
+#define ESR_ELx_EC_IMP_DEF	(0x1f)	/* EL3 only */
 #define ESR_ELx_EC_IABT_LOW	(0x20)
 #define ESR_ELx_EC_IABT_CUR	(0x21)
 #define ESR_ELx_EC_PC_ALIGN	(0x22)
@@ -68,7 +68,7 @@
 /* Unallocated EC: 0x36 - 0x37 */
 #define ESR_ELx_EC_BKPT32	(0x38)
 /* Unallocated EC: 0x39 */
-#define ESR_ELx_EC_VECTOR32	(0x3A)
+#define ESR_ELx_EC_VECTOR32	(0x3A)	/* EL2 only */
 /* Unallocted EC: 0x3B */
 #define ESR_ELx_EC_BRK64	(0x3C)
 /* Unallocated EC: 0x3D - 0x3F */
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
