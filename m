From: josh.cartwright@ni.com (Josh Cartwright)
Date: Fri, 2 Nov 2012 07:39:29 -0600
Subject: [PATCH 7/8] serial: xilinx_uartps: get clock rate info from dts
In-Reply-To: <50939061.9060201@metafoo.de>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <23a299ee5e89cfd17bb9affd8fbb9f41b79cfd46.1351721190.git.josh.cartwright@ni.com>
 <50939061.9060201@metafoo.de>
Message-ID: <20121102133929.GP5190@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 10:20:33AM +0100, Lars-Peter Clausen wrote:
> On 10/31/2012 08:28 PM, Josh Cartwright wrote:
> > Add support for specifying clock information for the uart clk via the
> > device tree.  This eliminates the need to hardcode rates in the device
> > tree.
> > 
> > Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> > ---
> >  arch/arm/boot/dts/zynq-7000.dtsi   |  4 ++--
> >  drivers/tty/serial/xilinx_uartps.c | 30 +++++++++++++++++-------------
> >  2 files changed, 19 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> > index bb3085c..5fb763f 100644
> > --- a/arch/arm/boot/dts/zynq-7000.dtsi
> > +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> > @@ -44,14 +44,14 @@
> >  			compatible = "xlnx,xuartps";
> >  			reg = <0xE0000000 0x1000>;
> >  			interrupts = <0 27 4>;
> > -			clock = <50000000>;
> > +			clocks = <&uart_clk 0>;
> >  		};
> >  
> >  		uart1: uart at e0001000 {
> >  			compatible = "xlnx,xuartps";
> >  			reg = <0xE0001000 0x1000>;
> >  			interrupts = <0 50 4>;
> > -			clock = <50000000>;
> > +			clocks = <&uart_clk 0>;
> 
> Shouldn't this be <&uart_clk 1>?

Yes, indeed.

Thanks,
  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121102/a37426c2/attachment.sig>
