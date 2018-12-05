Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F131CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:11:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5052082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pHX1ED6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5052082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MHqGur1zY89KTDWoGSvKYpVezqtG9TDXsBGAj0eDwOg=; b=pHX1ED6QrYuXI/
	zsrMU3e6MYTHFYPuzj672+tiSLQ0mppuvWT5lM/UUmWROxc9wj6aFhWrRJO7NTDzPOb3TYWGg7laN
	GR5/sFht2pmjGwzmM5ihqKqp3hUDhHFtjqL2x/E6605u3bBNf41iXHwmvuQHjPB+Kn/ljjVu3d483
	4iEyjIv9fblAZVnTnK5rj+jQWG5OFg04hypI+lqJLMU9DifWh0SQqby3NmnsmyjLQBBBJMy3eiNxj
	DXUbIG6u1FKRsXxKoguvVLLi5tCjSlcbSngWaNGe1sStmK2j4fAHy6pofe9YDFlGajT+ReTPvv5yZ
	ywEDwOB+/+u/m4EX8CyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUXti-0007jy-2f; Wed, 05 Dec 2018 14:11:30 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUXtb-0007j8-3c
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 14:11:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 942E880D;
 Wed,  5 Dec 2018 06:11:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B6D23F59C;
 Wed,  5 Dec 2018 06:11:10 -0800 (PST)
Date: Wed, 5 Dec 2018 14:11:08 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v4 4/4] arm64: KVM: Enable support for :G/:H perf event
 modifiers
Message-ID: <20181205141108.GB26114@e119886-lin.cambridge.arm.com>
References: <1543935500-23207-1-git-send-email-andrew.murray@arm.com>
 <1543935500-23207-5-git-send-email-andrew.murray@arm.com>
 <4ddb1abb-441d-b504-790d-f2bc45c52db9@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ddb1abb-441d-b504-790d-f2bc45c52db9@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_061123_154818_7FDA9F93 
X-CRM114-Status: GOOD (  25.35  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 04:16:01PM +0000, Julien Thierry wrote:
> Hi Andrew,
> 
> On 04/12/18 14:58, Andrew Murray wrote:
> > Enable/disable event counters as appropriate when entering and exiting
> > the guest to enable support for guest or host only event counting.
> > 
> > For both VHE and non-VHE we switch the counters between host/guest at
> > EL2. EL2 is filtered out by the PMU when we are using the :G modifier.
> > 
> > The PMU may be on when we change which counters are enabled however
> > we avoid adding an isb as we instead rely on existing context
> > synchronisation events: the isb in kvm_arm_vhe_guest_exit for VHE and
> > the eret from the hvc in kvm_call_hyp.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  arch/arm64/kvm/hyp/switch.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> > index d496ef5..5e03921 100644
> > --- a/arch/arm64/kvm/hyp/switch.c
> > +++ b/arch/arm64/kvm/hyp/switch.c
> > @@ -373,6 +373,35 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
> >  	return true;
> >  }
> >  
> > +static bool __hyp_text __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)
> > +{
> > +	u32 host = host_ctxt->events_host;
> > +	u32 guest = host_ctxt->events_guest;
> > +
> > +	if (host == guest)
> > +		return false;
> > +
> > +	if (host)
> > +		write_sysreg(host, pmcntenclr_el0);
> 
> Nit:
> Instead of clearing host counters we could clear non-guest counters:
> 
> 	u32 clear_events = host_ctxt->events_hosts & ~guest;
> 		
> 	if (clear_events)
> 		write_sysreg(clear_events, pmcntenclr_el0);
> 
> Don't know if it makes a lot of difference.

In the case where an event is enabled for both host and guest, your
suggested change prevents us from unnecessarily clearing and then setting
the same bit. Thus is may prevent a call to write_sysreg.

> 
> > +
> > +	if (guest)
> > +		write_sysreg(guest, pmcntenset_el0);
> > +
> > +	return (host || guest);
> 
> We know this is true. If both (host == 0 && guest == 0) then (host ==
> guest) meaning we returned false.

Doh.

> 
> 
> > +}
> > +
> > +static void __hyp_text __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
> > +{
> > +	u32 host = host_ctxt->events_host;
> > +	u32 guest = host_ctxt->events_guest;
> > +
> > +	if (guest)
> > +		write_sysreg(guest, pmcntenclr_el0);
> 
> Nit:
> Same as above, we could just clear the counters that are exclusive to
> the guest.

Thanks,

Andrew Murray

> 
> Cheers,
> 
> -- 
> Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
