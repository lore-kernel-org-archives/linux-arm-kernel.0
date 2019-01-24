Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1039C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:04:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC4F21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u3pygft4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC4F21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7s8mt4lfwhB1O/UgFHmKCcOHCNZRr7C+YAzDl0maSno=; b=u3pygft4lSPmjwllJ4o3G5lcWc
	jbNSJWmPYA4SfPBz/Pl6uliwufTIoc9YULQ0OW4iaN+ZDjKRZdEUp/l+w7+iucuGGCflSN+j6/u3w
	gZiwRee3c7BKKXirKySO+Mx1XB9tzjIClJtPZAbXwMAve/A4TYqnqIzyiIcyqiQxatAlIsw//vAAM
	4rUtniSQA2ahZq6niq4TCsrw039ozd/LpqfOZASnK7W9jMh1dqMLA/liZXLrSPJ/TbLgns2xs/BTO
	VNc6t9wVhJzhhLj6yutL+BwJFF/vSLXvS73WJdfX06DyCmGqqDFIwCr/75/64OdrXhOFYAm/0m3RS
	7f2Wpa3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmfcS-0006RH-7g; Thu, 24 Jan 2019 14:04:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmfZ9-0003KF-3h
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 14:02:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3BAA168F;
 Thu, 24 Jan 2019 06:01:10 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CF263F5C1;
 Thu, 24 Jan 2019 06:01:10 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/14] KVM: arm/arm64: Move kvm_is_write_fault to header file
Date: Thu, 24 Jan 2019 15:00:32 +0100
Message-Id: <20190124140032.8588-15-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190124140032.8588-1-christoffer.dall@arm.com>
References: <20190124140032.8588-1-christoffer.dall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_060111_749786_972B50A7 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Move this little function to the header files for arm/arm64 so other
code can make use of it directly.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h   | 8 ++++++++
 arch/arm64/include/asm/kvm_emulate.h | 8 ++++++++
 virt/kvm/arm/mmu.c                   | 8 --------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 77121b713bef..8927cae7c966 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -265,6 +265,14 @@ static inline bool kvm_vcpu_dabt_isextabt(struct kvm_vcpu *vcpu)
 	}
 }
 
+static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vcpu_trap_is_iabt(vcpu))
+		return false;
+
+	return kvm_vcpu_dabt_iswrite(vcpu);
+}
+
 static inline u32 kvm_vcpu_hvc_get_imm(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_get_hsr(vcpu) & HSR_HVC_IMM_MASK;
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 506386a3edde..a0d1ce9ae12b 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -331,6 +331,14 @@ static inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
 	return ESR_ELx_SYS64_ISS_RT(esr);
 }
 
+static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vcpu_trap_is_iabt(vcpu))
+		return false;
+
+	return kvm_vcpu_dabt_iswrite(vcpu);
+}
+
 static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 {
 	return vcpu_read_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index bffcbc423f4c..c17010bc33a9 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1398,14 +1398,6 @@ static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, phys_addr_t *ipap)
 	return false;
 }
 
-static bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
-{
-	if (kvm_vcpu_trap_is_iabt(vcpu))
-		return false;
-
-	return kvm_vcpu_dabt_iswrite(vcpu);
-}
-
 /**
  * stage2_wp_ptes - write protect PMD range
  * @pmd:	pointer to pmd entry
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
