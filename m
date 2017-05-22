From: kaloz@openwrt.org (Imre Kaloz)
Date: Mon, 22 May 2017 11:42:10 -0700
Subject: [PATCH 00/13] Linksys WRT3200ACM (Rango) support
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <b841be3c-24f2-41e8-29b7-8ea66b29bba3@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

For the whole series feel free to add

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>


Best,

Imre

On 2017-05-21 05:48, Ralph Sennhauser wrote:
> Hi everyone
>
> This series adds support for the latest model in Linksys WRT AC series
> of routers. The WRT3200ACM was released in October 2016 and the code
> name is Rango.
>
> As it comes with a flash chip twice as big the dts Imre Kaloz has
> written for OpenWrt isn't based on armada-385-linksys.dtsi to avoid
> conflicts. Nonetheless its part of the same family, so the bigger part
> of this series is dedicated to reorganize / modernize / cleanup /
> somewhat future proof the armada-385-linksys.dtsi and it's dependants so
> the dts for the Rango addition can use the same dtsi.
>
> Key differences to the earlier Armada-385 based devices in the series is
> a bigger flash chip, next generation wireless modules in the mini pcie
> slots as well as a Marvell SD8887. Finally the CPU is clocked at 1866
> GHz by default.
>
> The series depends on Linux 4.12-rc1 and is targeted for 4.13.
>
> Ralph
>
>
> Ralph Sennhauser (13):
>    ARM: dts: armada-385-linksys: flatten dtsi
>    ARM: dts: armada-385-linksys: label nodes
>    ARM: dts: armada-385-linksys: flatten dependan
>    ARM: dts: armada-385-linksys: drop redundant properties in dependants
>    ARM: dts: armada-385-linksys: bm pools by label order
>    ARM: dts: armada-385-linksys: usb3 label cleanup
>    ARM: dts: armada-385-linksys: drop leagcy DSA bindings
>    ARM: dts: armada-385-linksys: use binary unit prefixes
>    ARM: dts: armada-385-linksys: partition layout is board specific
>    ARM: dts: armada-385-linksys: group pins in pinctrl
>    ARM: dts: armada-385-linksys: fixup button node names
>    clk: mvebu: add support for 1866MHz variants
>    ARM: dts: mvebu: add support for Linksys WRT3200ACM (Rango)
>
>   arch/arm/boot/dts/Makefile                      |   1 +
>   arch/arm/boot/dts/armada-385-linksys-caiman.dts | 187 +++++++-----
>   arch/arm/boot/dts/armada-385-linksys-cobra.dts  | 187 +++++++-----
>   arch/arm/boot/dts/armada-385-linksys-rango.dts  | 203 +++++++++++++
>   arch/arm/boot/dts/armada-385-linksys-shelby.dts | 187 +++++++-----
>   arch/arm/boot/dts/armada-385-linksys.dtsi       | 362 ++++++++----------------
>   drivers/clk/mvebu/armada-38x.c                  |   3 +-
>   7 files changed, 695 insertions(+), 435 deletions(-)
>   create mode 100644 arch/arm/boot/dts/armada-385-linksys-rango.dts
>
