Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EA9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:11:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D3320827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="erZodABY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cGuITeLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D3320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Z90jEwGbk0v0k0ILfrt8xrzEIqE9lm1b2Zg97I9S6Js=; b=erZodABYLWi14fsu/Fas+jLb+a
	UIp6i4Bm3xBInKs/0K/jm5CyqOzkLAaEIqCI0pc4vimPeGyGOzxXepS4X8lfWZcN1ds7WZZhpTH6P
	2TIFfEWRNfLRh/Ifsq3PS/Ct+nfjNL28+d4eALqIqRzIHcXU0XUr5pZrASpvnuiuSfKfQBI+B2Jze
	9lFAqZhDaKEaIxAjEE2K1+ohb+AhLuNUZ2IRy6cVXGoOTnc5Ir4zk14HF9LKyj4Kke95VyvLd1CEj
	wHXNl+VgGe3QE8uIA7Ed73Nd+Zb8+db8yvVGxCkvhHXzJvflPFNGJc3Ju3wNvSKN+8sKtp/a/bA8H
	HbTxkDzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggt29-0008JF-1U; Tue, 08 Jan 2019 15:11:13 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggt1m-0007ru-Kt
 for linux-arm-kernel@bombadil.infradead.org; Tue, 08 Jan 2019 15:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EVYLVCybrBltv0j2WAxlzY7/UNQoFGDeU4FtQw46wuU=; b=cGuITeLvHzyC/ZDahflUVrWOk
 I8bpBNy18vSDt4HXLdqEQGMPVaE6xrk3ZLDJN7Vg+SmZ4U9xJualjHBMso5FBNVhOoFeeYpWpt3yX
 Ls5V7g70obX5dCakm7zZeQQJj+yXXL+VD9PPoUyF4tkOtJW4t3a0tsJKW/U+Vaz3oSIMvYrci/cPm
 4iQJYpMFRQQD/KqPOX6bxVL0zt2PPJeyWrj9snY+nY51E4yG1qvHHJPsSD7aLgFCrFV0SdwDFg8aV
 GuvFQE/hSe0KoKZmRMa1Q3SNYJ8C6xGwsPVw0OEuDTk1GOuHlMO44onKTZBgixO2w+ovUftik7g/B
 Z4pEVoo5w==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3o-0000D1-90
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:08:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2132E168F;
 Tue,  8 Jan 2019 06:08:52 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0189F3F70D;
 Tue,  8 Jan 2019 06:08:49 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 23/26] arm64: Handle serror in NMI context
Date: Tue,  8 Jan 2019 14:07:41 +0000
Message-Id: <1546956464-48825-24-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_090852_430580_8F11E365 
X-CRM114-Status: GOOD (  12.47  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Julien Thierry <julien.thierry@arm.com>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org,
 Dave Martin <dave.martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Per definition of the daifflags, Serrors can occur during any interrupt
context, that includes NMI contexts. Trying to nmi_enter in an nmi context
will crash.

Skip nmi_enter/nmi_exit when serror occurred during an NMI.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/traps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4e2fb87..8ad119c 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -898,13 +898,17 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
 
 asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
 {
-	nmi_enter();
+	const bool was_in_nmi = in_nmi();
+
+	if (!was_in_nmi)
+		nmi_enter();
 
 	/* non-RAS errors are not containable */
 	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
 		arm64_serror_panic(regs, esr);
 
-	nmi_exit();
+	if (!was_in_nmi)
+		nmi_exit();
 }
 
 void __pte_error(const char *file, int line, unsigned long val)
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
