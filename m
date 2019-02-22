Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF02C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369502075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mGYoldFK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQbOwR1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369502075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dIU3E5CLzK1D4diKYnl/XvIXYBC9rFoq3FEWRjoVO0U=; b=mGYoldFKZEc+QX
	u9ff6uJYe+Zh26JJ6Im0QM3jBlyBenu9A52DxjQkn7SaRnHkUHweKrtlnLn2ckQR04/fkjpPh4Bbf
	/wqneapJwLiW3201XGBYUgs4mrgCcuj6JKkISSkS19YwY90AqUQ7oHzPeAvEXuJQ7ijm1+io2MoNx
	lSdxzUXo8blNCYipGWvb3yt4+Nti7ZY5e7OH1Kv7SI0vJ1Yr7TQnrvtF7NZDHX3TKyIE7/Sri/PQ/
	cOY6aShnFta0SrIPJLsXS24ku+TT2ivYL+cLnJWNL1jEA0zAIJLm+fX36fMH4As3wR7fa42UgZUr7
	I+D01k17ctq/ncXotoQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxEM0-0003sP-Fh; Fri, 22 Feb 2019 17:11:16 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxELd-0003PD-4E
 for linux-arm-kernel@bombadil.infradead.org; Fri, 22 Feb 2019 17:10:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ouee0YLVshfDpNmhdtmAPKI3yDIiF8sP5qi+H6Mo1GU=; b=eQbOwR1IL9a7wGfCSNEryr1sFO
 fSmAuT8JKqrX1Vf1njkvfGxXsa918HK6mUgVpkOmcRBnIemI+vpe94ezTKCqWudBlWX2nyWLbP95b
 PvZc31gQRvGvitHXIbosL6npK024Zul4wvixzFcMjD2LTHsGg6OFgMvR/kqAvaamCJ/SM+l2YxxAg
 PoEbFGGIC0Ti4NprX8phktmvQx4Fh/4i8cjMJyg807qxrwqlAG4e3tWSoeIOzSVi45O2Ko0nZMfv5
 E1VcTUssvNkJaouq+VrvbXcAxC9Svao3q6WPZvAkevqzvYWTLGkaYu08IIEMmVVP8LYW4Z6Oijs0R
 k5xtTXOw==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDgT-0004Al-Om
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:28:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 447DD1682;
 Fri, 22 Feb 2019 08:28:21 -0800 (PST)
Received: from big-swifty.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 8100D3F5C1; Fri, 22 Feb 2019 08:28:16 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 16/27] arm64: KVM: Expose sanitised cache type register to
 guest
Date: Fri, 22 Feb 2019 16:25:54 +0000
Message-Id: <20190222162605.5054-17-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222162605.5054-1-marc.zyngier@arm.com>
References: <20190222162605.5054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_112822_001167_0173E551 
X-CRM114-Status: GOOD (  19.73  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, kvm@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 Zenghui Yu <yuzenghui@huawei.com>, Colin Ian King <colin.king@canonical.com>,
 Dave Martin <Dave.Martin@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

We currently permit CPUs in the same system to deviate in the exact
topology of the caches, and we subsequently hide this fact from user
space by exposing a sanitised value of the cache type register CTR_EL0.

However, guests running under KVM see the bare value of CTR_EL0, which
could potentially result in issues with, e.g., JITs or other pieces of
code that are sensitive to misreported cache line sizes.

So let's start trapping cache ID instructions if there is a mismatch,
and expose the sanitised version of CTR_EL0 to guests. Note that CTR_EL0
is treated as an invariant to KVM user space, so update that part as well.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  3 ++
 arch/arm64/include/asm/sysreg.h      |  1 +
 arch/arm64/kvm/sys_regs.c            | 59 +++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index a0d1ce9ae12b..9acccb1e3746 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -77,6 +77,9 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 	 */
 	if (!vcpu_el1_is_32bit(vcpu))
 		vcpu->arch.hcr_el2 |= HCR_TID3;
+
+	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE))
+		vcpu->arch.hcr_el2 |= HCR_TID2;
 }
 
 static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6482e8bcf1b8..5b267dec6194 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -361,6 +361,7 @@
 
 #define SYS_CNTKCTL_EL1			sys_reg(3, 0, 14, 1, 0)
 
+#define SYS_CCSIDR_EL1			sys_reg(3, 1, 0, 0, 0)
 #define SYS_CLIDR_EL1			sys_reg(3, 1, 0, 0, 1)
 #define SYS_AIDR_EL1			sys_reg(3, 1, 0, 0, 7)
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0d348500b24b..45a07cfc57ed 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1146,6 +1146,49 @@ static int set_raz_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 	return __set_id_reg(rd, uaddr, true);
 }
 
+static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+		       const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	p->regval = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	return true;
+}
+
+static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			 const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	p->regval = read_sysreg(clidr_el1);
+	return true;
+}
+
+static bool access_csselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			  const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		vcpu_write_sys_reg(vcpu, p->regval, r->reg);
+	else
+		p->regval = vcpu_read_sys_reg(vcpu, r->reg);
+	return true;
+}
+
+static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			  const struct sys_reg_desc *r)
+{
+	u32 csselr;
+
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
+	p->regval = get_ccsidr(csselr);
+	return true;
+}
+
 /* sys_reg_desc initialiser for known cpufeature ID registers */
 #define ID_SANITISED(name) {			\
 	SYS_DESC(SYS_##name),			\
@@ -1363,7 +1406,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_CNTKCTL_EL1), NULL, reset_val, CNTKCTL_EL1, 0},
 
-	{ SYS_DESC(SYS_CSSELR_EL1), NULL, reset_unknown, CSSELR_EL1 },
+	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
+	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },
+	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
+	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
 
 	{ SYS_DESC(SYS_PMCR_EL0), access_pmcr, reset_pmcr, },
 	{ SYS_DESC(SYS_PMCNTENSET_EL0), access_pmcnten, reset_unknown, PMCNTENSET_EL0 },
@@ -1663,6 +1709,7 @@ static const struct sys_reg_desc cp14_64_regs[] = {
  * register).
  */
 static const struct sys_reg_desc cp15_regs[] = {
+	{ Op1( 0), CRn( 0), CRm( 0), Op2( 1), access_ctr },
 	{ Op1( 0), CRn( 1), CRm( 0), Op2( 0), access_vm_reg, NULL, c1_SCTLR },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 1), access_vm_reg, NULL, c2_TTBR1 },
@@ -1779,6 +1826,10 @@ static const struct sys_reg_desc cp15_regs[] = {
 	PMU_PMEVTYPER(30),
 	/* PMCCFILTR */
 	{ Op1(0), CRn(14), CRm(15), Op2(7), access_pmu_evtyper },
+
+	{ Op1(1), CRn( 0), CRm( 0), Op2(0), access_ccsidr },
+	{ Op1(1), CRn( 0), CRm( 0), Op2(1), access_clidr },
+	{ Op1(2), CRn( 0), CRm( 0), Op2(0), access_csselr, NULL, c0_CSSELR },
 };
 
 static const struct sys_reg_desc cp15_64_regs[] = {
@@ -2192,11 +2243,15 @@ static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
 	}
 
 FUNCTION_INVARIANT(midr_el1)
-FUNCTION_INVARIANT(ctr_el0)
 FUNCTION_INVARIANT(revidr_el1)
 FUNCTION_INVARIANT(clidr_el1)
 FUNCTION_INVARIANT(aidr_el1)
 
+static void get_ctr_el0(struct kvm_vcpu *v, const struct sys_reg_desc *r)
+{
+	((struct sys_reg_desc *)r)->val = read_sanitised_ftr_reg(SYS_CTR_EL0);
+}
+
 /* ->val is filled in by kvm_sys_reg_table_init() */
 static struct sys_reg_desc invariant_sys_regs[] = {
 	{ SYS_DESC(SYS_MIDR_EL1), NULL, get_midr_el1 },
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
