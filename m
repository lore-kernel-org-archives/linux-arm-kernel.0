Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281E9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:32:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D1220839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GzHQmaC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D1220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NbMbWZU3RoW00DCXiAUyhUcFLXUYkflppcaUTKmG3EU=; b=GzHQmaC2RIfDjZ
	dcwpPNhMhgEXosJENfM5qQgPaQMaTBzPSzE1GMtKLdmE4Riqmf9PFnSB7z6RqKQqvu8AkecL+UZmG
	zjolY2PXgd9nioMlhACdw6LMkewkJiJGrcD9m609oQf9rW0k0MVjt4lqmIGtf2SOuk6ssLaOS+Xjz
	7f2Xq40p25z4etOm4VwHebasYEwxcEMLanoxyBVcWB8Vto6AoUXZVcAbbJiQkQh/TZe8nE+2J0Kqi
	M4Lv3H/IzO4NKTAuCh5hSvX0ytbKPMFSf1QFq9D40i3gt6gpJTWkH8eXHHpCF2lXHbQEvie4G7gY4
	dA2BbGeEmgp3ot18t9NA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3gG-0001IS-GQ; Wed, 12 Dec 2018 12:32:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3g8-00010A-Vn
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 12:31:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1617A78;
 Wed, 12 Dec 2018 04:31:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87AF93F614;
 Wed, 12 Dec 2018 04:31:40 -0800 (PST)
Date: Wed, 12 Dec 2018 12:31:38 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v8 2/5] arm64: KVM: encapsulate kvm_cpu_context in
 kvm_host_data
Message-ID: <20181212123121.GI13393@e119886-lin.cambridge.arm.com>
References: <1544610573-28446-1-git-send-email-andrew.murray@arm.com>
 <1544610573-28446-3-git-send-email-andrew.murray@arm.com>
 <c31a1e2b-511a-4441-1fb2-8bf32691656f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c31a1e2b-511a-4441-1fb2-8bf32691656f@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_043153_037897_137E01F1 
X-CRM114-Status: GOOD (  21.07  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 10:37:54AM +0000, Suzuki K Poulose wrote:
> Hi Andrew,
> 
> On 12/12/2018 10:29, Andrew Murray wrote:
> > The virt/arm core allocates a kvm_cpu_context_t percpu, at present this is
> > a typedef to kvm_cpu_context and is used to store host cpu context. The
> > kvm_cpu_context structure is also used elsewhere to hold vcpu context.
> > In order to use the percpu to hold additional future host information we
> > encapsulate kvm_cpu_context in a new structure and rename the typedef and
> > percpu to match.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >   arch/arm/include/asm/kvm_host.h   |  8 ++++++--
> >   arch/arm64/include/asm/kvm_asm.h  |  4 ++--
> >   arch/arm64/include/asm/kvm_host.h | 15 ++++++++++-----
> >   arch/arm64/kernel/asm-offsets.c   |  2 +-
> >   virt/kvm/arm/arm.c                | 10 ++++++----
> >   5 files changed, 25 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> > index 79906ce..71645ba 100644
> > --- a/arch/arm/include/asm/kvm_host.h
> > +++ b/arch/arm/include/asm/kvm_host.h
> > @@ -145,7 +145,11 @@ struct kvm_cpu_context {
> >   	u32 cp15[NR_CP15_REGS];
> >   };
> > -typedef struct kvm_cpu_context kvm_cpu_context_t;
> > +struct kvm_host_data {
> > +	struct kvm_cpu_context host_ctxt;
> > +};
> > +
> > +typedef struct kvm_host_data kvm_host_data_t;
> >   struct kvm_vcpu_arch {
> >   	struct kvm_cpu_context ctxt;
> > @@ -163,7 +167,7 @@ struct kvm_vcpu_arch {
> >   	struct kvm_vcpu_fault_info fault;
> >   	/* Host FP context */
> > -	kvm_cpu_context_t *host_cpu_context;
> > +	struct kvm_cpu_context *host_cpu_context;
> >   	/* VGIC state */
> >   	struct vgic_cpu vgic_cpu;
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > index 102b5a5..6a9bfd4 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -102,12 +102,12 @@ extern u32 __init_stage2_translation(void);
> >   .endm
> >   .macro get_host_ctxt reg, tmp
> > -	hyp_adr_this_cpu \reg, kvm_host_cpu_state, \tmp
> > +	hyp_adr_this_cpu \reg, kvm_host_data, \tmp
> >   .endm
> >   .macro get_vcpu_ptr vcpu, ctxt
> >   	get_host_ctxt \ctxt, \vcpu
> > -	ldr	\vcpu, [\ctxt, #HOST_CONTEXT_VCPU]
> > +	ldr	\vcpu, [\ctxt, #HOST_DATA_VCPU]
> >   	kern_hyp_va	\vcpu
> >   .endm
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 1550192..1d3ca91 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -205,7 +205,12 @@ struct kvm_cpu_context {
> >   	struct kvm_vcpu *__hyp_running_vcpu;
> >   };
> > -typedef struct kvm_cpu_context kvm_cpu_context_t;
> > +struct kvm_host_data {
> > +	struct kvm_cpu_context host_ctxt;
> > +	struct kvm_pmu_events pmu_events;
> > +};
> > +
> 
> Unfortunately this would fail to build as we don't have the kvm_pmu_events
> defined in this patch and will break the git bisects.

Doh, this must have crept in when I was rebasing.

Andrew Murray

> 
> Otherwise looks good to me.
> 
> 
> Cheers
> Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
