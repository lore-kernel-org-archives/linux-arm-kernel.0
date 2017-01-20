From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Jan 2017 15:04:28 +0000
Subject: [PATCH v9 0/4] arm64: arch_timer: Add workaround for
 hisilicon-161010101 erratum
In-Reply-To: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
References: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <20170120150428.GC22152@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 09:35:12PM +0800, Ding Tianhong wrote:
> Ding Tianhong (4):
>   arm64: arch_timer: Add device tree binding for hisilicon-161010101
>     erratum
>   arm64: arch_timer: Introduce a generic erratum handing mechanism for
>     fsl-a008585
>   arm64: arch_timer: Work around Erratum Hisilicon-161010101
>   arm64: arch timer: Add timer erratum property for Hip05-d02 and
>     Hip06-d03
> 
>  Documentation/admin-guide/kernel-parameters.txt    |   9 --
>  Documentation/arm64/silicon-errata.txt             |  43 +++---
>  .../devicetree/bindings/arm/arch_timer.txt         |   6 +
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi           |   1 +
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi           |   1 +
>  arch/arm64/include/asm/arch_timer.h                |  38 ++----
>  drivers/clocksource/Kconfig                        |  18 +++
>  drivers/clocksource/arm_arch_timer.c               | 150 +++++++++++++++------
>  8 files changed, 171 insertions(+), 95 deletions(-)

I've picked these up (with a few local cleanups), given that some local
testing, and pushed the result to a branch [1] on my git repo.

There are likely to be clashes with the arm64 tree (e.g. for
silicon-errata.txt), and we're also likely to have more arch timer
updates shortly for the GTDT stuff, so I think the best bet is for both
arm64 and the clocksource tree to pull that branch for v4.11.

Alternatively, we could take this all through the arm64 tree, if the
clocksource maintainers are happy with that.

Thoughts?

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arch-timer/hisi-161010101
