From: anup@brainfault.org (Anup Patel)
Date: Fri, 16 May 2014 22:09:50 +0530
Subject: [GIT PULL] PSCI v0.2 support and DT bindings
In-Reply-To: <CAJ5Y-eb8h=ZO=1ugMTdADmhEidp-znaEVjbL6UzekAGDPdzuSA@mail.gmail.com>
References: <CAJ5Y-eb8h=ZO=1ugMTdADmhEidp-znaEVjbL6UzekAGDPdzuSA@mail.gmail.com>
Message-ID: <CAAhSdy1mLA3xfVtt7X7LPTFosF4D0pQ4s+W978Txew2fWfR0=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 7:31 PM, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> Hi Christoffer, Marc
>
> Please pull in the ARM and ARM64 PSCIv0.2 patchwork from the git
> branch below. These patches have been under review on LKAML since
> early March and are now ACK'd. Also, since these patches are dependent
> on the UAPI header file (uapi/linux/psci.h) added by the KVM PSCIv0.2
> patchwork, it makes sense to submit the whole PSCIv0.2 patchwork (KVM
> and core) as one set.
>
> Cheers,
> Ashwin
>
>
> The following changes since commit 4447a208f7fc2e2dff8c6a8df2a1fd6dd72fb3e2:
>
>   ARM/ARM64: KVM: Advertise KVM_CAP_ARM_PSCI_0_2 to user space
> (2014-04-30 04:18:58 -0700)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/ashwin.chaugule/leg-kernel.git kvm-next-psci-v0.2
>
> for you to fetch changes up to c814ca029e1015bb0ecec312f4bb9751ba1a711a:
>
>   ARM: Check if a CPU has gone offline (2014-05-15 10:16:30 -0400)
>
> ----------------------------------------------------------------
> Ashwin Chaugule (3):
>       PSCI: Add initial support for PSCIv0.2 functions
>       Documentation: devicetree: Add new binding for PSCIv0.2
>       ARM: Check if a CPU has gone offline
>
>  Documentation/devicetree/bindings/arm/psci.txt |  37 +++-
>  arch/arm/include/asm/psci.h                    |   7 +-
>  arch/arm/kernel/psci.c                         | 196 +++++++++++++++++----
>  arch/arm/kernel/psci_smp.c                     |  33 ++++
>  arch/arm64/include/asm/cpu_ops.h               |   2 +
>  arch/arm64/include/asm/psci.h                  |   2 +-
>  arch/arm64/kernel/psci.c                       | 231 +++++++++++++++++++++----
>  arch/arm64/kernel/smp.c                        |  22 +++
>  8 files changed, 452 insertions(+), 78 deletions(-)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Hi Christoffer/Marc,

It would be really great if these patches are merged for 3.16-rc1.

Best Regards,
Anup Patel
