From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 18 Sep 2013 10:05:18 -0700
Subject: [PATCH 2/2] arm: zynq: Enable arm_global_timer
In-Reply-To: <20130915124036.A66A8C42C3C@trevor.secretlab.ca>
References: <1379004640-15117-1-git-send-email-soren.brinkmann@xilinx.com>
 <1379004640-15117-3-git-send-email-soren.brinkmann@xilinx.com>
 <20130915124036.A66A8C42C3C@trevor.secretlab.ca>
Message-ID: <9c796de2-4f19-4104-ae69-60f963a65d03@CH1EHSMHS028.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 15, 2013 at 01:40:36PM +0100, Grant Likely wrote:
> On Thu, 12 Sep 2013 09:50:40 -0700, Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> > Zynq is based on an ARM Cortex-A9 MPCore, which features the
> > arm_global_timer in its SCU. Therefore enable the timer for Zynq.
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  arch/arm/boot/dts/zynq-7000.dtsi | 8 ++++++++
> >  arch/arm/mach-zynq/Kconfig       | 1 +
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> > index e32b92b..eaacb39 100644
> > --- a/arch/arm/boot/dts/zynq-7000.dtsi
> > +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> > @@ -92,6 +92,14 @@
> >  			};
> >  		};
> >  
> > +		global_timer: global_timer at f8f00200 {
> 
> Nit: node names and property names use '-' not '_'. Plus the generic
> names principle suggests the node should be names 'timer' not
> 'global_timer'. The following would be fine:
That is really good to know. When I wrote this line, I read through a
couple of other dtses and was unable to identify a consistent system
behind node/label names.

> 
> 		global_timer: timer at f8f00200 {
All right, I'll change it to this.

	
	Thanks,
	S?ren
