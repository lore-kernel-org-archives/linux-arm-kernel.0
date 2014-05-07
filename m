From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 7 May 2014 16:34:19 +0100
Subject: [PATCH 1/9] arm64: KVM: rename pm_fake handler to trap_wi_raz
In-Reply-To: <1399476054-21571-2-git-send-email-marc.zyngier@arm.com>
References: <1399476054-21571-1-git-send-email-marc.zyngier@arm.com>
 <1399476054-21571-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAFEAcA-v4ek1+JDKDfE3n+HSigutqfv1aU=VdxTtxFAd25S6fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2014 16:20, Marc Zyngier <marc.zyngier@arm.com> wrote:
> pm_fake doesn't quite describe what the handler does (ignoring writes
> and returning 0 for reads).
>
> As we're about to use it (a lot) in a different context, rename it
> with a (admitedly cryptic) name that make sense for all users.

> -/*
> - * We could trap ID_DFR0 and tell the guest we don't support performance
> - * monitoring.  Unfortunately the patch to make the kernel check ID_DFR0 was
> - * NAKed, so it will read the PMCR anyway.
> - *
> - * Therefore we tell the guest we have 0 counters.  Unfortunately, we
> - * must always support PMCCNTR (the cycle counter): we just RAZ/WI for
> - * all PM registers, which doesn't crash the guest kernel at least.
> - */
> -static bool pm_fake(struct kvm_vcpu *vcpu,
> -                   const struct sys_reg_params *p,
> -                   const struct sys_reg_desc *r)
> +static bool trap_wi_raz(struct kvm_vcpu *vcpu,
> +                       const struct sys_reg_params *p,
> +                       const struct sys_reg_desc *r)

The standard term for this is "RAZ/WI", not "WI/RAZ", so
why not "trap_raz_wi" ?

thanks
-- PMM
