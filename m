Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1769C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:34:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E78920868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mfl/77jK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E78920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7zskBvEfze2aQLzyF0FA8SI4kAhovAHW3v+dl5szwsk=; b=Mfl/77jKiGCpl6y8PVns3F/Icj
	dfTJF7xnjACocuNGH1OV+dp2Q6WcdbyKE6DsvGf7LyfH3yTHPP+uKwJKjYRfQnV/pb0L0DA2wOF8w
	hOwxf5HPRaTn+QCciL5Rw2g9vNJF0Tu0GR5MTH/1LRJRfciekwrnB/X5o1afD0w7B1iAaUWGxyCdp
	lIPvHymD8Oz+JH7TYGH/w4hQJmLYv6nOzqXQ29RBaRcL5lcFE8pgStdX+cDe/5B2ZL9PYuaB5KUL1
	HvIv7FUvWQuAE44i62uiI0fh+cSRSZ+wyJTXo5Kifry4l/5t05LUl8Ts3mJuLHWVtSX6BQUTrax1e
	THZJ0p8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEN1-0008NG-3b; Thu, 17 Jan 2019 20:34:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEMx-0008Mi-Ux
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:34:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49EA1EBD;
 Thu, 17 Jan 2019 12:34:31 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D95C3F819;
 Thu, 17 Jan 2019 12:34:29 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 01/25] KVM: Documentation: Document arm64 core registers in
 detail
Date: Thu, 17 Jan 2019 20:33:15 +0000
Message-Id: <1547757219-19439-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_123431_999669_AB510516 
X-CRM114-Status: GOOD (  10.76  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Julien Grall <Julien.Grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since the the sizes of individual members of the core arm64
registers vary, the list of register encodings that make sense is
not a simple linear sequence.

To clarify which encodings to use, this patch adds a brief list
to the documentation.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 Documentation/virtual/kvm/api.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 356156f..097b8ba 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2090,6 +2090,30 @@ contains elements ranging from 32 to 128 bits. The index is a 32bit
 value in the kvm_regs structure seen as a 32bit array.
   0x60x0 0000 0010 <index into the kvm_regs struct:16>
 
+Specifically:
+    Encoding            Register  Bits  kvm_regs member
+----------------------------------------------------------------
+  0x6030 0000 0010 0000 X0          64  regs.regs[0]
+  0x6030 0000 0010 0002 X1          64  regs.regs[1]
+    ...
+  0x6030 0000 0010 003c X30         64  regs.regs[30]
+  0x6030 0000 0010 003e SP          64  regs.sp
+  0x6030 0000 0010 0040 PC          64  regs.pc
+  0x6030 0000 0010 0042 PSTATE      64  regs.pstate
+  0x6030 0000 0010 0044 SP_EL1      64  sp_el1
+  0x6030 0000 0010 0046 ELR_EL1     64  elr_el1
+  0x6030 0000 0010 0048 SPSR_EL1    64  spsr[KVM_SPSR_EL1] (alias SPSR_SVC)
+  0x6030 0000 0010 004a SPSR_ABT    64  spsr[KVM_SPSR_ABT]
+  0x6030 0000 0010 004c SPSR_UND    64  spsr[KVM_SPSR_UND]
+  0x6030 0000 0010 004e SPSR_IRQ    64  spsr[KVM_SPSR_IRQ]
+  0x6060 0000 0010 0050 SPSR_FIQ    64  spsr[KVM_SPSR_FIQ]
+  0x6040 0000 0010 0054 V0         128  fp_regs.vregs[0]
+  0x6040 0000 0010 0058 V1         128  fp_regs.vregs[1]
+    ...
+  0x6040 0000 0010 00d0 V31        128  fp_regs.vregs[31]
+  0x6020 0000 0010 00d4 FPSR        32  fp_regs.fpsr
+  0x6020 0000 0010 00d5 FPCR        32  fp_regs.fpcr
+
 arm64 CCSIDR registers are demultiplexed by CSSELR value:
   0x6020 0000 0011 00 <csselr:8>
 
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
