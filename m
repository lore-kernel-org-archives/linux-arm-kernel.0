From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 26 Jan 2015 16:32:55 -0800
Subject: [PATCH v4 6/7] ARM: zynq: DT: Add pinctrl information
In-Reply-To: <54C6D44C.4060106@suse.de>
References: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
 <1420818231-13451-7-git-send-email-soren.brinkmann@xilinx.com>
 <54C6D44C.4060106@suse.de>
Message-ID: <db3077a2f9d8410f95cfd71f7e167494@BY2FFO11FD034.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-27 at 12:57AM +0100, Andreas F?rber wrote:
> Am 09.01.2015 um 16:43 schrieb Soren Brinkmann:
> > Add pinctrl descriptions to the zc702 and zc706 device trees.
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > Tested-by: Andreas F?rber <afaerber@suse.de>
> > ---
> > Changes since v1:
> >  - remove 'pinctrl-' prefix for pinctrl sub-nodes
> >  - separate config and mux nodes
> > 
> > Changes since RFC v2:
> >  - add pinconf properties to zc702 mdio node
> >  - remove arguments from bias-related props
> > 
> > Changes since RFC v1:
> >  - separate DT changes into their own patch
> > ---
> >  arch/arm/boot/dts/zynq-7000.dtsi |   8 +-
> >  arch/arm/boot/dts/zynq-zc702.dts | 181 +++++++++++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/zynq-zc706.dts | 152 ++++++++++++++++++++++++++++++++
> >  3 files changed, 340 insertions(+), 1 deletion(-)
> [...]
> > diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> > index 280f02dd4ddc..4995412f116f 100644
> > --- a/arch/arm/boot/dts/zynq-zc702.dts
> > +++ b/arch/arm/boot/dts/zynq-zc702.dts
> [...]
> > @@ -50,15 +52,24 @@
> >  	status = "okay";
> >  	phy-mode = "rgmii-id";
> >  	phy-handle = <&ethernet_phy>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_gem0_default>;
> >  
> >  	ethernet_phy: ethernet-phy at 7 {
> >  		reg = <7>;
> >  	};
> >  };
> >  
> > +&gpio0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_gpio0_default>;
> 
> On linux-next the equivalent no longer works for the Parallella, with
> gpio failing to probe.
> 
> If I move these two properties to the leds node (for which I am
> configuring gpio 7) then I get a heartbeat as before.

Moving this away from the gpio node seems wrong. IMHO, it should be
where it is. I guess, there might be some issues with probe
ordering/deferral that we may have to sort out.

	S?ren
