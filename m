From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 8 May 2014 00:48:55 -0400
Subject: [PATCH v9 0/3] PSCI v0.2 support and DT bindings
In-Reply-To: <1399472847-14377-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1399472847-14377-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <CAJ5Y-eZhHfAzCeDhqZRw6+WnRb4KWNTe0sGQRiOGkxd2Lw8+JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 7 May 2014 10:27, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> This patchset introduces some functions as defined in the PSCI v0.2 spec
> and a corresponding DT binding to differentiate it from previous PSCI versions.
> Since PSCIv0.2 has standard function IDs, it is possible to statically assign them
> rather than depend on values from DT.
>
> This patchset depends on the PSCI header (/uapi/linux/psci.h) introduced by
> http://www.spinics.net/lists/arm-kernel/msg319712.html which is now merged in the
> ARM KVM tree next branch.
>
>
> Changes in v9:
>                 -               Rebased on top of KVM "next" - https://git.kernel.org/cgit/linux/kernel/git/kvmarm/kvmarm.git/log/?h=next
>
>
> Ashwin Chaugule (3):
>   PSCI: Add initial support for PSCIv0.2 functions
>   Documentation: devicetree: Add new binding for PSCIv0.2
>   ARM: Check if a CPU has gone offline
>
>  Documentation/devicetree/bindings/arm/psci.txt |  35 ++++-
>  arch/arm/include/asm/psci.h                    |   7 +-
>  arch/arm/kernel/psci.c                         | 196 +++++++++++++++++++-----
>  arch/arm/kernel/psci_smp.c                     |  31 ++++
>  arch/arm64/include/asm/psci.h                  |   2 +-
>  arch/arm64/kernel/psci.c                       | 200 ++++++++++++++++++++-----
>  6 files changed, 393 insertions(+), 78 deletions(-)
>

Can you please pick up these patches for the next merge window ?

Cheers,
Ashwin
