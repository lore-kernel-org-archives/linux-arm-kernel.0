From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 23 Nov 2015 11:35:42 +0300
Subject: PING: [PATCH v9 0/4] Exynos SROMc configuration and Ethernet support
 for SMDK5410
Message-ID: <00d601d125c9$f1231f00$d3695d00$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello! So what's up? I see SROM driver suddenly removed from everywhere and no single word about it. What is the status?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia


> -----Original Message-----
> From: linux-samsung-soc-owner at vger.kernel.org [mailto:linux-samsung-soc-owner at vger.kernel.org]
> On Behalf Of Pavel Fedin
> Sent: Monday, November 16, 2015 10:43 AM
> To: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org; linux-kernel at vger.kernel.org
> Cc: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; Kukjin Kim; Krzysztof
> Kozlowski
> Subject: [PATCH v9 0/4] Exynos SROMc configuration and Ethernet support for SMDK5410
> 
> This patch extends Exynos SROM controller driver with ability to configure
> controller outputs and enables SMSC9115 Ethernet chip on SMDK5410 board,
> which is connected via SROMc bank #3.
> 
> With this patchset, support for the whole existing SMDK range can be added.
> Actually, only bank number is different.
> 
> This patchset also depends on Exynos 5410 pinctrl support, introduced by
> patches 0003 and 0004 from this set:
> [PATCH v4 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330862.html
> 
> Pinctrl support is necessary in order to correctly configure
> multifunctional pins of the Exynos chip.
> 
> v8 => v9:
> - Fixed node suffix in ethernet chip DT node (@3,0 instead of @3)
> 
> v7 => v8:
> - More fixes to documentation
> 
> v6 => v7:
> - Fixed stupid error in Tacc description in the documentation
> 
> v5 => v6:
> - Even more improvements to the documentation, fixed some errors and typos.
> - Separated adding bus ranges from generic SROMc support
> - Some stuff renamed for even better code readability
> - Stylistic cleanups in the DTS (everything in alphabetic order, use named
>   constant name for interrupt config byte)
> 
> v4 => v5:
> - Some cosmetic changes in the dtsi ("compatible" goes first)
> - Use correctly specified ranges for the SROMc node
> - Reuse existing properties where possible ("reg" for bank# and
>   "reg-io-width" for data width)
> - Separated page-mode property from timings array
> - More improvements to the documentation
> 
> v3 => v4:
> - Devices are now added as subnodes, with additional properties. This allows
>   to cleary specify dependency. If configuration fails, error will be reported
>   and child devices will not be probed.
> - These additional properties now have "samsung,srom-XXX" format
> - Fixed code style, now better understood.
> 
> v2 => v3:
> - Fixed up SROMc region size in the device tree
> - Reordered patches, documentation goes first now
> 
> v1 => v2:
> - Fixed some typos and bad labels in device tree
> - Improved documentation
> 
> Pavel Fedin (4):
>   Documentation: dt-bindings: Describe SROMc configuration
>   ARM: dts: Add SROMc to Exynos 5410
>   drivers: exynos-srom: Add support for bank configuration
>   ARM: dts: Add Ethernet chip to SMDK5410
> 
>  .../bindings/arm/samsung/exynos-srom.txt           | 73 +++++++++++++++++++++-
>  arch/arm/boot/dts/exynos5410-smdk5410.dts          | 41 ++++++++++++
>  arch/arm/boot/dts/exynos5410.dtsi                  | 11 ++++
>  arch/arm/mach-exynos/Kconfig                       |  2 +-
>  drivers/soc/samsung/Kconfig                        |  2 +-
>  drivers/soc/samsung/exynos-srom.c                  | 61 +++++++++++++++++-
>  6 files changed, 184 insertions(+), 6 deletions(-)
> 
> --
> 2.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
