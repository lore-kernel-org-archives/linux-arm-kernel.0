From: ranjit.waghmode@xilinx.com (Ranjit Abhimanyu Waghmode)
Date: Mon, 8 Jun 2015 12:59:23 +0000
Subject: [LINUX RFC V2 1/2] devicetree: Add DT bindings documentation
 for Zynq Ultrascale+ MPSoC GQSPI controller
In-Reply-To: <20150605160017.GA8863@xsjsorenbubuntu>
References: <1433509653-15142-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150605160017.GA8863@xsjsorenbubuntu>
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3CA7115F@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

> >  .../devicetree/bindings/spi/spi-zynqmp-qspi.txt    | 26
> ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
> > b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
> > new file mode 100644
> > index 0000000..cec6330
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
> > @@ -0,0 +1,26 @@
> > +Xilinx Zynq UltraScale+ MPSoC GQSPI controller Device Tree Bindings
> > +-------------------------------------------------------------------
> > +
> > +Required properties:
> > +- compatible               : Should be "xlnx,zynqmp-qspi-1.0".
> > +- reg                      : Physical base address and size of GQSPI registers map.
> > +- interrupts               : Property with a value describing the interrupt
> > +                     number.
> > +- interrupt-parent : Must be core interrupt controller.
> > +- clock-names              : List of input clock names - "ref_clk", "pclk"
> > +                     (See clock bindings for details).
> > +- clocks           : Clock phandles (see clock bindings for details).
> > +
> > +Optional properties:
> > +- num-cs           : Number of chip selects used.
> > +
> > +Example:
> > +   qspi: spi at ff0f0000 {
> > +           compatible = "xlnx,zynqmp-qspi-1.0";
> > +           clock-names = "ref_clk", "pclk";
> > +           clocks = <&misc_clk &misc_clk>;
> > +           interrupts = <0 15 4>;
> > +           interrupt-parent = <&gic>;
> > +           num-cs = <1>;
> > +           reg = <0x0 0xff0f0000 0x1000 0x0 0xc0000000 0x8000000>;
>
> Please make this
>   reg = <0x0 0xff0f0000 0x1000>, <0x0 0xc0000000 0x8000000>;
>

Sorry for this miss. Will update in next version.

Regards,
Ranjit Waghmode,
ranjitw at xilinx.com


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
