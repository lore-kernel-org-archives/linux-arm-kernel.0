Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DABC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:42:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F032077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jz79wx1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F032077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zvnsbjcgIlmiqGRB79K8uR2t18c5AY7OqS9mPhbMwGQ=; b=jz79wx1IccH3iC
	/9m+IBnw1eDVG6aGoUnTVtR4cs9CaXPpc3gIrF8iiulDZoS/DkOOyGlb6rGsLidV71ow5EMiWNgJn
	jyhNkqGWk93j5Wpe+riyu5895UBeJRYhnuLXiLqqILEoE+NDXMKFvGZY/MqRcRMUvB6+uWZmAHxG3
	9FLIL4baEOoGbFtY9bgwgiCrTUTm9lzHclulCzCTxim91IZZn3I3n9xkqquj8jseAbYn0ZW02d2Bb
	0so+jm2gPdrELqDavCiDxIktD7ai+izA8aPHqFwDr0ryF/Pd6gkZyYxe7Gks9tS4Sx1nqh/EOa8HJ
	uxNoakHptGlf6faSFW8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7Ls-0003pn-NN; Fri, 22 Feb 2019 09:42:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7Li-0003gQ-6V
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:42:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB41E80D;
 Fri, 22 Feb 2019 01:42:29 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15D973F703;
 Fri, 22 Feb 2019 01:42:27 -0800 (PST)
Date: Fri, 22 Feb 2019 09:42:24 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH -next] KVM: arm/arm64: Remove unused timer variable
Message-ID: <20190222094224.07535ee6@why.wild-wind.fr.eu.org>
In-Reply-To: <ea7693de-e800-1279-92ae-9844ff9cbf23@arm.com>
References: <1550817269-57405-1-git-send-email-zhangshaokun@hisilicon.com>
 <ea7693de-e800-1279-92ae-9844ff9cbf23@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_014230_240107_EB58B44A 
X-CRM114-Status: GOOD (  18.62  )
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
Cc: Suzuki K Pouloze <suzuki.poulose@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Shaokun Zhang <zhangshaokun@hisilicon.com>, James Morse <james.morse@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 22 Feb 2019 08:49:42 +0000
Julien Thierry <julien.thierry@arm.com> wrote:

> Hi Shaokun,
> 
> On 22/02/2019 06:34, Shaokun Zhang wrote:
> > The 'timer' local variable became unused after commit bee038a67487
> > ("KVM: arm/arm64: Rework the timer code to use a timer_map").
> > Remove it to avoid [-Wunused-but-set-variable] warning.
> > 
> > Cc: Christoffer Dall <christoffer.dall@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Julien Thierry <julien.thierry@arm.com>
> > Cc: Suzuki K Pouloze <suzuki.poulose@arm.com>
> > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > ---
> >  virt/kvm/arm/arch_timer.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> > index af8f2f1d01cc..3417f2dbc366 100644
> > --- a/virt/kvm/arm/arch_timer.c
> > +++ b/virt/kvm/arm/arch_timer.c
> > @@ -236,14 +236,12 @@ static enum hrtimer_restart kvm_hrtimer_expire(struct hrtimer *hrt)
> >  
> >  static bool kvm_timer_should_fire(struct arch_timer_context *timer_ctx)
> >  {
> > -	struct arch_timer_cpu *timer;
> >  	enum kvm_arch_timers index;
> >  	u64 cval, now;
> >  
> >  	if (!timer_ctx)
> >  		return false;
> >  
> > -	timer = vcpu_timer(timer_ctx->vcpu);
> >  	index = arch_timer_ctx_index(timer_ctx);
> >  
> >  	if (timer_ctx->loaded) {  
> 
> This seems to be a consequence of moving the loaded state from
> arch_timer_cpu to arch_timer_context. Thanks for fixing it.
> 
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Applied to -next.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
