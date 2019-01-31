Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB92C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:18:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D503218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ax4gAOuN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHq3aFf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D503218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h/nuhHqPlvKuP0oEDomYB8BhZsfgLET1MFGolosNLKo=; b=ax4gAOuNsyAVLI
	Dz1zZ35N8Sf71hNJCymOVgdluh3KxDyVATViiaHsu+uNepiATbBLSxdKn8f4Rr61ZftDos3FQ5Nhb
	FPLGKVWekt6/pYS5GbzBD+tP80CuWq5CB18Txud2c9yRBCLI2ci95Rezb1EhFyL7LUjE99+f+9TGf
	mnFGHM1Rf2z0fr8d2GsSo3qtOumqxTpbAiHSeS+wiDAlVA1PaNGsQtAdhPkYWYjFoCmVxcCtW7RJx
	YRqe857Rz+EJcyuEbBoERs/i2wk0rJ7RLkZc70MBiQ+mMRX5oVcHv8AeRnfr1E76Nu1O0GzTM6Oqa
	E7LKFw2vTU6RXS8BW7XQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCE4-0003AU-32; Thu, 31 Jan 2019 13:17:52 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCDj-0002tv-Bp
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:17:32 +0000
Received: by mail-wr1-x442.google.com with SMTP id q18so3222637wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nk60g8z4NMiZ+KEPHGDMl1e226BI18tGzWB7rPjAlio=;
 b=RHq3aFf6oT2yVQTqvuK3qnwl5mGRgxQK6H+q25LRdZgrmkpNZoNA8I357QjmevOgzN
 8FAJD2WyFsSZ09/hRrc0mSgyGK/1c3SS3uQoV/eXlmUv+gGkA5dx/nWpT6bvBOssI+Da
 A/iLe39OnLVDRZBy2iL6MK5gzag5oSGacLoY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nk60g8z4NMiZ+KEPHGDMl1e226BI18tGzWB7rPjAlio=;
 b=fNjAPZg7M4A4UXXPuPAmnc7wdu/QdbZ+obxioujcWsgyCiGsSRhFLb28oGMxNimTjv
 9rJWWPf9RKHe29KfzW+In6zM6VdXOcB02rSM47azJDCGV5K48k/7BxeMl0TlH8Ecr/8k
 XMd02dE/Do+qFtadS17xR2F1xRRykgYqZ4OZuWIHBp6DGd7B1QOsT2CmNyTJXxFlFb7q
 1tW5X8XUBcNS/cZg+nr0nJ6x5Av5GhDbIAcJPV0rKthtwoW+h+L2SAtPAO0lWdo/bLnt
 gq/ywC2MTWbtxJigM68kX0d8vKk9VSvOySVjeNM5R3+WHB4/Je15tzmbptLHSUu1e1AK
 9LiA==
X-Gm-Message-State: AJcUukfkYkQ9ystp/zrNWolpTH34RfGzjIRatTI/E8+zyxp2G+VRlUpV
 0Apymb10dMaJtnrujjKf2+VRYxgalnY=
X-Google-Smtp-Source: ALg8bN6PaYC8B4LonDhqdcF19Vap/PfpjwcVs1DniADYBXeAS5pe0yPea4jkWHOn7twC91WISMN23Q==
X-Received: by 2002:adf:8122:: with SMTP id 31mr35032142wrm.48.1548940649696; 
 Thu, 31 Jan 2019 05:17:29 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id d16sm3211495wru.52.2019.01.31.05.17.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:17:28 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] arm64: kvm: expose sanitised cache type register to
 guest
Date: Thu, 31 Jan 2019 14:17:17 +0100
Message-Id: <20190131131718.1627-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131131718.1627-1-ard.biesheuvel@linaro.org>
References: <20190131131718.1627-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_051731_399632_6D75DF08 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: marc.zyngier@arm.com, christoffer.dall@arm.com, Suzuki.Poulose@arm.com,
 kvmarm@lists.cs.columbia.edu, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

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
---
 arch/arm64/include/asm/kvm_emulate.h |  3 +
 arch/arm64/include/asm/sysreg.h      |  1 +
 arch/arm64/kvm/sys_regs.c            | 59 +++++++++++++++++++-
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 506386a3edde..87f9c1b6387e 100644
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
index 72dc4c011014..6726a4c98ce7 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -361,6 +361,7 @@
 
 #define SYS_CNTKCTL_EL1			sys_reg(3, 0, 14, 1, 0)
 
+#define SYS_CCSIDR_EL1			sys_reg(3, 1, 0, 0, 0)
 #define SYS_CLIDR_EL1			sys_reg(3, 1, 0, 0, 1)
 #define SYS_AIDR_EL1			sys_reg(3, 1, 0, 0, 7)
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e3e37228ae4e..1312aebf74e6 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1148,6 +1148,49 @@ static int set_raz_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
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
@@ -1365,7 +1408,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_CNTKCTL_EL1), NULL, reset_val, CNTKCTL_EL1, 0},
 
-	{ SYS_DESC(SYS_CSSELR_EL1), NULL, reset_unknown, CSSELR_EL1 },
+	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
+	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },
+	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
+	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
 
 	{ SYS_DESC(SYS_PMCR_EL0), access_pmcr, reset_pmcr, },
 	{ SYS_DESC(SYS_PMCNTENSET_EL0), access_pmcnten, reset_unknown, PMCNTENSET_EL0 },
@@ -1665,6 +1711,7 @@ static const struct sys_reg_desc cp14_64_regs[] = {
  * register).
  */
 static const struct sys_reg_desc cp15_regs[] = {
+	{ Op1( 0), CRn( 0), CRm( 0), Op2( 1), access_ctr },
 	{ Op1( 0), CRn( 1), CRm( 0), Op2( 0), access_vm_reg, NULL, c1_SCTLR },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 1), access_vm_reg, NULL, c2_TTBR1 },
@@ -1782,6 +1829,10 @@ static const struct sys_reg_desc cp15_regs[] = {
 	PMU_PMEVTYPER(30),
 	/* PMCCFILTR */
 	{ Op1(0), CRn(14), CRm(15), Op2(7), access_pmu_evtyper },
+
+	{ Op1(1), CRn( 0), CRm( 0), Op2(0), access_ccsidr },
+	{ Op1(1), CRn( 0), CRm( 0), Op2(1), access_clidr },
+	{ Op1(2), CRn( 0), CRm( 0), Op2(0), access_csselr, NULL, c0_CSSELR },
 };
 
 static const struct sys_reg_desc cp15_64_regs[] = {
@@ -2206,11 +2257,15 @@ static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
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
