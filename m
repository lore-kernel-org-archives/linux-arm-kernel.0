From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 17 Jun 2013 18:46:39 -0400
Subject: [GIT PULL] Keystone SOC support for 3.11
In-Reply-To: <1371255346-3000-1-git-send-email-santosh.shilimkar@ti.com>
References: <1371255346-3000-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <51BF91CF.9040509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Friday 14 June 2013 08:15 PM, Santosh Shilimkar wrote:
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> 
>   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc-for-arm-soc
>
Updated patches with your acks are pushed with the same tag as above.

 
> for you to fetch changes up to cc92fc07c26c1bec1abb58f0cd356b13dc00a28c:
> 
>   ARM: dts: keystone: Add minimal Keystone SOC device tree data (2013-06-14 19:45:46 -0400)
> 
> ----------------------------------------------------------------
> SOC support for Keystone II devices:
> 
> - Minimal machine and device-tree support with arch_timers and console UART
> - Reboot hook using PLL reset
> - Low level debug support using UART
> - SMP boot support
> 
> ----------------------------------------------------------------
> Santosh Shilimkar (3):
>       ARM: keystone: Add minimal TI Keystone platform support
>       ARM: keystone: Enable SMP support on Keystone machines
>       ARM: dts: keystone: Add minimal Keystone SOC device tree data
> 
>  .../devicetree/bindings/arm/keystone/keystone.txt  |   10 ++
>  arch/arm/Kconfig                                   |    3 +
>  arch/arm/Kconfig.debug                             |   16 ++
>  arch/arm/Makefile                                  |    1 +
>  arch/arm/boot/dts/keystone.dts                     |  109 ++++++++++++++
>  arch/arm/configs/keystone_defconfig                |  157 ++++++++++++++++++++
>  arch/arm/include/debug/keystone.S                  |   43 ++++++
>  arch/arm/mach-keystone/Kconfig                     |   15 ++
>  arch/arm/mach-keystone/Makefile                    |    2 +
>  arch/arm/mach-keystone/Makefile.boot               |    1 +
>  arch/arm/mach-keystone/keystone.c                  |   77 ++++++++++
>  arch/arm/mach-keystone/keystone.h                  |   17 +++
>  arch/arm/mach-keystone/platsmp.c                   |   52 +++++++
>  13 files changed, 503 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/keystone/keystone.txt
>  create mode 100644 arch/arm/boot/dts/keystone.dts
>  create mode 100644 arch/arm/configs/keystone_defconfig
>  create mode 100644 arch/arm/include/debug/keystone.S
>  create mode 100644 arch/arm/mach-keystone/Kconfig
>  create mode 100644 arch/arm/mach-keystone/Makefile
>  create mode 100644 arch/arm/mach-keystone/Makefile.boot
>  create mode 100644 arch/arm/mach-keystone/keystone.c
>  create mode 100644 arch/arm/mach-keystone/keystone.h
>  create mode 100644 arch/arm/mach-keystone/platsmp.c
> 
