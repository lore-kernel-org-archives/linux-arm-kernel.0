Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F53DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:24:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F480218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZDtplh3M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CG35HE1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F480218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K/BLI/sEyUqvRQ7Em+bYs5QadCPBn22BIVp3hxbpdD4=; b=ZDtplh3MMDHJ0c
	pabDIjBOQkGzynQwZpgfMYr9HE90b0f7b2RoHRJt+ZrjKF4X19f9q1Hr4C43ybkmEo+gzE8aFR7nO
	mCWPhn04JVuO2aLdw03X+Sxf1U2BWc4fL8od993VMKa7nY+g9AdzMGBwaVKBgSTwWLkbXSgezs0+w
	cXnYhFfvwabi3H4Hj9rS4Os52XQPQi/NnNIw1SV+/74qvoZkt2brH2b5cyJWLb3tZLG1AU8Osz/bq
	zx28yuHoeqqMMXNoVOCODYIPLN1PAg5xu4CXjiFycEs19Edg7IaFQN/e6zhaQW/rhhCJI0dC8VVMI
	VmCD2tqh5uJlzRntaqcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpASc-0001Nq-QM; Thu, 31 Jan 2019 11:24:46 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpASZ-0001NV-D8
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 11:24:45 +0000
Received: by mail-io1-xd43.google.com with SMTP id g8so2338730iok.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 03:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I5OMypIKRK4bx3JfLqOto8dp8O0Bsd1uyJBVudMAbOc=;
 b=CG35HE1m7XdtD+yrl+jGzKj0nx2T/pGVxLwbZGIhsp9XFVxqNH0e5eRs5yDBxcRox6
 6YtKHmaGTGC79yh+tEF3nJWFnCXr/54TeHt8JgwBQTcb9GtmH3jkQ1+8N6AZCtlncX9N
 upzZmejWeCY4HkNV1G6NxqdPbyAAwVdgpSg3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I5OMypIKRK4bx3JfLqOto8dp8O0Bsd1uyJBVudMAbOc=;
 b=Rb2SEXzwXoU3HV5ygJv8q6BPjpOlMuouGrbPhiZkTn2W/HLCFMFvvdQwmTYhI2kFvF
 MKgcz5k6u8NIzorbNMFt0fTpTL5YPiHbuWIJcXlcMgp3wTd4uUB2kh3zWw8KdFGV3FsH
 xx0BWEuo7Hp4vncL3qP7kL/XmSaq2dSBWRS97SYXT141zu5vL6kRq3lKf2Q7VUOCeHFG
 6hzNvmEjtBfhQ4HpQvwJ9iPyE+R/mcFByZl3Huw8uv8lV+YUpexB1s3N+cxcSSHBemHT
 RL068lG7g1hIXjy2NbR7bQ6KhAEFDMVg72YAyme5dHAk3974uMGAedRg9KT+Q2j+FZR1
 6OEQ==
X-Gm-Message-State: AHQUAuanRs//ZZmTAiDnD5tNi4rZeFwxikGDNeTHgOA2zzMMiSGl1MRt
 ZTOR24D2Jq3V1fwNgvcEzFj0eTJ17mw+urFFCZBk7SmO
X-Google-Smtp-Source: AHgI3IYpoUuh7L8d8q31IY2JsThqIN9lI9hUzvi+ZFqGfg+c5tCCfIaGY0s7CSKItmNyZk5DfPWk16vhoMd5ORwQN4o=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr16260082iop.60.1548933882306; 
 Thu, 31 Jan 2019 03:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20181217150205.27981-1-ard.biesheuvel@linaro.org>
 <20181217150205.27981-2-ard.biesheuvel@linaro.org>
 <0ca1ffad-9588-dd85-9276-98644d089b6c@arm.com>
In-Reply-To: <0ca1ffad-9588-dd85-9276-98644d089b6c@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 31 Jan 2019 12:24:30 +0100
Message-ID: <CAKv+Gu-q7KOMPWK+g+AAFZtJKSFAEHGMB1ANz3oDLd48UsPjTg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] arm64: kvm: expose sanitised cache type register
 to guest
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_032443_449515_1BD5C035 
X-CRM114-Status: GOOD (  25.54  )
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
Cc: Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 31 Jan 2019 at 12:22, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> Hi Ard,
>
> On 17/12/2018 15:02, Ard Biesheuvel wrote:
> > We currently permit CPUs in the same system to deviate in the exact
> > topology of the caches, and we subsequently hide this fact from user
> > space by exposing a sanitised value of the cache type register CTR_EL0.
> >
> > However, guests running under KVM see the bare value of CTR_EL0, which
> > could potentially result in issues with, e.g., JITs or other pieces of
> > code that are sensitive to misreported cache line sizes.
> >
> > So let's start trapping cache ID instructions, and expose the sanitised
> > version of CTR_EL0 to guests. Note that CTR_EL0 is treated as an invariant
> > to KVM user space, so update that part as well.
>
> I'm a bit uneasy with this. We rely on the kernel to perform this
> sanitization for userspace when absolutely required, and this is so far
> the exception.
>
> If we start trapping it unconditionally, we're likely to introduce
> performance regressions on system where there is no need to perform any
> form of sanitization.
>
> Could we instead only do this if ARM64_MISMATCHED_CACHE_TYPE is set?
>

I suppose. Note that the next patch relies on the trapping as well,
but we could enable that piece for only 32-bit guests.


> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/include/asm/kvm_arm.h |  3 +-
> >  arch/arm64/include/asm/sysreg.h  |  1 +
> >  arch/arm64/kvm/sys_regs.c        | 59 +++++++++++++++++++-
> >  3 files changed, 60 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> > index 6f602af5263c..628dcb0cfea3 100644
> > --- a/arch/arm64/include/asm/kvm_arm.h
> > +++ b/arch/arm64/include/asm/kvm_arm.h
> > @@ -81,9 +81,10 @@
> >   * IMO:              Override CPSR.I and enable signaling with VI
> >   * FMO:              Override CPSR.F and enable signaling with VF
> >   * SWIO:     Turn set/way invalidates into set/way clean+invalidate
> > + * TID2:     Trap cache identification instructions
> >   */
> >  #define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
> > -                      HCR_TVM | HCR_BSU_IS | HCR_FB | HCR_TAC | \
> > +                      HCR_TVM | HCR_BSU_IS | HCR_FB | HCR_TAC | HCR_TID2 | \
> >                        HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
> >                        HCR_FMO | HCR_IMO)
> >  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 842fb9572661..3b8e51874da4 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -342,6 +342,7 @@
> >
> >  #define SYS_CNTKCTL_EL1                      sys_reg(3, 0, 14, 1, 0)
> >
> > +#define SYS_CCSIDR_EL1                       sys_reg(3, 1, 0, 0, 0)
> >  #define SYS_CLIDR_EL1                        sys_reg(3, 1, 0, 0, 1)
> >  #define SYS_AIDR_EL1                 sys_reg(3, 1, 0, 0, 7)
> >
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 22fbbdbece3c..464e794b5bc5 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1140,6 +1140,49 @@ static int set_raz_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> >       return __set_id_reg(rd, uaddr, true);
> >  }
> >
> > +static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> > +                    const struct sys_reg_desc *r)
> > +{
> > +     if (p->is_write)
> > +             return write_to_read_only(vcpu, p, r);
> > +
> > +     p->regval = read_sanitised_ftr_reg(SYS_CTR_EL0);
> > +     return true;
> > +}
> > +
> > +static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> > +                      const struct sys_reg_desc *r)
> > +{
> > +     if (p->is_write)
> > +             return write_to_read_only(vcpu, p, r);
> > +
> > +     p->regval = read_sysreg(clidr_el1);
> > +     return true;
> > +}
> > +
> > +static bool access_csselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> > +                       const struct sys_reg_desc *r)
> > +{
> > +     if (p->is_write)
> > +             vcpu_write_sys_reg(vcpu, p->regval, r->reg);
> > +     else
> > +             p->regval = vcpu_read_sys_reg(vcpu, r->reg);
> > +     return true;
> > +}
> > +
> > +static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> > +                       const struct sys_reg_desc *r)
> > +{
> > +     u32 csselr;
> > +
> > +     if (p->is_write)
> > +             return write_to_read_only(vcpu, p, r);
> > +
> > +     csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
> > +     p->regval = get_ccsidr(csselr);
> > +     return true;
> > +}
> > +
> >  /* sys_reg_desc initialiser for known cpufeature ID registers */
> >  #define ID_SANITISED(name) {                 \
> >       SYS_DESC(SYS_##name),                   \
> > @@ -1357,7 +1400,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
> >
> >       { SYS_DESC(SYS_CNTKCTL_EL1), NULL, reset_val, CNTKCTL_EL1, 0},
> >
> > -     { SYS_DESC(SYS_CSSELR_EL1), NULL, reset_unknown, CSSELR_EL1 },
> > +     { SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
> > +     { SYS_DESC(SYS_CLIDR_EL1), access_clidr },
> > +     { SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
> > +     { SYS_DESC(SYS_CTR_EL0), access_ctr },
> >
> >       { SYS_DESC(SYS_PMCR_EL0), access_pmcr, reset_pmcr, },
> >       { SYS_DESC(SYS_PMCNTENSET_EL0), access_pmcnten, reset_unknown, PMCNTENSET_EL0 },
> > @@ -1657,6 +1703,7 @@ static const struct sys_reg_desc cp14_64_regs[] = {
> >   * register).
> >   */
> >  static const struct sys_reg_desc cp15_regs[] = {
> > +     { Op1( 0), CRn( 0), CRm( 0), Op2( 1), access_ctr },
> >       { Op1( 0), CRn( 1), CRm( 0), Op2( 0), access_vm_reg, NULL, c1_SCTLR },
> >       { Op1( 0), CRn( 2), CRm( 0), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
> >       { Op1( 0), CRn( 2), CRm( 0), Op2( 1), access_vm_reg, NULL, c2_TTBR1 },
> > @@ -1774,6 +1821,10 @@ static const struct sys_reg_desc cp15_regs[] = {
> >       PMU_PMEVTYPER(30),
> >       /* PMCCFILTR */
> >       { Op1(0), CRn(14), CRm(15), Op2(7), access_pmu_evtyper },
> > +
> > +     { Op1(1), CRn( 0), CRm( 0), Op2(0), access_ccsidr },
> > +     { Op1(1), CRn( 0), CRm( 0), Op2(1), access_clidr },
> > +     { Op1(2), CRn( 0), CRm( 0), Op2(0), access_csselr, NULL, c0_CSSELR },
> >  };
> >
> >  static const struct sys_reg_desc cp15_64_regs[] = {
> > @@ -2196,11 +2247,15 @@ static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
> >       }
> >
> >  FUNCTION_INVARIANT(midr_el1)
> > -FUNCTION_INVARIANT(ctr_el0)
> >  FUNCTION_INVARIANT(revidr_el1)
> >  FUNCTION_INVARIANT(clidr_el1)
> >  FUNCTION_INVARIANT(aidr_el1)
> >
> > +static void get_ctr_el0(struct kvm_vcpu *v, const struct sys_reg_desc *r)
> > +{
> > +     ((struct sys_reg_desc *)r)->val = read_sanitised_ftr_reg(SYS_CTR_EL0);
> > +}
> > +
> >  /* ->val is filled in by kvm_sys_reg_table_init() */
> >  static struct sys_reg_desc invariant_sys_regs[] = {
> >       { SYS_DESC(SYS_MIDR_EL1), NULL, get_midr_el1 },
> >
>
>
> --
> Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
