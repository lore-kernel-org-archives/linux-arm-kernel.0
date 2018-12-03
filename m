Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE5DC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:06:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFE420881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ggUe2+cP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFE420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OSKH5gWZ1fofNuPJsdGxcsxJnf+q/zQxkUXbKGbWnVs=; b=ggUe2+cP1/Hc7f
	m4s0WotD6lldlCYq0ZbcxmTsGdUDfpJVN78S6U8PwcLLkVvv5f7p+4WqmHbrFBS6/MMYNZcbM6ATD
	HIrZbDsImeerYqNGvMuZI4HMmTQ02WzUcvNvR3bCOBBtm41nbMdRE8NiNZlK54Rvpkp0DTwg5LRsE
	DWIYbaF4CWelaVxzIRzBGDXol8nl6+cQTO137QN7Rhk/TYIUhMzb8PlZYsJBMT7CdiDOZHkMwqdPc
	FcnGPz/HLVXPe8bZ6EzGXQkLpN/f89xdF0WYYGB00ME78HXrnmMeeY3rILs0pvWGnJTqJH/6f1pUT
	bVV3Dt9boklO46HByDZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpnZ-0004Lh-P0; Mon, 03 Dec 2018 15:06:13 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpnT-0004JT-3u
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:06:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 103561682;
 Mon,  3 Dec 2018 07:05:55 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5B03F5AF;
 Mon,  3 Dec 2018 07:05:54 -0800 (PST)
Date: Mon, 3 Dec 2018 15:05:52 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 2/4] arm64: KVM: add accessors to track guest/host
 only counters
Message-ID: <20181203150551.GC16311@e119886-lin.cambridge.arm.com>
References: <1542885950-23816-3-git-send-email-andrew.murray@arm.com>
 <20181203143114.GA26831@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203143114.GA26831@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_070607_162754_867B3EBF 
X-CRM114-Status: GOOD (  19.74  )
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
 Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 02:31:14PM +0000, Will Deacon wrote:
> On Thu, Nov 22, 2018 at 11:25:48AM +0000, Andrew Murray wrote:
> > In order to effeciently enable/disable guest/host only perf counters
> > at guest entry/exit we add bitfields to kvm_cpu_context for guest and
> > host only events as well as accessors for updating them.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 1550192..4a828eb 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -203,6 +203,8 @@ struct kvm_cpu_context {
> >  	};
> >  
> >  	struct kvm_vcpu *__hyp_running_vcpu;
> > +	u32 events_host_only;
> > +	u32 events_guest_only;
> >  };
> >  
> >  typedef struct kvm_cpu_context kvm_cpu_context_t;
> > @@ -472,6 +474,24 @@ static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
> >  {
> >  	return kvm_arch_vcpu_run_map_fp(vcpu);
> >  }
> > +static inline void kvm_clr_set_host_pmu_events(u32 clr, u32 set)
> > +{
> > +	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
> > +
> > +	ctx->events_host_only &= ~clr;
> > +	ctx->events_host_only |= set;
> > +}
> 
> Do you actually need this clr/set function, or can you just use the
> facilities provided by bitfield.h at the callsites?

This modifies events_{host|guest}_only which is conditionally defined
(CONFIG_KVM) yet used by arch/arm64/kernel/perf_events which is also
conditionally defined (CONFIG_HW_PERF_EVENTS). By moving this away
from the callsite we avoid a load of horrible #ifdef's and allow this
function to become a nop when KVM isn't enabled.

Is there value in updating this function to use set_bit/clear_bit
functions in bitops/atomic.h ?

Andrew Murray

> 
> Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
