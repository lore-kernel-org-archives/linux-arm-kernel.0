From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 3 Feb 2014 13:46:36 +0000
Subject: [PATCH v2 1/3] KVM: Add capability to advertise PSCI v0.2 support
In-Reply-To: <CAAhSdy3E-BxTi=c3rrQn-WYPQrrzheTfZy3c7SBCKdftjLF1uA@mail.gmail.com>
References: <1391078479-7406-1-git-send-email-anup.patel@linaro.org>
 <1391078479-7406-2-git-send-email-anup.patel@linaro.org>
 <20140203114835.GB2784@e106331-lin.cambridge.arm.com>
 <CAAhSdy3E-BxTi=c3rrQn-WYPQrrzheTfZy3c7SBCKdftjLF1uA@mail.gmail.com>
Message-ID: <20140203134635.GC2784@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 12:09:22PM +0000, Anup Patel wrote:
> On Mon, Feb 3, 2014 at 5:18 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Jan 30, 2014 at 10:41:17AM +0000, Anup Patel wrote:
> >> User space (i.e. QEMU or KVMTOOL) should be able to check whether KVM
> >> ARM/ARM64 supports in-kernel PSCI v0.2 emulation. For this purpose, we
> >> define KVM_CAP_ARM_PSCI_0_2 in KVM user space interface header.
> >>
> >> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> >> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> >> ---
> >>  include/uapi/linux/kvm.h |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >> index 902f124..d64349e 100644
> >> --- a/include/uapi/linux/kvm.h
> >> +++ b/include/uapi/linux/kvm.h
> >> @@ -674,6 +674,7 @@ struct kvm_ppc_smmu_info {
> >>  #define KVM_CAP_ARM_EL1_32BIT 93
> >>  #define KVM_CAP_SPAPR_MULTITCE 94
> >>  #define KVM_CAP_EXT_EMUL_CPUID 95
> >> +#define KVM_CAP_ARM_PSCI_0_2 96
> >
> > To reiterate the point I made on patch 2, this does not do what it says
> > on the tin, and does not make sense without mandatory PSCI 0.2
> > functionality being present, as no software can derive any value from
> > this flag until such functionality is implemented.
> 
> I handle this situation I would suggest to not advertise PSCI v0.2
> capability to user space till all mandatory PSCI v0.2 functions
> are implemented. We will also need to defer the change in
> arch/arm/kvm/arm.c done by patch 2.

Until all the mandatory PSCI 0.2 functions are implemented it should not
be possible to ask the kernel for a partial implementation, yes.

Thanks,
Mark.
