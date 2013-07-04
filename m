From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 4 Jul 2013 13:11:17 +0100
Subject: [PATCH] arm64: KVM: Kconfig integration
In-Reply-To: <1372939377-24657-1-git-send-email-marc.zyngier@arm.com>
References: <1372939377-24657-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAFEAcA-LCenzvJSyyGBMAxraiJx-4OT2dnMsnCGzWJ-ESEkAiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2013 13:02, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Finally plug KVM/arm64 into the config system, making it possible
> to enable KVM support on AArch64 CPUs.
>
> +config KVM
> +       bool "Kernel-based Virtual Machine (KVM) support"
> +       select MMU_NOTIFIER
> +       select PREEMPT_NOTIFIERS
> +       select ANON_INODES
> +       select KVM_MMIO
> +       select KVM_ARM_HOST
> +       select KVM_ARM_VGIC
> +       select KVM_ARM_TIMER
> +       ---help---
> +         Support hosting virtualized guest machines.
> +
> +         This module provides access to the hardware capabilities through
> +         a character device node named /dev/kvm.

"This module" ? I didn't think we supported KVM-as-a-module on ARM...

> +
> +         If unsure, say N.
> +
> +config KVM_ARM_HOST
> +       bool
> +       ---help---
> +         Provides host support for ARM processors.
> +
> +config KVM_ARM_VGIC
> +        bool
> +       depends on KVM_ARM_HOST && OF
> +       select HAVE_KVM_IRQCHIP
> +       ---help---
> +         Adds support for a hardware assisted, in-kernel GIC emulation.
> +
> +config KVM_ARM_TIMER
> +        bool
> +       depends on KVM_ARM_VGIC
> +       ---help---
> +         Adds support for the Architected Timers in virtual machines

Trailing '.' would be consistent with the other config options.

thanks
-- PMM
