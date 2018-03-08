From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Mar 2018 14:44:26 +0100
Subject: [PATCH v4 0/7] Initial support for NVIDIA Tegra194
In-Reply-To: <20180220115812.24108-1-mperttunen@nvidia.com>
References: <20180220115812.24108-1-mperttunen@nvidia.com>
Message-ID: <20180308134426.GE3529@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 01:58:05PM +0200, Mikko Perttunen wrote:
> Hello everyone,
> 
> this series adds initial support for the NVIDIA Tegra194 "Xavier"
> system-on-chip. Initially UART, I2C, SDMMC, as well as the PMIC
> are supported, allowing booting to a console.
> 
> The changes consist almost completely of the new device trees,
> however some fixes are required in the BPMP driver to support the
> new channel layout in Tegra194.
> 
> The series has been tested on Tegra186 (Jetson TX2) and Tegra194
> (P2972).
> 
> Cheers,
> Mikko
> 
> Mikko Perttunen (7):
>   firmware: tegra: Simplify channel management
>   soc/tegra: Add Tegra194 SoC configuration option
>   soc/tegra: pmc: Add Tegra194 compatibility string
>   dt-bindings: tegra: Add missing chips and NVIDIA boards
>   dt-bindings: tegra: Add documentation for nvidia,tegra194-pmc
>   arm64: tegra: Add Tegra194 chip device tree
>   arm64: tegra: Add device tree for the Tegra194 P2972-0000 board
> 
>  Documentation/devicetree/bindings/arm/tegra.txt    |  16 +
>  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |   2 +
>  arch/arm64/boot/dts/nvidia/Makefile                |   1 +
>  arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     | 248 +++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |  16 +
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 344 +++++++++++++++++++++
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/firmware/tegra/bpmp.c                      | 142 ++++-----
>  drivers/soc/tegra/Kconfig                          |  10 +
>  drivers/soc/tegra/pmc.c                            |   1 +
>  include/dt-bindings/clock/tegra194-clock.h         | 321 +++++++++++++++++++
>  include/dt-bindings/gpio/tegra194-gpio.h           |  61 ++++
>  include/dt-bindings/power/tegra194-powergate.h     |  35 +++
>  include/dt-bindings/reset/tegra194-reset.h         | 152 +++++++++
>  include/soc/tegra/bpmp.h                           |   4 +-
>  15 files changed, 1274 insertions(+), 80 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra194.dtsi
>  create mode 100644 include/dt-bindings/clock/tegra194-clock.h
>  create mode 100644 include/dt-bindings/gpio/tegra194-gpio.h
>  create mode 100644 include/dt-bindings/power/tegra194-powergate.h
>  create mode 100644 include/dt-bindings/reset/tegra194-reset.h

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/32a269f5/attachment.sig>
