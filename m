From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Fri, 25 Jul 2014 03:49:23 +0000
Subject: [PATCH v2 00/11] ARM: dts: zynq: Prepare Parallella
In-Reply-To: <1406242820-20140-1-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
Message-ID: <dc23839c-7a69-4674-9d92-80a1d68e9b23@BY2FFO11FD003.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

>-----Original Message-----
>From: Andreas F?rber [mailto:afaerber at suse.de]
>Sent: Friday, July 25, 2014 4:30 AM
>To: Michal Simek
>Cc: Andreas Olofsson; Matteo Vit; Sean Rickerd; devicetree at vger.kernel.org;
>linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Andreas
>F?rber; Punnaiah Choudary Kalluri; Lars-Peter Clausen
>Subject: [PATCH v2 00/11] ARM: dts: zynq: Prepare Parallella
>
>Hello,
>
>This patch series adds an initial device tree for the Parallella board.
>UART, SD card, Ethernet are enabled.
>Not yet enabled are HDMI, QSPI flash and 2x USB.
>
>v2 adds some SPI and FPGA pieces and tidies the device tree with a
>compatible string and matching documentation.
>
>Not having all pieces for testing all of this (most notably I'm missing
>ADI ADV7513 and AXI-HDMI support for VDMA and axi-clkgen, as well as
>the 25Q128A flash chip for QSPI), I've kept new things in separate patches
>so that we can make progress on the basic version and possibly squash
>further cherry-picked pieces.
>
>Punnaiah Choudary Kalluri had recently proposed to extend the Chipidea
>USB driver for Zynq; it kept complaining about the PHY though, and I
>haven't spotted a revised version based on the generic driver yet.
>https://patchwork.kernel.org/patch/4434681/

The plan is, go with generic chip idea driver which is currently under review. 
http://www.spinics.net/lists/linux-usb/msg109576.html

So, please wait some more time for extending the Chip idea driver support
 to zynq.

Punnaiah
>
>My rebasing work branch is here:
>https://github.com/afaerber/linux/commits/parallella-next
>
>Regards,
>Andreas
>
>Cc: Punnaiah Choudary Kalluri <punnaia@xilinx.com> (USB)
>Cc: Lars-Peter Clausen <lars@metafoo.de> (HDMI)
>
>Andreas F?rber (11):
>  Documentation: devicetree: Adapteva vendor prefix
>  Documentation: devicetree: Adapteva boards
>  ARM: dts: zynq: Add Parallella device tree
>  ARM: dts: zynq: Update deprecated xuartps clock names
>  ARM: dts: zynq: Add QSPI for Parallella
>  ARM: dts: zynq: Add DMAC for Parallella
>  Documentation: devicetree: Fix Xilinx VDMA specification
>  ARM: dts: zynq: Add VDMA to Parallella
>  Documentation: devicetree: Fix ADI AXI SPDIF specification
>  ARM: dts: zynq: Add SPDIF for Parallella
>  ARM: dts: zynq: Add AXI clkgen for Parallella
>
> Documentation/devicetree/bindings/arm/adapteva.txt |   7 ++
> .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt |   2 +-
> .../devicetree/bindings/sound/adi,axi-spdif-tx.txt |   2 +-
> .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> arch/arm/boot/dts/Makefile                         |   4 +-
> arch/arm/boot/dts/zynq-7000.dtsi                   |  58 +++++++++-
> arch/arm/boot/dts/zynq-parallella.dts              | 119
>+++++++++++++++++++++
> 7 files changed, 188 insertions(+), 5 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt
> create mode 100644 arch/arm/boot/dts/zynq-parallella.dts
>
>--
>1.9.3
