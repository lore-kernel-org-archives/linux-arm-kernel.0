From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 6 May 2014 11:15:29 +0530
Subject: [PATCH v4 0/5] ARM: DRA7: Add support for DRA72x devices
In-Reply-To: <1398769513-8736-1-git-send-email-rnayak@ti.com>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Message-ID: <536876F9.7000707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 04:35 PM, Rajendra Nayak wrote:
> changes in v4:
> -1- used full SoC names in compatibles eg "ti,dra742" and "ti,dra722"
> -2- Created a seperate patch for replacing __initdata with __initconst
> 
> changes in v3:
> Removed wildcards from compatible strings and duplicates from
> .dt_compat strings as suggested by Arnd
> 
> DRA72x devices are single core Cortex A15 devices belonging to the
> DRA7 family (Similar to the DRA74x devices which are dual core Cortex
> A15 based)
> 
> The patches (based off 3.15-rc3) add minimal DT/kernel modifications to add
> boot support on DRA722 device reusing all the kernel data for DRA742 device.

Tony, Can this series be pulled in for 3.16? Patch 2/5 and 4/5 are acked by Arnd.
Patch 5/5 can be dropped since there are no users for soc_is_dra7**() at the moment.

> 
> Rajendra Nayak (5):
>   ARM: dts: dra7-evm: Remove the wrong and undocumented compatible
>   ARM: dts: Add support for DRA72x family of devices
>   ARM: OMAP2+: Replace all __initdata with __initconst for const init
>   ARM: OMAP2+: Add machine entry for dra72x devices
>   ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x()
>     varients
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |   12 ++++--
>  arch/arm/boot/dts/Makefile                         |    3 +-
>  arch/arm/boot/dts/dra7-evm.dts                     |    6 +--
>  arch/arm/boot/dts/dra7.dtsi                        |   27 ------------
>  arch/arm/boot/dts/dra72-evm.dts                    |   24 +++++++++++
>  arch/arm/boot/dts/dra72x.dtsi                      |   25 +++++++++++
>  arch/arm/boot/dts/dra74x.dtsi                      |   41 ++++++++++++++++++
>  arch/arm/mach-omap2/board-generic.c                |   45 ++++++++++++++------
>  arch/arm/mach-omap2/soc.h                          |    7 +++
>  9 files changed, 142 insertions(+), 48 deletions(-)
>  create mode 100644 arch/arm/boot/dts/dra72-evm.dts
>  create mode 100644 arch/arm/boot/dts/dra72x.dtsi
>  create mode 100644 arch/arm/boot/dts/dra74x.dtsi
> 
