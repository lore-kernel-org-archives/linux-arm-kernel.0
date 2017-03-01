From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 01 Mar 2017 19:48:48 +0000
Subject: [PATCH/RFC] arm64: pmu: add Qualcomm Technologies extensions
In-Reply-To: <20170301181032.GL28874@leverpostej> (Mark Rutland's message of
 "Wed, 1 Mar 2017 18:10:33 +0000")
References: <1488385085-19238-1-git-send-email-nleeder@codeaurora.org>
 <20170301181032.GL28874@leverpostej>
Message-ID: <87a8944w2n.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01 2017 at  6:10:33 pm GMT, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Neil,
>
> On Wed, Mar 01, 2017 at 11:18:05AM -0500, Neil Leeder wrote:
>> Adds CPU PMU perf events support for Qualcomm Technologies' Falkor CPU.
>> 
>> The Qualcomm Technologies CPU PMU is named qcom_pmuv3 and provides
>> extensions to the architected PMU events.
>
> Is this is a strict superset of PMUv3 (that could validly be treated as
> just PMUv3), or do those IMP DEF parts need to be poked to use this at
> all?
>
> What is reported by ID_AA64DFR0_EL1.PMUVer on these CPUs?
>
> Quite frankly, I'm less than thrilled about the prospect of
> IMPLEMENTATION DEFINED CPU PMUs that fall outside of the architected PMU
> model, especially for ACPI systems where the raison d'?tre is standards
> and uniformity, and where we have no sensible mechanism to provide
> information regarding IMPLEMENTATION DEFINED functionality.
>
> This has knock-on effects for other things, like userspace PMU access
> and/or virtualization, and this multiplies the support effort.
>
> KVM already has (architected) PMU support, and without a corresponding
> KVM patch this is at best insufficient. I don't imagine the KVM folk
> will be too thrilled about the prospect of emulating an IMPLEMENTATION
> DEFINED CPU feature like this.

Indeed. Another nasty property of these "added value" features is that
they break things like migration. Once the guest has booted on one of
these systems, it cannot be moved to another system. This puts a bit of
a dent on the architecture, frankly...

	M.
-- 
Jazz is not dead, it just smell funny.
