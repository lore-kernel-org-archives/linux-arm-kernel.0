Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2BDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:54:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6223207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZgWRpri7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBcp3uyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6223207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9y7PyIJwsQJaJqUwbeaDi54WoE8FAWXH5JTgY/ma7ZU=; b=ZgWRpri7jgCWkX
	4bE6aLWM0il4ak620ZVLTOmnvU65JnIOYr/i17ta1Fl2akzJUFv0qM4EKUVIQ0GecxfnEQxzmYz8H
	hY2U17P1IoKviuzRyJJAcURTHA4tt1SfKStA+mryXQ7zOnu21FkmUcUwc2mj3+dUt0WkNHx7MAwN3
	R+LmzouMXDXIpAOM/D79EaHUK6A8Ama/XWESSGuHuniL9ag0VM/AUYL3jFBkoog595Lsn7akFBqx7
	QWS+FFcaz0T35JMOK6LIhEozGQT/ltSftlGSLPfZGQuOt6B3SCFT1Uk2DzpVXMhJdHg4ABSgoN2QZ
	tX/30DzRgc5YScin7IZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx6ba-0008PR-Fk; Fri, 22 Feb 2019 08:54:50 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx6bX-0008Oy-3P
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:54:48 +0000
Received: by mail-pl1-x642.google.com with SMTP id o6so778119pls.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 00:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uxO3rqEEADR3WQe9mC23xHQlYHLfbl+k4Gnzt0xgl1s=;
 b=CBcp3uyBljJ6HBaL6r0erUswx+Juy+YXQUsxbzuGqQZNmHfax5Nk1Vj9ehos+Eh9nP
 kIl84Bn6ksRbzpusJeMGqb1UXw/ltx2tCT/l+FYSYy0iDTQ5LvA1CICmx5XgdGOce1fM
 Uwi2sY7aA10Z8DPgzA/9Aq0Q5bEXl48y/IXIZAYctF8TaPz5X297QFetghLHeEgiCOvR
 jx05wvqYlgeU5Tx/EFJymHHVhJ2Y7GItfGqcsuoSKc02qmuN3ohVnL/378IclnGiCU6m
 IKsunOHjMW86EBDeaM+tdKsFGPVdjU8d1zzs+yH3XgnQZ1wbIrkepgCWnDVrSo4WwBXE
 Hytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uxO3rqEEADR3WQe9mC23xHQlYHLfbl+k4Gnzt0xgl1s=;
 b=BAh6GhmiLct0F2bFM2EhmY8QUfNjbAAdKJPM4EAu3cRwS+F09dlCeVs7IxKVy4JEp7
 HqmhKRxvq9o32iySS6LKZSWaNAuKmi1O3/8kbPenoeQJwplEeLLZ9rJ/arx0ZRblA6gE
 2QwPmQnWrGcC0APyN+wGSncvaLpZTG8Qkswp90qRLDlesKVMU71pd7ZO2tiEQVfW12RW
 yoekR0HFRCPB9p2Ge2dTtZJZMjBI4fJBpv2Czgyt4Fbr1v+dJQIEJkGzGwJoktWYWMu2
 Hzr0gTsj1hyPsTUS6ZYVRV7CxvCJTLrxqRY26GaY7mBMxdCwNWxi3euzclsUki8EKpfr
 rbWA==
X-Gm-Message-State: AHQUAua7uTcYzKjNJnjtBx76bqMCBEJJ/yxMSgjZNwnps2XS+gUfTMDu
 1OVEO4HH9ErdRZhIOJUkeSSXOw==
X-Google-Smtp-Source: AHgI3IbnIdFmrM5jYh7c3WzXuTNCBWnd2jz6+trum+1vQ3ICgTnMHOPqSVHFEnf+FQ7cxNYdNQvXCw==
X-Received: by 2002:a17:902:aa8d:: with SMTP id
 d13mr3067953plr.293.1550825686445; 
 Fri, 22 Feb 2019 00:54:46 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1195-158.members.linode.com.
 [45.79.96.158])
 by smtp.gmail.com with ESMTPSA id d188sm1738482pfg.98.2019.02.22.00.54.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 00:54:45 -0800 (PST)
Date: Fri, 22 Feb 2019 16:54:39 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v1 2/4] KVM: arm/arm64: vgic: Improve comment on
 kvm_vgic_inject_irq
Message-ID: <20190222085439.GA845@leoy-ThinkPad-X240s>
References: <20190222082327.3312-1-leo.yan@linaro.org>
 <20190222082327.3312-3-leo.yan@linaro.org>
 <20190222083756.359523ca@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222083756.359523ca@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_005447_143957_9B2ED5B8 
X-CRM114-Status: GOOD (  21.48  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 Jun Yao <yaojun8558363@gmail.com>, James Morse <james.morse@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On Fri, Feb 22, 2019 at 08:37:56AM +0000, Marc Zyngier wrote:
> On Fri, 22 Feb 2019 16:23:24 +0800
> Leo Yan <leo.yan@linaro.org> wrote:
> 
> > The function kvm_vgic_inject_irq() is not only used by PPIs but also can
> > be used to inject interrupt for SPIs; this patch improves comment for
> > argument @cpuid to reflect support SPIs as well.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  virt/kvm/arm/vgic/vgic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> > index 7cfdfbc910e0..79fe64c15051 100644
> > --- a/virt/kvm/arm/vgic/vgic.c
> > +++ b/virt/kvm/arm/vgic/vgic.c
> > @@ -394,7 +394,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
> >  /**
> >   * kvm_vgic_inject_irq - Inject an IRQ from a device to the vgic
> >   * @kvm:     The VM structure pointer
> > - * @cpuid:   The CPU for PPIs
> > + * @cpuid:   The CPU for PPIs and SPIs
> >   * @intid:   The INTID to inject a new state to.
> >   * @level:   Edge-triggered:  true:  to trigger the interrupt
> >   *			      false: to ignore the call
> 
> What does the CPU mean for SPIs? By definition, the routing of an SPI
> is defined by the distributor configuration.

In the code, KVM injects PPIs by specifying CPU id, so that every PPI
is bound to specific target CPU.  But for SPIs, it always pass '0' for
cpuid, from my understanding this means VM will set interrupt affinity
to VCPU0 by default; in theory we also can set different cpuid for
SPIs so that the SPIs also can be handled by other secondary VCPUs;
this is why I think @cpuid also can be used by SPIs.

> And what about LPIs? SGIs?

TBH, I don't know LPIs and didn't use it before.

For SGIs, I read the code, it uses different path to handle SGI in KVM
so kvm_vgic_inject_irq() is not used for SGIs.

> I'm afraid you've misunderstood what cpuid is for.

Thanks for guidance.

Thanks,
Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
