From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Apr 2013 01:14:13 +0900
Subject: [PATCH] ARM: shmobile: Include all 2 GiB of memory on APE6EVM
In-Reply-To: <20130409123433.GD15412@verge.net.au>
References: <20130408014444.18767.64441.sendpatchset@w520>
 <20130409123433.GD15412@verge.net.au>
Message-ID: <20130409161410.GA16003@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 09:34:34PM +0900, Simon Horman wrote:
> On Mon, Apr 08, 2013 at 10:44:44AM +0900, Magnus Damm wrote:
> > From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> > 
> > Add 1GiB of DRAM at 0x2_0000_0000
> > 
> > Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Thanks, queued up in the boards-ape6evm branch.

I have dropped this patch as it appears to prevent
the board from booting.

> 
> > ---
> > 
> >  This patch simply updates the DTS to describe the actual board
> >  hardware. If we want to make use of the memory we also need to
> >  enable LPAE in the kernel configuration, but that is seen as a
> >  separate step.
> > 
> >  arch/arm/boot/dts/r8a73a4-ape6evm.dts |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > --- 0001/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> > +++ work/arch/arm/boot/dts/r8a73a4-ape6evm.dts	2013-04-08 10:27:20.000000000 +0900
> > @@ -24,6 +24,11 @@
> >  		reg = <0 0x40000000 0 0x40000000>;
> >  	};
> >  
> > +	memory at 200000000 {
> > +		device_type = "memory";
> > +		reg = <2 0x00000000 0 0x40000000>;
> > +	};
> > +
> >  	ape6evm_fixed_3v3: fixedregulator at 0 {
> >  		compatible = "regulator-fixed";
> >  		regulator-name = "3V3";
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
