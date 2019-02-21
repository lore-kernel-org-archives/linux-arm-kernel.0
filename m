Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C829AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:22:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986692084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YrbBsIRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986692084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=doMdPlmsgX7588nRWlcZ/jKxu8xt0EDCnBXiRb4y5ws=; b=YrbBsIRoWC60rtcOxuFD88Ysf2
	RSPh2EjYSEjZv0zoEWiFcwS/O12r8MF4XKwl8qHUi7wdkHl0/adqXUIwusZ7x7QBt0gADIZNqSlU+
	awTOF3YKg6eWg5Ki0uA0JFMiq3fQZKzLIOQ9CXk3j9OBuSkNFMaM40a/JTgsTQfWxDzlHdPEBPPKb
	1oYeeJ3U1xVtcPUt3SuzOlrdTVOL+0fuWnE1THti5VWKolWPLqDfp7D0o4duqB8RmFO2EE0H+Xo2H
	JOtRNOTVEZMmpNXhoqRLFNVQmkPLoDFNQNXXPn/FIdzEJokv9GDeJMyVaRCN4YO86Wn47nxgtq6v2
	1dPDVzjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnMj-0005Qo-8R; Thu, 21 Feb 2019 12:22:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnLl-00044H-N3
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 12:21:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6960980D;
 Thu, 21 Feb 2019 04:21:13 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F8F13F575;
 Thu, 21 Feb 2019 04:21:12 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 6/6] arm64: Advertise ARM64_HAS_DCPODP cpu feature
Date: Thu, 21 Feb 2019 12:20:57 +0000
Message-Id: <1550751657-30252-7-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
References: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_042114_058473_173F5A11 
X-CRM114-Status: GOOD (  11.53  )
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
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Advertise ARM64_HAS_DCPOP when both DC CVAP and DC CVADP are supported.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/cpucaps.h | 3 ++-
 arch/arm64/kernel/cpufeature.c   | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 82e9099..4a2a77d 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -60,7 +60,8 @@
 #define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		39
 #define ARM64_HAS_GENERIC_AUTH_ARCH		40
 #define ARM64_HAS_GENERIC_AUTH_IMP_DEF		41
+#define ARM64_HAS_DCPODP			42
 
-#define ARM64_NCAPS				42
+#define ARM64_NCAPS				43
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7e76c92..2f5d261 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1319,6 +1319,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64ISAR1_DPB_SHIFT,
 		.min_field_value = 1,
 	},
+	{
+		.desc = "Data cache clean to Point of Deep Persistence",
+		.capability = ARM64_HAS_DCPODP,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.field_pos = ID_AA64ISAR1_DPB_SHIFT,
+		.min_field_value = 2,
+	},
 #endif
 #ifdef CONFIG_ARM64_SVE
 	{
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
