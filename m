From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 22 Jun 2015 09:44:48 +0100
Subject: [PATCH] arm64/kvm: Add generic v8 KVM target
In-Reply-To: <1434531646-4873-1-git-send-email-suzuki.poulose@arm.com>
References: <1434531646-4873-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CAFEAcA92uymQ3LjPQnuFiwvjSgc+jY54VrfK_Sh4v1DJ+=OPpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 June 2015 at 10:00, Suzuki K. Poulose <suzuki.poulose@arm.com> wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>
> This patch adds a generic ARM v8 KVM target cpu type for use
> by the new CPUs which eventualy ends up using the common sys_reg
> table. For backward compatibility the existing targets have been
> preserved. Any new target CPU that can be covered by generic v8
> sys_reg tables should make use of the new generic target.

How do you intend this to work for cross-host migration?
Is the idea that the kernel guarantees that "generic" looks
100% the same to the guest regardless of host hardware? I'm
not sure that can be made to work, given impdef differences
in ID register values, bp/wp registers, and so on.

Given that, it seems to me that we still need to provide
KVM_ARM_TARGET_$THISCPU defines so userspace can request
a specific guest CPU flavour; so what does this patch
provide that isn't already provided by just having userspace
query for the "preferred" CPU type as it does already?

thanks
-- PMM
