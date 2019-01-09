Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC240C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:14:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6F82064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XYDtRR2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6F82064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0AG9esQK1/7UHu2h8HYl4d0HUpE08+yUw1uzDdRljbw=; b=XYDtRR2yyEyz9r
	JyjEqZ3HzuMbFjIOJuTK2bCW+9N5ERDiYBrSrolTgFnB4717PSciulkDWffMp03R8uPBu1pRW27No
	mLwijKNn/G8Sy44OvLOmAzcsEVDtI3b3hsQhfJHIkM6KQDxSB3i/6IsgQNFGtFG+iZJFSwF0ZfwlP
	wLOku4wHZsouXgWbB1jcCqaIR90tyyupwJ4B9UsBh/EaxGuXhQzGIgh5RRol/LRmYjkLAqe5C0hhb
	u2G4p1WoEWnp0rzTr9A7K6yLf2tm83AGR9TkeSVOaZvcK7BBFQYjdn/hZC+n2Y7+xI63WmymCmzzB
	yPgCaIhJeTDWfFWCv5PQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghAsD-0008W1-Jt; Wed, 09 Jan 2019 10:14:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghAs6-0008Uj-RF
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:14:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92A36165C
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  9 Jan 2019 02:14:02 -0800 (PST)
Received: from mail-io1-f52.google.com (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 781EF3F70D
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  9 Jan 2019 02:14:02 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id s22so5572395ioc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 02:14:02 -0800 (PST)
X-Gm-Message-State: AJcUukcFArVaB2N0jrAH6c0Mm647abF3v41DSHyGpVc/jc3YakImFJjU
 JlNWJhdUiIsqKc3XMkNGlQ/wbR97avGsDcv6d5o=
X-Google-Smtp-Source: ALg8bN4rS9je0ssN9b9Lgrez3YdeI51sDvjbjeHJqVX3jBo8reJXIsHK0pDA/yf1dPMY/68kf+ccQV8QOB02LmhtxBA=
X-Received: by 2002:a6b:b717:: with SMTP id h23mr3180991iof.14.1547028841575; 
 Wed, 09 Jan 2019 02:14:01 -0800 (PST)
MIME-Version: 1.0
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
 <1545119810-12182-4-git-send-email-amit.kachhap@arm.com>
 <49474d5f-6f4e-b57d-4b45-94c16d85136c@arm.com>
In-Reply-To: <49474d5f-6f4e-b57d-4b45-94c16d85136c@arm.com>
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Date: Wed, 9 Jan 2019 15:43:50 +0530
X-Gmail-Original-Message-ID: <CADGdYn7t7-vXNmQxBUxnCWq5UxG8uGJraCnRxjDgwvC0V6y8jA@mail.gmail.com>
Message-ID: <CADGdYn7t7-vXNmQxBUxnCWq5UxG8uGJraCnRxjDgwvC0V6y8jA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] arm64/kvm: add a userspace option to enable
 pointer authentication
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_021403_111994_3FF39896 
X-CRM114-Status: GOOD (  24.39  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Kristina Martsenko <kristina.martsenko@arm.com>,
 Dave Martin <Dave.Martin@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 kvmarm@lists.cs.columbia.edu, LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Sat, Jan 5, 2019 at 12:05 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Amit,
>
> On 18/12/2018 07:56, Amit Daniel Kachhap wrote:
> > This feature will allow the KVM guest to allow the handling of
> > pointer authentication instructions or to treat them as undefined
> > if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
> > supply this parameter instead of creating a new API.
> >
> > A new register is not created to pass this parameter via
> > SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
> > supplied is enough to select this feature.
>
> What is the motivation for doing this? Doesn't ptrauth 'just' need turning on?
> It doesn't need additional setup to be useable, or rely on some qemu support to
> work properly. There isn't any hidden state that can't be migrated in the usual way.
> Is it just because we don't want to commit to the ABI?
This allows migration of guest to non pointer authenticated supported
systems and hides the extra ptrauth registers.
Basically this suggestion was given by Christoffer
(https://lore.kernel.org/lkml/20180206123847.GY21802@cbox/).
 I don't have strong reservation to have this option and can be
dropped if this doesn't make sense.
>
>
> > diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> > index 5baca42..8c0f338 100644
> > --- a/Documentation/arm64/pointer-authentication.txt
> > +++ b/Documentation/arm64/pointer-authentication.txt
> > @@ -87,7 +87,8 @@ used to get and set the keys for a thread.
> >  Virtualization
> >  --------------
> >
> > -Pointer authentication is not currently supported in KVM guests. KVM
> > -will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
> > -the feature will result in an UNDEFINED exception being injected into
> > -the guest.
> > +Pointer authentication is enabled in KVM guest when virtual machine is
> > +created by passing a flag (KVM_ARM_VCPU_PTRAUTH) requesting this feature
> > +to be enabled. Without this flag, pointer authentication is not enabled
> > +in KVM guests and attempted use of the feature will result in an UNDEFINED
> > +exception being injected into the guest.
>
> > diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> > index cd209f7..e20583a 100644
> > --- a/Documentation/virtual/kvm/api.txt
> > +++ b/Documentation/virtual/kvm/api.txt
> > @@ -2634,6 +2634,10 @@ Possible features:
> >         Depends on KVM_CAP_ARM_PSCI_0_2.
> >       - KVM_ARM_VCPU_PMU_V3: Emulate PMUv3 for the CPU.
> >         Depends on KVM_CAP_ARM_PMU_V3.
> > +     - KVM_ARM_VCPU_PTRAUTH: Emulate Pointer authentication for the CPU.
> > +       Depends on KVM_CAP_ARM_PTRAUTH and only on arm64 architecture. If
> > +       set, then the KVM guest allows the execution of pointer authentication
> > +       instructions or treats them as undefined if not set.
>
> > diff --git a/arch/arm64/kvm/hyp/ptrauth-sr.c b/arch/arm64/kvm/hyp/ptrauth-sr.c
> > index 1bfaf74..03999bb 100644
> > --- a/arch/arm64/kvm/hyp/ptrauth-sr.c
> > +++ b/arch/arm64/kvm/hyp/ptrauth-sr.c
> > @@ -71,3 +71,19 @@ void __hyp_text __ptrauth_switch_to_host(struct kvm_vcpu *vcpu,
> >       __ptrauth_save_state(guest_ctxt);
> >       __ptrauth_restore_state(host_ctxt);
> >  }
> > +
> > +/**
> > + * kvm_arm_vcpu_ptrauth_allowed - checks if ptrauth feature is present in vcpu
> > + *
> > + * @vcpu: The VCPU pointer
> > + *
> > + * This function will be used to enable/disable ptrauth in guest as configured
> > + * by the KVM userspace API.
> > + */
> > +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
> > +{
> > +     if (test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features))
> > +             return true;
> > +     else
> > +             return false;
> > +}
>
> Can't you return the result of test_bit() directly?
ok.
>
>
> Thanks,
>
> James

//Amit

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
