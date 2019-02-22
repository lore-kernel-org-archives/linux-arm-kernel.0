Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C88C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:49:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C822070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BBfz2oc9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDxZ8opA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C822070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xwBJJLcNK/CTzzC5bJxR9uqXN2CyVfOPpK72/3RDP9I=; b=BBfz2oc9dF9nk7
	6OWzJ6bXCtIK5PaHnm6/nB0Ytht9xiGH6Ol6oP4tcDZ5ojAMoQZTRRun+L3JHUK1IIVnUPqUehQVi
	DbgefHQWLve+gI/Q6KEWsvbVSbrJv2BUhl1npg+HEQ8n1rPgDJ2vwjpVkUY2KOQ5YU7nstfbi26tT
	oXwMEiBgyxr62F/JOU25oXMzcRQ8T75bBSUYF3MU6vj5Y5MlOnQ6hT9qZ/gSDcZMz5qSt2iUc6Ib1
	kUYSfvyKTeVTtEZJ3H0ZGgM1b6YrWd4cUTyy4vXziFB/VabBFHfEhMZYE/7UIyvZVd/3zuCT6YHbp
	B+oSodluRPtebvZJ8+Dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxAGS-0005BH-DS; Fri, 22 Feb 2019 12:49:16 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAGP-0005Ay-Np
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:49:15 +0000
Received: by mail-pl1-x642.google.com with SMTP id p19so1086968plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2ZuHTfjMiUn5POnCC62OOdZMQ1+YLeHPuX4GNryx5p0=;
 b=sDxZ8opAsRqHnEGcc5zUJdNAIbZUChU+IrClH/l0CcwkGeJvaXPkH855wRDqnJkhIK
 Jog81L0flExihXLNL+P9L0aU4Ic+/NqWuyBLOGWAj8kXvxydp3bK0TGl+bvCrKzFZnLY
 lbxBBCo0ectmSEpKgKqrAAsqM0lejnFI4eX11xT+vcOd16BI5Y/epRoQGSX7bltippvf
 jqU0fioQoU+9P3r6UkYebQ918vaUVC2ir/yZ50GEIgIX3qPiRK8+RTLvn19EktHIX6lo
 C0MfSifQ6+TJtVDNVhXiHZ6v/cSRkt5n2BmTkn24yHj0f1Hc/HPAiMbTrgNZ/mmlCRjW
 Kl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2ZuHTfjMiUn5POnCC62OOdZMQ1+YLeHPuX4GNryx5p0=;
 b=Bz6Jdbs/pHi7CHcWo7wg3QbEYpAEiQ9xAEy3VLZyvxusTobZLuBAdc5JmoiLcYNg5y
 1N45OVQwYamnydUaBdQrILI3bTm+WtszZOnbwPmnpeMw14BhEU3THD+/BJ80NShT54Dz
 /ZJ0EmVHlu6vneGkIi3VpMB06HUUBnE3xx0AV5Vm7gXyl9I0P+xHB2anxtJodVMTJEyO
 T7fDpqjYOtf6rFzMjaSnWBFxbgvO+3Hdp6zHVx7J+0oSu6ai06vEye0/ec0NMjmaBuy1
 YUxZ6VcVxteRzEd34SMookxS+ua1fmFDpFsrpGASTn20G1Kgow/qJOWyA08iXsZrR743
 +ilA==
X-Gm-Message-State: AHQUAubQEQ/6b0z6hfjvwAim3jdimLmvZpmEb6GQS93yGM7fGYbYEr6y
 EZrabEFM/4rr7wBZURdBpC0IDg==
X-Google-Smtp-Source: AHgI3Ib5nA3CHVtPPyREXJkzcUbzhlJLLiGdRxpnFZKeAP8HtoG80Xw4CfwTOSdN8JB0ayb3LsAAQA==
X-Received: by 2002:a17:902:3381:: with SMTP id
 b1mr4080028plc.13.1550839752737; 
 Fri, 22 Feb 2019 04:49:12 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1195-158.members.linode.com.
 [45.79.96.158])
 by smtp.gmail.com with ESMTPSA id 186sm2964629pga.36.2019.02.22.04.49.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 04:49:11 -0800 (PST)
Date: Fri, 22 Feb 2019 20:49:06 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v1 2/4] KVM: arm/arm64: vgic: Improve comment on
 kvm_vgic_inject_irq
Message-ID: <20190222124906.GB845@leoy-ThinkPad-X240s>
References: <20190222082327.3312-1-leo.yan@linaro.org>
 <20190222082327.3312-3-leo.yan@linaro.org>
 <20190222083756.359523ca@why.wild-wind.fr.eu.org>
 <20190222085439.GA845@leoy-ThinkPad-X240s>
 <20190222093923.09e36583@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222093923.09e36583@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_044913_784625_A94C2293 
X-CRM114-Status: GOOD (  24.68  )
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

On Fri, Feb 22, 2019 at 09:39:23AM +0000, Marc Zyngier wrote:

[...]

> > > > diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> > > > index 7cfdfbc910e0..79fe64c15051 100644
> > > > --- a/virt/kvm/arm/vgic/vgic.c
> > > > +++ b/virt/kvm/arm/vgic/vgic.c
> > > > @@ -394,7 +394,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
> > > >  /**
> > > >   * kvm_vgic_inject_irq - Inject an IRQ from a device to the vgic
> > > >   * @kvm:     The VM structure pointer
> > > > - * @cpuid:   The CPU for PPIs
> > > > + * @cpuid:   The CPU for PPIs and SPIs
> > > >   * @intid:   The INTID to inject a new state to.
> > > >   * @level:   Edge-triggered:  true:  to trigger the interrupt
> > > >   *			      false: to ignore the call  
> > > 
> > > What does the CPU mean for SPIs? By definition, the routing of an SPI
> > > is defined by the distributor configuration.  
> > 
> > In the code, KVM injects PPIs by specifying CPU id, so that every PPI
> > is bound to specific target CPU.  But for SPIs, it always pass '0' for
> > cpuid, from my understanding this means VM will set interrupt affinity
> > to VCPU0 by default; in theory we also can set different cpuid for
> > SPIs so that the SPIs also can be handled by other secondary VCPUs;
> > this is why I think @cpuid also can be used by SPIs.
> 
> SPIs are not hardcoded to vcpu0. This would be a gross violation of the
> architecture. To convince yourself of this, just run a guest:
> 
> root@unassigned-hostname:~# cat /proc/interrupts 
>            CPU0       CPU1       
>   2:       7315       7353     GIC-0  27 Level     arch_timer
>   4:        158          0     GIC-0  33 Level     uart-pl011
>  42:          0          0     GIC-0  23 Level     arm-pmu
>  43:          0          0     pl061   3 Edge      ACPI:Event
>  44:          0          0       MSI 32768 Edge      virtio1-config
>  45:      10476          0       MSI 32769 Edge      virtio1-req.0
>  46:          0          0       MSI 16384 Edge      virtio0-config
>  47:          3         10       MSI 16385 Edge      virtio0-input.0
> [...]
> 
> On this last line, you can see an SPI being routed to both of these
> vcpus.
> 
> I urge you to read the code further, and understand that for any other
> interrupt class, the cpuid parameter is *ignored*. Yes, we pass zero in
> that case. We could also pass an approximation of PI with the same
> effect.

Very appreciate for the elaborated example; will read the code
furthermore.

> The interrupt affinity is either defined by the distributor
> configuration (SPIs) or the ITS configuration (LPIs).

Given to the up example, I am struggling to understand how you can set
the interrupt affinity for virtio device.

Do you set the physical interrupt affinity to CPU0/1 in host OS and
forward it to guest OS?  Or set interrupt affinity in guest OS (I
tried on Juno board to set irq affinity in guest OS from
'/proc/irq/xxx/smp_affinity' but failed)?   Or this is accomplished by
user space tool (lkvm or qemu)?

Sorry if I am asking a stupid question :)

Thanks,
Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
