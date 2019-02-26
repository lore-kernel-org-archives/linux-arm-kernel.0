Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD73C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153A2217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QN8FGV01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153A2217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EVyVfNCOxWMgWNmHOFXV30Yn+AKro50KRAP3GWDSv2M=; b=QN8FGV010drjkE
	9fCjeZusvv4b2rOIN4LWJEATuBwXu6Qq38H9Z3ChGw/0I1yCh/c+4cMxIIP1AL8VqgVTeHNxhnjQu
	lL6A5NLDlcuPK4wG4M5jQGKO05QlQqvX/mVMhplAN5KRRXVj8mqTZdTj5P3uI+ROtMWS+oKsa34rB
	rW6zhrQfu6ZcPh+pH6vI00p+qLn76DdnBDaYl9IEgZJ0Rrvx002vEpHaGzY7aUEevrn0H9v3pNUAr
	BjrGw68gAF0vPrbzGE8CzAjXN5qLu0AGHibdwk2iLNA7N/CmXNw3zaf8KcOvrAV0/2teh3pZ1ZSOk
	9D4gHeDT7GDPBowbbhOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybWP-0001c8-Nk; Tue, 26 Feb 2019 12:07:41 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybVk-0000on-2W
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:07:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47C48A78;
 Tue, 26 Feb 2019 04:06:59 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AFFA3F71D;
 Tue, 26 Feb 2019 04:06:57 -0800 (PST)
Date: Tue, 26 Feb 2019 12:06:55 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v5 07/26] arm64/sve: Clarify role of the VQ map
 maintenance functions
Message-ID: <20190226120654.GJ3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-8-git-send-email-Dave.Martin@arm.com>
 <f8a56d62-3b45-e369-ed4a-187895a178c0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8a56d62-3b45-e369-ed4a-187895a178c0@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040700_303463_2B42731E 
X-CRM114-Status: GOOD (  24.54  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 11:43:24AM +0000, Julien Thierry wrote:
> 
> 
> On 18/02/2019 19:52, Dave Martin wrote:
> > The roles of sve_init_vq_map(), sve_update_vq_map() and
> > sve_verify_vq_map() are highly non-obvious to anyone who has not dug
> > through cpufeatures.c in detail.
> > 
> > Since the way these functions interact with each other is more
> > important here than a full understanding of the cpufeatures code, this
> > patch adds comments to make the functions' roles clearer.
> > 
> > No functional change.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/kernel/fpsimd.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > index 64729e2..92c2331 100644
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -647,6 +647,10 @@ static void sve_probe_vqs(DECLARE_BITMAP(map, SVE_VQ_MAX))
> >  	}
> >  }
> >  
> > +/*
> > + * Initialise the set of known supported VQs for the boot CPU.
> > + * This is called during kernel boot, before secondary CPUs are brought up.
> > + */
> >  void __init sve_init_vq_map(void)
> >  {
> >  	sve_probe_vqs(sve_vq_map);
> > @@ -656,6 +660,7 @@ void __init sve_init_vq_map(void)
> >  /*
> >   * If we haven't committed to the set of supported VQs yet, filter out
> >   * those not supported by the current CPU.
> > + * This function is called during the bring-up of early secondary CPUs only.
> >   */
> >  void sve_update_vq_map(void)
> >  {
> > @@ -666,7 +671,10 @@ void sve_update_vq_map(void)
> >  	bitmap_or(sve_vq_partial_map, sve_vq_partial_map, tmp_map, SVE_VQ_MAX);
> >  }
> >  
> > -/* Check whether the current CPU supports all VQs in the committed set */
> > +/*
> > + * Check whether the current CPU supports all VQs in the committed set.
> > + * This function is called during the bring-up of late secondary CPUs only.
> 
> Oh I see, this is for late CPUs. So you can probably disregard my
> comment on the warning in the previous patch.
> 
> If you respin this series, I feel it would be more useful to have this
> patch before the current patch 6.

Agreed, I'll swap them over.  Looking at the two patches, I'm not sure
how they ended up this way round.  It may have been an unintended side-
effect of a previous rebase.

> Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Thanks
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
