From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Tue, 30 Aug 2016 15:01:37 +0000
Subject: [PATCH v2 0/6] Add support for Tegra GMI bus controller
In-Reply-To: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
References: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
Message-ID: <1472569295.5703.20.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mirza

Sorry, I long since wanted to give you some feedback on this as well.

BTW: Thank you very much for taking this on!

On Wed, 2016-08-24 at 15:37 +0200, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Hi.
> 
> This is a follow up to my previous RFC to add support for Tegra GMI
> bus
> controller.
> 
> I have tested this series on a Tegra30 using a Colibri T30 SOM on a
> custom
> carrier board which has multiple CAN controllers (SJA1000) connected
> to the
> GMI bus.

We once did a nice GMI-Memory Board which mates with the extension
connector X3 of our V3.x Colibri Evaluation boards and allows testing
SRAM access not only in muxed but also in non-muxed mode albeit 16-bit
only. I took your driver for a spin both on Colibri T20 as well as
Colibri T30 both in muxed as well as non-muxed mode and it passed all
tests being both manual devmem2 type reads/writes as well as memtester
runs on the full 128K SRAM giving it the physical address using the -p
argument.

So you may add the following to the whole series:

Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Tested-on: Colibri T20/T30 on EvalBoard V3.x and GMI-Memory Board

I will leave further comments on the individual patches.

BTW: Of course for non-muxed mode I also had to adjust the pin muxing
as they default to muxed.

> I have rebased on top of latest tegra/for-next in V2. Also see
> individual
> patches for changes in V2.
> 
> See below links for previous discussions.
> 
> Comments on RFC:
> https://marc.info/?l=linux-clk&m=146893557629903&w=2
> https://marc.info/?l=linux-tegra&m=146893541829801&w=2
> https://marc.info/?l=linux-tegra&m=146893542429814&w=2
> 
> Comments on V1:
> https://marc.info/?l=linux-arm-kernel&m=147051551821122&w=2
> https://marc.info/?l=linux-arm-kernel&m=147051553121150&w=2
> https://marc.info/?l=linux-arm-kernel&m=147194856600627&w=2
> https://marc.info/?l=linux-arm-kernel&m=147072742432211&w=2
> 
> 
> Mirza Krak (6):
> ? clk: tegra: add TEGRA20_CLK_NOR to init table
> ? clk: tegra: add TEGRA30_CLK_NOR to init table
> ? dt/bindings: Add bindings for Tegra GMI controller
> ? ARM: tegra: Add Tegra30 GMI support
> ? ARM: tegra: Add Tegra20 GMI support
> ? bus: Add support for Tegra Generic Memory Interface
> 
> ?.../devicetree/bindings/bus/nvidia,tegra20-gmi.txt | 132
> ++++++++++++
> ?arch/arm/boot/dts/tegra20.dtsi?????????????????????|??13 ++
> ?arch/arm/boot/dts/tegra30.dtsi?????????????????????|??12 ++
> ?drivers/bus/Kconfig????????????????????????????????|???8 +
> ?drivers/bus/Makefile???????????????????????????????|???1 +
> ?drivers/bus/tegra-gmi.c????????????????????????????| 231
> +++++++++++++++++++++
> ?drivers/clk/tegra/clk-tegra20.c????????????????????|???1 +
> ?drivers/clk/tegra/clk-tegra30.c????????????????????|???1 +
> ?8 files changed, 399 insertions(+)
> ?create mode 100644
> Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
> ?create mode 100644 drivers/bus/tegra-gmi.c
> 
> --
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at??http://vger.kernel.org/majordomo-info.html

Cheers

Marcel
