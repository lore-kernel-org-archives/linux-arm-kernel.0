Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FFCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:01:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB1D21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nUuiHtGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB1D21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cKLKc6LdlRH+6t13EooVENDMM+TFWvXvvrqdTeLoKcE=; b=nUuiHtGfWGZBMw
	oPuTzRpRF9dym1Ri0pV9QvGRkVZ1Rh+LtTPVw+WjENuw9nLLxfyfo3uXUMSoQwu/+vkMSyU6x5g5a
	kQ9nziqMQagyN8gUP+ZITbkGAywbLW7bmENNE/d7OpuT61w/X45ptYw6Vzj/Un7+rKrCVH0EIZHmP
	Wt/kJQjjYUVWxbYIKs9qlfeQ0BC2NXLgXbyEC7O/eUHa7i11CcKN6k+03N5GdhCU1HkDIgfc1XSY8
	jkYuv3L+zLhlH/gi+IQN4dhi56Y7A+0Al2g6EsRhI+IP3+AUoIgVV+cT1rMiiVuM5w+QiNAu+mmP+
	BtTqNQyt3iv/h2OLo7xA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghAfw-0002Sq-3C; Wed, 09 Jan 2019 10:01:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghAfs-0002SG-Bl
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:01:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 996D61650
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  9 Jan 2019 02:01:21 -0800 (PST)
Received: from mail-it1-f180.google.com (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 719F13F8F8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  9 Jan 2019 02:01:21 -0800 (PST)
Received: by mail-it1-f180.google.com with SMTP id h193so10168973ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 02:01:21 -0800 (PST)
X-Gm-Message-State: AJcUukfZ5qhkl2/9Q9p3ARC+NUuwJqGQgMHrGcZwVdIdcTK83gaqin0B
 gy0fH6PR88YN5dl1vli0WkmRFNIaMDW0M4u56d8=
X-Google-Smtp-Source: ALg8bN6FYiX38G0iQ0fSrA57jva53F05RuXFpGx6heWJgn91eGMHaBx5UPpUFse/Tns/JM/SmjbPKn5hSP56u/idBiA=
X-Received: by 2002:a02:4c55:: with SMTP id a82mr3530085jab.29.1547028080476; 
 Wed, 09 Jan 2019 02:01:20 -0800 (PST)
MIME-Version: 1.0
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
 <1545119810-12182-3-git-send-email-amit.kachhap@arm.com>
 <a50e3bdf-5e92-e0c3-76ab-ca49b1f4a715@arm.com>
In-Reply-To: <a50e3bdf-5e92-e0c3-76ab-ca49b1f4a715@arm.com>
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Date: Wed, 9 Jan 2019 15:31:08 +0530
X-Gmail-Original-Message-ID: <CADGdYn6XTxv980DTrWfaWE4=9BQkq3=T=Ukuby_KFZ9q7+0T3w@mail.gmail.com>
Message-ID: <CADGdYn6XTxv980DTrWfaWE4=9BQkq3=T=Ukuby_KFZ9q7+0T3w@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] arm64/kvm: context-switch ptrauth registers
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_020124_417077_8091457C 
X-CRM114-Status: GOOD (  52.24  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, LAK <linux-arm-kernel@lists.infradead.org>
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
> > When pointer authentication is supported, a guest may wish to use it.
> > This patch adds the necessary KVM infrastructure for this to work, with
> > a semi-lazy context switch of the pointer auth state.
> >
> > Pointer authentication feature is only enabled when VHE is built
> > into the kernel and present into CPU implementation so only VHE code
> > paths are modified.
> >
> > When we schedule a vcpu, we disable guest usage of pointer
> > authentication instructions and accesses to the keys. While these are
> > disabled, we avoid context-switching the keys. When we trap the guest
> > trying to use pointer authentication functionality, we change to eagerly
> > context-switching the keys, and enable the feature. The next time the
> > vcpu is scheduled out/in, we start again.
>
> Why start again?
> Taking the trap at all suggests the guest knows about pointer-auth, if it uses
> it, its probably in some context switch code. It would be good to avoid trapping
> that.
This is a pointer to the earlier discussion
https://lore.kernel.org/lkml/20180409125818.GE10904@cbox/.
It seems there is some agreement reached to flip ptrauth status in
every vcpu load/unload
as this would cater to both ptrauth enabled/disabled application.
>
>
> > Pointer authentication consists of address authentication and generic
> > authentication, and CPUs in a system might have varied support for
> > either. Where support for either feature is not uniform, it is hidden
> > from guests via ID register emulation, as a result of the cpufeature
> > framework in the host.
> >
> > Unfortunately, address authentication and generic authentication cannot
> > be trapped separately, as the architecture provides a single EL2 trap
> > covering both. If we wish to expose one without the other, we cannot
> > prevent a (badly-written) guest from intermittently using a feature
> > which is not uniformly supported (when scheduled on a physical CPU which
> > supports the relevant feature).
>
> Yuck!
:)
>
>
> > When the guest is scheduled on a
> > physical CPU lacking the feature, these attemts will result in an UNDEF
>
> (attempts)
ok.
>
> > being taken by the guest.
>
> Can we only expose the feature to a guest if both address and generic
> authentication are supported? (and hide it from the id register otherwise).
>
> This avoids having to know if this cpu supports address/generic when the system
> doesn't. We would need to scrub the values to avoid guest-values being left
> loaded when something else is running.
Yes it can be done. Currently it is done indirectly by userspace
option. Agree with you on this.
>
>
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index 1c8393f..ac7d496 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -526,6 +526,12 @@ static inline bool system_supports_generic_auth(void)
> >               cpus_have_const_cap(ARM64_HAS_GENERIC_AUTH);
> >  }
> >
> > +static inline bool system_supports_ptrauth(void)
> > +{
> > +     return IS_ENABLED(CONFIG_ARM64_PTR_AUTH) &&
> > +             cpus_have_const_cap(ARM64_HAS_ADDRESS_AUTH);
> > +}
>
> (mainline has a system_supports_address_auth(), I guess this will be folded
> around a bit during the rebase).
>
> system_supports_ptrauth() that checks the two architected algorithm caps?
yes. I will add.
>
>
> > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> > index ab35929..5c47a8f47 100644
> > --- a/arch/arm64/kvm/handle_exit.c
> > +++ b/arch/arm64/kvm/handle_exit.c
> > @@ -174,19 +174,25 @@ static int handle_sve(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >  }
> >
> >  /*
> > + * Handle the guest trying to use a ptrauth instruction, or trying to access a
> > + * ptrauth register. This trap should not occur as we enable ptrauth during
> > + * vcpu schedule itself but is anyway kept here for any unfortunate scenario.
>
> ... so we don't need this? Or if it ever runs its indicative of a bug?
Sorry This comment is confusing and is leftover of last V3 version.
>
>
> > + */
> > +void kvm_arm_vcpu_ptrauth_trap(struct kvm_vcpu *vcpu)
> > +{
> > +     if (system_supports_ptrauth())
> > +             kvm_arm_vcpu_ptrauth_enable(vcpu);
> > +     else
> > +             kvm_inject_undefined(vcpu);
> > +}
> > +
> > +/*
> >   * Guest usage of a ptrauth instruction (which the guest EL1 did not turn into
> > - * a NOP).
> > + * a NOP), or guest EL1 access to a ptrauth register.
> >   */
> >  static int kvm_handle_ptrauth(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >  {
> > -     /*
> > -      * We don't currently support ptrauth in a guest, and we mask the ID
> > -      * registers to prevent well-behaved guests from trying to make use of
> > -      * it.
> > -      *
> > -      * Inject an UNDEF, as if the feature really isn't present.
> > -      */
> > -     kvm_inject_undefined(vcpu);
> > +     kvm_arm_vcpu_ptrauth_trap(vcpu);
> >       return 1;
> >  }
>
> > diff --git a/arch/arm64/kvm/hyp/ptrauth-sr.c b/arch/arm64/kvm/hyp/ptrauth-sr.c
> > new file mode 100644
> > index 0000000..1bfaf74
> > --- /dev/null
> > +++ b/arch/arm64/kvm/hyp/ptrauth-sr.c
> > @@ -0,0 +1,73 @@
>
> > +{
> > +     return vcpu->arch.hcr_el2 & (HCR_API | HCR_APK);
> > +}
>
> (If you include the the IS_ENABLED() in here too, the compiler can work out
> pointer-auth was compiled out and prune all the unused static functions.)
ok.
>
>
> > +#define __ptrauth_save_key(regs, key)                                                \
> > +({                                                                           \
> > +     regs[key ## KEYLO_EL1] = read_sysreg_s(SYS_ ## key ## KEYLO_EL1);       \
> > +     regs[key ## KEYHI_EL1] = read_sysreg_s(SYS_ ## key ## KEYHI_EL1);       \
> > +})
>
> (shame we can't re-use the arch code's macros for these)
>
>
> > +static __always_inline void __hyp_text __ptrauth_save_state(struct kvm_cpu_context *ctxt)
> > +{
> > +     __ptrauth_save_key(ctxt->sys_regs, APIA);
> > +     __ptrauth_save_key(ctxt->sys_regs, APIB);
> > +     __ptrauth_save_key(ctxt->sys_regs, APDA);
> > +     __ptrauth_save_key(ctxt->sys_regs, APDB);
>
> > +     __ptrauth_save_key(ctxt->sys_regs, APGA);
>
> I thought the generic authentication bits had a separate ID-register-field/cap?
> But you only checked address-auth above. Is it possible the CPU doesn't have
> this register?
Yes it may be possible and generic ptrauth userspace patches by
Kristina has a separate
check for generic key. I will add a similar check here.
>
> (but I think we should only support this if both generic&address are supported)
>
>
> > +}
>
> > +void __hyp_text __ptrauth_switch_to_guest(struct kvm_vcpu *vcpu,
> > +                                       struct kvm_cpu_context *host_ctxt,
> > +                                       struct kvm_cpu_context *guest_ctxt)
> > +{
> > +     if (!__ptrauth_is_enabled(vcpu))
> > +             return;
> > +
> > +     __ptrauth_save_state(host_ctxt);
> > +     __ptrauth_restore_state(guest_ctxt);
> > +}
> > +
> > +void __hyp_text __ptrauth_switch_to_host(struct kvm_vcpu *vcpu,
> > +                                      struct kvm_cpu_context *host_ctxt,
> > +                                      struct kvm_cpu_context *guest_ctxt)
> > +{
> > +     if (!__ptrauth_is_enabled(vcpu))
> > +             return;
> > +
> > +     __ptrauth_save_state(guest_ctxt);
> > +     __ptrauth_restore_state(host_ctxt);
> > +}
>
>
> > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> > index 85a2a5c..6c57552 100644
> > --- a/arch/arm64/kvm/hyp/switch.c
> > +++ b/arch/arm64/kvm/hyp/switch.c
> > @@ -508,6 +508,8 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
> >       sysreg_restore_guest_state_vhe(guest_ctxt);
> >       __debug_switch_to_guest(vcpu);
> >
> > +     __ptrauth_switch_to_guest(vcpu, host_ctxt, guest_ctxt);
> > +
> >       __set_guest_arch_workaround_state(vcpu);
> >
> >       do {
> > @@ -519,6 +521,8 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
> >
> >       __set_host_arch_workaround_state(vcpu);
> >
> > +     __ptrauth_switch_to_host(vcpu, host_ctxt, guest_ctxt);
> > +
> >       sysreg_save_guest_state_vhe(guest_ctxt);
> >
> >       __deactivate_traps(vcpu);
>
> This is deep in the world-switch code, meaning we save/restore 10 sysregs for
> every entry/exit. As the kernel isn't using pointer-auth, wouldn't it be better
> to defer the save/restore to the preempt notifier using kvm_arch_vcpu_load()?
>
> I've seen the discussion that the kernel may start using this 'soon':
> lore.kernel.org/r/20181112223212.5o4ipc5kt5ziuupt@localhost
>
> (does anyone know when soon is?)
One version is already posted and next version is worked upon.
>
> ... but it doesn't today, and save/restoring these in C becomes impossible when
> that happens, which the arch code is doing too, so we aren't inventing a new
> problem.
Save and restore of key possible in C function with GCC function attribute like
sign-return-address=none. I left the switch function as of now and
only this change is needed
to enable it for kernel ptrauth.
>
>
> probable-tangent: {
> If the kernel starts using ptrauth, it will need to switch these registers in
> the entry asm, and in __cpu_switch_to()... there will be new asm macro's to do this.
>
> Can we make it so that the same series that does that, can easily do KVM too?
Yes it should be possible.
>
> If we use the preempt-notifier stuff the GET/SET_ONE_REG code knows that today
> the ptrauth values are always loaded on the cpu, it doesn't need to look in the
> sys_reg_descs[] array.
> This means the preempt notifier could save/restore them to a struct ptrauth_keys
> in struct kvm_vcpu_arch. This lets us use the arch codes __ptrauth_key_install()
> and ptrauth_keys_switch() helpers today, instead of duplicating them because the
> layout is slightly different.
Since vcpu is a thread so keys are allocated using the current user
ptrauth patches and
I can see in guest switch that has keys are present in guest context.
Do you see advantage
in allocating keys in the above way?
>
> Once these become asm macros, the same structure is already in use, so we can
> (cough) probably feed it a different base pointer for guest-entry/ret_to_user.
> guest-exit would almost be the same as kernel_enter, its only the
> save-guest-values that would be specific to kvm.
yes reusing will be better.
>
> (oh, and the GET/SET_ONE_REG code would need to know to look elsewhere for the
> guest values, but it looks like your patch 5 is already doing some of this).
ok.
>
> }
>
>
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 1ca592d..6af6c7d 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -986,6 +986,32 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> >       { SYS_DESC(SYS_PMEVTYPERn_EL0(n)),                                      \
> >         access_pmu_evtyper, reset_unknown, (PMEVTYPER0_EL0 + n), }
> >
> > +
> > +void kvm_arm_vcpu_ptrauth_enable(struct kvm_vcpu *vcpu)
> > +{
> > +     vcpu->arch.hcr_el2 |= (HCR_API | HCR_APK);
> > +}
> > +
> > +void kvm_arm_vcpu_ptrauth_disable(struct kvm_vcpu *vcpu)
> > +{
> > +     vcpu->arch.hcr_el2 &= ~(HCR_API | HCR_APK);
> > +}
> > +
>
> > @@ -1040,14 +1066,6 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
> >                       kvm_debug("SVE unsupported for guests, suppressing\n");
> >
> >               val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> > -     } else if (id == SYS_ID_AA64ISAR1_EL1) {
> > -             const u64 ptrauth_mask = (0xfUL << ID_AA64ISAR1_APA_SHIFT) |
> > -                                      (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> > -                                      (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
> > -                                      (0xfUL << ID_AA64ISAR1_GPI_SHIFT);
>
> Don't we still want to remove the imp-def bits? and the APA/GPA bits if we
> decide there is incomplete support.
I think it was decided to enable all features even though they are not
supported. I cannot find the link though.
>
>
> > -             if (val & ptrauth_mask)
> > -                     kvm_debug("ptrauth unsupported for guests, suppressing\n");
> > -             val &= ~ptrauth_mask;
> >       } else if (id == SYS_ID_AA64MMFR1_EL1) {
> >               if (val & (0xfUL << ID_AA64MMFR1_LOR_SHIFT))
> >                       kvm_debug("LORegions unsupported for guests, suppressing\n");
>
>
> > diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> > index feda456..1f3b6ed 100644
> > --- a/virt/kvm/arm/arm.c
> > +++ b/virt/kvm/arm/arm.c
> > @@ -388,6 +388,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> >               vcpu_clear_wfe_traps(vcpu);
> >       else
> >               vcpu_set_wfe_traps(vcpu);
> > +
> > +     kvm_arm_vcpu_ptrauth_config(vcpu);
>
> (doesn't this unconfigure ptrauth?!)
ok will change the name to something like kvm_arm_vcpu_ptrauth_reset.
>
> >  }
>
> Thanks,
>
> James

//Amit

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
