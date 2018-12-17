Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9D3C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E4C2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="flDIn7ZX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYuc/kun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E4C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Y9REH/shvR6KzFB0YHXoCb4IMJ5o+zfhmp0M+imT/uU=; b=flDIn7ZXoCOneDTar6zoK3mlEF
	1txbFWZivTI4Ye9rryOmLCm+wRkwt3SM1UGx8elLPsyFBbBfaE0F+j4BaSGMI5rCG3UZGtKkSIiLA
	Saok2t3Sul6l/TY+n1o8PxNgrcC1MlqMZSraKzX1PHU+cjBmm72hEvNyl9Pb6dC5ICmc39kBGERdd
	kFXDcjqZLHRrSt+KIPaqlUEV+MYtgHlYuqFB3QcX+2HnWFvjgyaD2hy8TyYAYDSOLFhduK2CdlsWS
	CncMWKaMfATLq1s45qJiyVSoHwSQZvU0bX7Ino0/jcVUD5UHDHpAEsMdQPiBcbFcVtujXDodZQ8Ks
	yj48qk/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuQA-0000ZB-Ky; Mon, 17 Dec 2018 15:03:02 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuPX-0008Ri-BP
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:02:42 +0000
Received: by mail-ed1-x541.google.com with SMTP id y20so4863062edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 07:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AAkdAISUpdoifWJ5AwQL4xh0wyEcW4f6pZ+v+nRq89g=;
 b=kYuc/kunyBg5zkw0ACJaRW0lxoAko0yLH8vLDJSqPr5jVoIwgxMMA2OeUbjQpXB8qg
 CZokdCYmvTcFTokXWnV8Q0FNHD+zSIWZl/9bDwO2jq5YYlOQVF+5iTxIp6BSB97RBA6K
 1EBF9YbS+oNCU5GiduPLhsayYkryJaKbFAsYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AAkdAISUpdoifWJ5AwQL4xh0wyEcW4f6pZ+v+nRq89g=;
 b=EVPOqiHRgJUFXu00qYEBPJdjhNOxUi6TXQni7RSFy7EP1Ojb6dyIMpsDON1sbxqy/6
 svJQP7/4JOFijA8acyE09nW3NiULE9IrsIEZoEGeZS7ivs7IW00QW7mwql+ra3aMJFms
 F7egNjwYdND5DhkKz2XbPPT4KurDUQNk5PaMDja/VT+c3rji8OgksNIDyXQH2JuS4X1t
 a0x4DrZb4GG1y13HTnq2q2u5X7/IEtMvn4Uwjf3DG2Iip2wCEa91Pbuggw0HmfK/bQg4
 RS/2ROJW6Lns3IEUZASssMnF2nF/9/LDcQU5S30SyKnC28VRoDMG4qfDrUVEESaqWh00
 OLTA==
X-Gm-Message-State: AA+aEWacKxuASLk8r7ntAvL0UmgI1cQFohywazoDCfqfWaDgAu6pYY1p
 WJPYZ3z2xjOkO+WraKzybCOvRdhp6MZUmXMp
X-Google-Smtp-Source: AFSGD/ViDvdY4KU+SvbecW/ZRa1mdSmi2ga0R13oXE98HLRn0uHv4HlGX9iBFKhzpgjFJHqVFRVaeg==
X-Received: by 2002:a17:906:f14e:: with SMTP id
 gw14-v6mr10444427ejb.231.1545058931921; 
 Mon, 17 Dec 2018 07:02:11 -0800 (PST)
Received: from mba13.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl.
 [77.251.17.237])
 by smtp.gmail.com with ESMTPSA id s5-v6sm1904340eji.25.2018.12.17.07.02.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 07:02:11 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/2] arm64: kvm: expose sanitised cache type register to
 guest
Date: Mon, 17 Dec 2018 16:02:04 +0100
Message-Id: <20181217150205.27981-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181217150205.27981-1-ard.biesheuvel@linaro.org>
References: <20181217150205.27981-1-ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_070223_969091_3C13B9C9 
X-CRM114-Status: GOOD (  15.40  )
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
Cc: marc.zyngier@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 christoffer.dall@arm.com, Suzuki.Poulose@arm.com
MIME-Version: 1.0
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

So let's start trapping cache ID instructions, and expose the sanitised
version of CTR_EL0 to guests. Note that CTR_EL0 is treated as an invariant
to KVM user space, so update that part as well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/kvm_arm.h |  3 +-
 arch/arm64/include/asm/sysreg.h  |  1 +
 arch/arm64/kvm/sys_regs.c        | 59 +++++++++++++++++++-
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 6f602af5263c..628dcb0cfea3 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -81,9 +81,10 @@
  * IMO:		Override CPSR.I and enable signaling with VI
  * FMO:		Override CPSR.F and enable signaling with VF
  * SWIO:	Turn set/way invalidates into set/way clean+invalidate
+ * TID2:	Trap cache identification instructions
  */
 #define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
-			 HCR_TVM | HCR_BSU_IS | HCR_FB | HCR_TAC | \
+			 HCR_TVM | HCR_BSU_IS | HCR_FB | HCR_TAC | HCR_TID2 | \
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
 			 HCR_FMO | HCR_IMO)
 #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 842fb9572661..3b8e51874da4 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -342,6 +342,7 @@
 
 #define SYS_CNTKCTL_EL1			sys_reg(3, 0, 14, 1, 0)
 
+#define SYS_CCSIDR_EL1			sys_reg(3, 1, 0, 0, 0)
 #define SYS_CLIDR_EL1			sys_reg(3, 1, 0, 0, 1)
 #define SYS_AIDR_EL1			sys_reg(3, 1, 0, 0, 7)
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 22fbbdbece3c..464e794b5bc5 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1140,6 +1140,49 @@ static int set_raz_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
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
@@ -1357,7 +1400,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_CNTKCTL_EL1), NULL, reset_val, CNTKCTL_EL1, 0},
 
-	{ SYS_DESC(SYS_CSSELR_EL1), NULL, reset_unknown, CSSELR_EL1 },
+	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
+	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },
+	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
+	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
 
 	{ SYS_DESC(SYS_PMCR_EL0), access_pmcr, reset_pmcr, },
 	{ SYS_DESC(SYS_PMCNTENSET_EL0), access_pmcnten, reset_unknown, PMCNTENSET_EL0 },
@@ -1657,6 +1703,7 @@ static const struct sys_reg_desc cp14_64_regs[] = {
  * register).
  */
 static const struct sys_reg_desc cp15_regs[] = {
+	{ Op1( 0), CRn( 0), CRm( 0), Op2( 1), access_ctr },
 	{ Op1( 0), CRn( 1), CRm( 0), Op2( 0), access_vm_reg, NULL, c1_SCTLR },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 1), access_vm_reg, NULL, c2_TTBR1 },
@@ -1774,6 +1821,10 @@ static const struct sys_reg_desc cp15_regs[] = {
 	PMU_PMEVTYPER(30),
 	/* PMCCFILTR */
 	{ Op1(0), CRn(14), CRm(15), Op2(7), access_pmu_evtyper },
+
+	{ Op1(1), CRn( 0), CRm( 0), Op2(0), access_ccsidr },
+	{ Op1(1), CRn( 0), CRm( 0), Op2(1), access_clidr },
+	{ Op1(2), CRn( 0), CRm( 0), Op2(0), access_csselr, NULL, c0_CSSELR },
 };
 
 static const struct sys_reg_desc cp15_64_regs[] = {
@@ -2196,11 +2247,15 @@ static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
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
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
