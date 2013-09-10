From: B38611@freescale.com (Duan Fugang-B38611)
Date: Tue, 10 Sep 2013 01:26:49 +0000
Subject: [PATCH v2 2/4] ARM: dts: add fec phy reset for imx6sl evk board
In-Reply-To: <20130909145333.GA5815@S2101-09.ap.freescale.net>
References: <1378182385-9205-1-git-send-email-B38611@freescale.com>
 <1378182385-9205-3-git-send-email-B38611@freescale.com>
 <20130909145333.GA5815@S2101-09.ap.freescale.net>
Message-ID: <9848F2DB572E5649BA045B288BE08FBE016A7AB8@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo [mailto:shawn.guo at linaro.org]
Sent: Monday, September 09, 2013 10:54 PM + 800

> To: Duan Fugang-B38611
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 2/4] ARM: dts: add fec phy reset for imx6sl evk
> board
> 
> On Tue, Sep 03, 2013 at 12:26:23PM +0800, Fugang Duan wrote:
> > Add fec phy gpio reset for imx6sl evk board. imx6sl evk board use
> > GPIO4_21 to do phy reset, so add phy-reset-gpios and
> > phy-reset-duration propery initial for fec device node.
> >
> > Signed-off-by: Fugang Duan  <B38611@freescale.com>
> 
> I have to drop this patch for now, because it causes a regression for me.
> 
> Before this patch, we can at least get a working fec driver in kernel if
> U-Boot sets it up properly, e.g. we download kernel from network.  But
> with the patch, the fec driver stops working on linux-next in the same use
> case.
> 
> Shawn

Shawn, you cannot drop this patch.
1. Why do you get a working fec driver in kernel if U-Boot sets it up properly ?
   Because the phy reset done by uboot, kernel cannot depend on uboot.
   And even so, the driver still have problem for unit test.
2. You see freescale internal kernel(3.10.9) work fine. There have one driver patch don't upstream.
   I will send it out to net tree for review.

Thanks,
Andy
> 
> > ---
> >  arch/arm/boot/dts/imx6sl-evk.dts |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6sl-evk.dts
> > b/arch/arm/boot/dts/imx6sl-evk.dts
> > index 2886a59..c4d32a5 100644
> > --- a/arch/arm/boot/dts/imx6sl-evk.dts
> > +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> > @@ -23,6 +23,8 @@
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_fec_1>;
> >  	phy-mode = "rmii";
> > +	phy-reset-gpios = <&gpio4 21 0>; /* GPIO4_21 */
> > +	phy-reset-duration = <1>;
> >  	status = "okay";
> >  };
> >
> > @@ -38,6 +40,7 @@
> >  				MX6SL_PAD_SD2_DAT7__GPIO5_IO00    0x17059
> >  				MX6SL_PAD_SD2_DAT6__GPIO4_IO29    0x17059
> >  				MX6SL_PAD_REF_CLK_32K__GPIO3_IO22 0x17059
> > +				MX6SL_PAD_FEC_TX_CLK__GPIO4_IO21  0x80000000
> >  			>;
> >  		};
> >  	};
> > --
> > 1.7.1
> >
> >
