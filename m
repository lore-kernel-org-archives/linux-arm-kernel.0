From: horms@verge.net.au (Simon Horman)
Date: Sat, 12 Jul 2014 15:23:17 +0200
Subject: [PATCH v2 00/30] ARM: shmobile: Enable SCI and TMU using DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140712132315.GA19014@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 09:54:25AM +0200, Simon Horman wrote:
> The purpose of this series is to enable SCI, CMT and TMU using DT
> on boards that use DT-reference. Or in other-words boards other
> than the mackerel that are not covered by Laurent Pinchart's work in
> the same area.
> 
> This series is based on a merge of:
> 
> * [GIT PULL v2 FOR v3.17] Renesas CMT, MTU2 and TMU timers DT support
> * renesas-devel-v3.16-rc4-20140707
> 
> It also depends on
> [PATCH v2] serial: sh-sci: Add device tree support for r8a7{778,740,3a4} and sh73a

As Greg KH has merged the above patch I have queued up
the SCI patches listed below.

> This series does not enable TMU for the sh73a0/kzm9g-reference
> as:
> 
> * It appears to use sh-intc as an interrupt source and I am unsure
>   how to use this from DT at this time and;
> * It is not currently enabled in dt-reference.
> 
> I will address this as a follow-up if appropriate.
> 
> 
> Simon Horman (30):
>   ARM: shmobile: r8a7778: add SCI clock support for DT
>   ARM: shmobile: r8a7778: Add SCIF nodes
>   ARM: shmobile: bockw-reference: Initialise SCIF device using DT
>   ARM: shmobile: r8a7778: add TMU clock support for DT
>   ARM: shmobile: r8a7778: Add TMU nodes
>   ARM: shmobile: bockw-reference: Initialise TMU device using DT
>   ARM: shmobile: r8a73a4: add SCI clock support for DT
>   ARM: shmobile: r8a73a4: Add SCIF nodes
>   ARM: shmobile: ape6evm-reference: Initialise SCIF device using DT
>   ARM: shmobile: r8a73a4: add CMT1 clock support for DT
>   ARM: shmobile: r8a73a4: Add CMT1 node
>   ARM: shmobile: r8a73a4: Rename cmt registration helper
>   ARM: shmobile: ape6evm-reference: Initialise CMT1 device using DT
>   ARM: shmobile: r8a73a4: Remove empty r8a73a4_add_dt_devices
>   ARM: shmobile: r8a7740: correct SCI clock support for DT
>   ARM: shmobile: r8a7740: Add SCIF nodes
>   ARM: shmobile: armadillo800eva-reference: Initialise SCIF device using
>     DT
>   ARM: shmobile: r8a7740: add TMU clock support for DT
>   ARM: shmobile: r8a7740: Add TMU nodes
>   ARM: shmobile: armadillo800eva-reference: Initialise TMU device using
>     DT
>   ARM: shmobile: r8a7740: add CMT1 clock support for DT
>   ARM: shmobile: r8a7740: Add CMT1 node
>   ARM: shmobile: armadillo800eva-reference: Initialise CMT1 device using
>     DT
>   ARM: shmobile: r8a7740: Remove unnecessary
>     r8a7740_add_standard_devices_dt()
>   ARM: shmobile: sh73a0: add SCI clock support for DT
>   ARM: shmobile: sh73a0: Add SCIF nodes
>   ARM: shmobile: kzm9g-reference: Initialise SCIF device using DT
>   ARM: shmobile: sh73a0: add CMT1 clock support for DT
>   ARM: shmobile: sh73a0: Add CMT1 node
>   ARM: shmobile: kzm9g-reference: Initialise CMT1 device using DT
> 
>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    | 18 +++-
>  arch/arm/boot/dts/r8a73a4.dtsi                     | 52 ++++++++++++
>  .../boot/dts/r8a7740-armadillo800eva-reference.dts | 22 ++++-
>  arch/arm/boot/dts/r8a7740.dtsi                     | 97 ++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7778-bockw-reference.dts      | 18 +++-
>  arch/arm/boot/dts/r8a7778.dtsi                     | 78 +++++++++++++++++
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       | 18 +++-
>  arch/arm/boot/dts/sh73a0.dtsi                      | 83 ++++++++++++++++++
>  arch/arm/mach-shmobile/board-ape6evm-reference.c   |  1 -
>  .../board-armadillo800eva-reference.c              |  3 +-
>  arch/arm/mach-shmobile/clock-r8a73a4.c             |  7 ++
>  arch/arm/mach-shmobile/clock-r8a7740.c             | 21 +++--
>  arch/arm/mach-shmobile/clock-r8a7778.c             |  8 ++
>  arch/arm/mach-shmobile/clock-sh73a0.c              | 10 +++
>  arch/arm/mach-shmobile/r8a73a4.h                   |  1 -
>  arch/arm/mach-shmobile/r8a7740.h                   |  1 -
>  arch/arm/mach-shmobile/setup-r8a73a4.c             | 21 ++---
>  arch/arm/mach-shmobile/setup-r8a7740.c             | 18 +---
>  arch/arm/mach-shmobile/setup-r8a7778.c             | 15 ++--
>  arch/arm/mach-shmobile/setup-sh73a0.c              | 11 +--
>  20 files changed, 431 insertions(+), 72 deletions(-)
> 
> -- 
> 2.0.0.rc2
> 
