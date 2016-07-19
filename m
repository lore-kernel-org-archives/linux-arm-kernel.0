From: mirza.krak@gmail.com (Mirza Krak)
Date: Tue, 19 Jul 2016 15:36:31 +0200
Subject: [RFC 0/6] Add support for Tegra20/30 NOR bus controller
Message-ID: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

Hi.

Sending this series as RFC since I have some uncertainties.

What I am attempting to do with this series is to add support for the NOR flash
controller which can be found on Tegra20 and Tegra30 SOCs. This controller is
also references as SNOR and GMI in the NVIDIA TRM.

I have tested this series on a Tegra30 using a Colibri T30 SOM on a custom
carrier board which has multiple CAN controllers (SJA1000) connected to its
NOR bus.

Now to my question:

- I am not sure about the name of the driver. There was already CLK defines
for this controller in the kernel and their naming was TEGRA_NOR and I went with
that. But I certainly like the Generic Memory Interface (GMI) name better which
is used in the NVIDIA TRM. It does seem odd to connect CAN controllers to
something called a NOR bus.

- I am also not sure about the nvidia,config property. Is it preferred to split
this up? Splitting will probably create 10 different properties, rdy_polarity,
adv_polarity, oe_we_polarity and more.

- I also wanted to verify if I am on the correct path since I am a novice and
this would be my first driver to mainline.


Best Regards,
Mirza

Mirza Krak (6):
  clk: tegra: add TEGRA20_CLK_NOR to init table
  clk: tegra: add TEGRA30_CLK_NOR to init table
  dt/bindings: Add bindings for Tegra20/30 NOR bus driver
  ARM: tegra: Add Tegra30 NOR support
  ARM: tegra: Add Tegra20 NOR support
  bus: Add support for Tegra NOR controller

 .../devicetree/bindings/bus/nvidia,tegra20-nor.txt |  73 +++++++++++++
 arch/arm/boot/dts/tegra20.dtsi                     |  12 +++
 arch/arm/boot/dts/tegra30.dtsi                     |  11 ++
 drivers/bus/Kconfig                                |   7 ++
 drivers/bus/Makefile                               |   1 +
 drivers/bus/tegra-nor.c                            | 118 +++++++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c                    |   1 +
 drivers/clk/tegra/clk-tegra30.c                    |   1 +
 8 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
 create mode 100644 drivers/bus/tegra-nor.c

--
2.1.4
