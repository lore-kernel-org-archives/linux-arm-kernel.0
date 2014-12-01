From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 1 Dec 2014 13:24:59 -0800
Subject: [PATCH] ARM: zynq: DT: Add USB to device tree
In-Reply-To: <547CCEE3.6020806@suse.de>
References: <1417459352-23401-1-git-send-email-soren.brinkmann@xilinx.com>
 <547CCEE3.6020806@suse.de>
Message-ID: <fb6f17c51aef4a498eb2a3e01a81df34@BN1BFFO11FD017.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-12-01 at 09:26PM +0100, Andreas F?rber wrote:
> Hi S?ren,
> 
> Am 01.12.2014 um 19:42 schrieb Soren Brinkmann:
> > Add USB nodes to zc702, zc706 and zed device trees.
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  arch/arm/boot/dts/zynq-7000.dtsi | 22 +++++++++++++++++++++-
> >  arch/arm/boot/dts/zynq-zc702.dts | 11 +++++++++++
> >  arch/arm/boot/dts/zynq-zc706.dts | 10 ++++++++++
> >  arch/arm/boot/dts/zynq-zed.dts   | 10 ++++++++++
> >  4 files changed, 52 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> > index ce2ef5bec4f2..9ed60938f301 100644
> > --- a/arch/arm/boot/dts/zynq-7000.dtsi
> > +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> > @@ -315,6 +315,26 @@
> >  			clocks = <&clkc 4>;
> >  		};
> >  
> > +		usb0: usb at e0002000 {
> > +			compatible = "xlnx,zynq-usb-2.20a", "chipidea,usb2";
> > +			status = "disabled";
> > +			clocks = <&clkc 28>;
> > +			interrupt-parent = <&intc>;
> > +			interrupts = <0 21 4>;
> > +			reg = <0xe0002000 0x1000>;
> > +			phy_type = "ulpi";
> > +		};
> > +
> > +		usb1: usb at e0003000 {
> > +			compatible = "xlnx,zynq-usb-2.20a", "chipidea,usb2";
> > +			status = "disabled";
> > +			clocks = <&clkc 29>;
> > +			interrupt-parent = <&intc>;
> > +			interrupts = <0 44 4>;
> > +			reg = <0xe0003000 0x1000>;
> > +			phy_type = "ulpi";
> > +		};
> > +
> >  		watchdog0: watchdog at f8005000 {
> >  			clocks = <&clkc 45>;
> >  			compatible = "xlnx,zynq-wdt-r1p2";
> 
> This part looks good.
> 
> > @@ -324,6 +344,6 @@
> >  			reg = <0xf8005000 0x1000>;
> >  			reset = <0>;
> >  			timeout-sec = <10>;
> > -		};
> > +		} ;
> >  	};
> >  };
> 
> Unrelated accidental change here though. :)
> 
> Did I miss a matching series actually implementing the driver? I'd need
> to test the latest version to determine how to update the Parallella
> device tree - I assume that USB0 is in dr_mode="host", but with the
> previous patchsets I was unable to verify. CC'ing Ola.

It was merged to the USB tree recently. I tested this on linux-next.

	S?ren
