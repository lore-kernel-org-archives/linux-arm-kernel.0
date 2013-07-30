From: horms@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 11:27:03 +0900
Subject: [PATCH v3 0/4] ARM: shmobile: marzen: Switch to DT_MACHINE_START
In-Reply-To: <1374799913-27461-1-git-send-email-horms+renesas@verge.net.au>
References: <1374799913-27461-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130730022703.GE31526@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 09:51:49AM +0900, Simon Horman wrote:
> A short series to use DT_MACHINE_START on the marzen board.

Magnus, could you find a few moments to review this series?

> 
> Changes since v2
> * Break dtb changes out of "ARM: shmobile: marzen: Switch to
>   DT_MACHINE_START" and into their own patch "ARM: shmobile: marzen: Add
>   r8a7779-marzen.dtb"
> * Correct typo in changelog of "ARM: shmobile: marzen: Enable
>   ARM_APPENDED_DTB in defconfig"
> 
> Changes since v1
> * Add "ARM: shmobile: marzen: Enable ARM_APPENDED_DTB in defconfig" patch
> * Add "ARM: shmobile: r8a7779: Rely on DT for SMP CPU info" patch
> * Enhance "ARM: shmobile: marzen: Switch to DT_MACHINE_START" to:
>   - Select USE_OF in Kconfig
>   - Provide dt_compat in DT_MACHINE_START
>   - Provide r8a7779-marzen dts
> 
> Magnus Damm (1):
>   ARM: shmobile: marzen: Switch to DT_MACHINE_START
> 
> Simon Horman (3):
>   ARM: shmobile: marzen: Add  r8a7779-marzen.dtb
>   ARM: shmobile: r8a7779: Rely on DT for SMP CPU info
>   ARM: shmobile: marzen: Enable ARM_APPENDED_DTB in defconfig
> 
>  arch/arm/boot/dts/Makefile            |  1 +
>  arch/arm/boot/dts/r8a7779-marzen.dts  | 27 +++++++++++++++++++++++++++
>  arch/arm/configs/marzen_defconfig     |  1 +
>  arch/arm/mach-shmobile/Kconfig        |  1 +
>  arch/arm/mach-shmobile/board-marzen.c |  8 +++++++-
>  arch/arm/mach-shmobile/smp-r8a7779.c  | 12 +++---------
>  6 files changed, 40 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/boot/dts/r8a7779-marzen.dts
> 
> -- 
> 1.8.2.1
> 
