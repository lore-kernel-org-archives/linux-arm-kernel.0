From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 27 Sep 2012 07:37:15 +0200
Subject: [RFC PATCH 0/3] ARM: uncompress.h multi-platform enablement
In-Reply-To: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
References: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120927053715.GK17667@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	what happend on the patch serie taht use the fdt to do the same

Best Regards,
J.
On 16:46 Tue 25 Sep     , Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra's uncompress and debug-macro.S communicate to each-other. Hence,
> we can't be left without uncompress.h in a multi-platform enabled kernel,
> or we'll lose features. This series allows uncompress.h to be used in a
> multi-platform kernel, restores the mvebu uncompress.h, and finally moves
> the Tegra debug macros into the common location. The series as mainly an
> RFC due to the outstanding question of where to put Tegra's <mach/iomap.h>
> in the final patch.
> 
> Stephen Warren (3):
>   ARM: move ICEDCC uncompress.h to common location
>   ARM: mvebu: restore uncompress.h
>   ARM: tegra: move debug macros to include/debug
> 
>  arch/arm/Kconfig.debug                             |   20 ++++++
>  arch/arm/boot/compressed/misc.c                    |   64 +-------------------
>  arch/arm/include/debug/icedcc-uncompress.h         |   61 +++++++++++++++++++
>  arch/arm/include/debug/mvebu-uncompress.h          |   43 +++++++++++++
>  arch/arm/include/debug/none-uncompress.h           |    3 +
>  .../debug/tegra-uncompress.h}                      |    6 +-
>  .../mach/debug-macro.S => include/debug/tegra.S}   |    6 +-
>  7 files changed, 132 insertions(+), 71 deletions(-)
>  create mode 100644 arch/arm/include/debug/icedcc-uncompress.h
>  create mode 100644 arch/arm/include/debug/mvebu-uncompress.h
>  create mode 100644 arch/arm/include/debug/none-uncompress.h
>  rename arch/arm/{mach-tegra/include/mach/uncompress.h => include/debug/tegra-uncompress.h} (98%)
>  rename arch/arm/{mach-tegra/include/mach/debug-macro.S => include/debug/tegra.S} (96%)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
