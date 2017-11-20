From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 20 Nov 2017 16:41:31 +0100
Subject: [PATCH v3 0/3] KVM: arm64: single step emulation instructions
In-Reply-To: <20171116153921.21991-1-alex.bennee@linaro.org>
References: <20171116153921.21991-1-alex.bennee@linaro.org>
Message-ID: <20171120154131.GO28855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Thu, Nov 16, 2017 at 03:39:18PM +0000, Alex Benn?e wrote:
> Hi,
> 
> This is rev 3 of the series, practically the same than rev 2 but fixed
> a return 1->0 in the kvm_run loop that Julien caught. I've added his
> r-b tags to the other patches.
> 
> As usual revision details bellow the --- in each patch.

Thanks for taking care of this.

I have applied the series and slightly tweaked the commit messages and
commentary.

Did we simply decide to not worry about exiting to userspace if we do
fast-path emulation, such as for the errata workaround and GIC
mashaling in switch.c ?

Thanks,
-Christoffer

> 
> Alex Benn?e (3):
>   kvm: arm debug: introduce helper for single-step
>   kvm: arm64: handle single-stepping trapped instructions
>   kvm: arm64: handle single-step of userspace mmio instructions
> 
>  arch/arm/include/asm/kvm_host.h   |  5 +++++
>  arch/arm64/include/asm/kvm_host.h |  1 +
>  arch/arm64/kvm/debug.c            | 22 ++++++++++++++++++
>  arch/arm64/kvm/handle_exit.c      | 47 +++++++++++++++++++++++++++------------
>  virt/kvm/arm/arm.c                |  3 +++
>  5 files changed, 64 insertions(+), 14 deletions(-)
> 
> -- 
> 2.15.0
> 
