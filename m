From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 23 Jun 2015 14:39:59 +0200
Subject: [PATCH] arm64/kvm: Add generic v8 KVM target
In-Reply-To: <CAFEAcA92uymQ3LjPQnuFiwvjSgc+jY54VrfK_Sh4v1DJ+=OPpw@mail.gmail.com>
References: <1434531646-4873-1-git-send-email-suzuki.poulose@arm.com>
 <CAFEAcA92uymQ3LjPQnuFiwvjSgc+jY54VrfK_Sh4v1DJ+=OPpw@mail.gmail.com>
Message-ID: <20150623123959.GF4035@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 09:44:48AM +0100, Peter Maydell wrote:
> On 17 June 2015 at 10:00, Suzuki K. Poulose <suzuki.poulose@arm.com> wrote:
> > From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> >
> > This patch adds a generic ARM v8 KVM target cpu type for use
> > by the new CPUs which eventualy ends up using the common sys_reg
> > table. For backward compatibility the existing targets have been
> > preserved. Any new target CPU that can be covered by generic v8
> > sys_reg tables should make use of the new generic target.
> 
> How do you intend this to work for cross-host migration?
> Is the idea that the kernel guarantees that "generic" looks
> 100% the same to the guest regardless of host hardware? I'm
> not sure that can be made to work, given impdef differences
> in ID register values, bp/wp registers, and so on.
> 
> Given that, it seems to me that we still need to provide
> KVM_ARM_TARGET_$THISCPU defines so userspace can request
> a specific guest CPU flavour; so what does this patch
> provide that isn't already provided by just having userspace
> query for the "preferred" CPU type as it does already?
> 
I'm guessing the intention is to avoid having to add code in the kernel
to support KVM on a new CPU where nothing else needs to be done to
support KVM on that system.

Wrt. migration, I was also wondering about this.  Would the differences
in the CPU architecture be detected when feeding back the invariant
sysregs from userspace on VM restore?

-Christoffer
