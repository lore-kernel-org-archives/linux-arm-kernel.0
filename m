From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 May 2017 13:12:35 +0200
Subject: [PATCH 2/3] arm64: dts: rockchip: add ethernet alias on rk3399
In-Reply-To: <20170523101540.txul7g3liyylg273@tarshish>
References: <20170523095427.7421-1-heiko@sntech.de>
 <20170523095427.7421-2-heiko@sntech.de>
 <20170523101540.txul7g3liyylg273@tarshish>
Message-ID: <1806134.4LkeRaXReF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

Am Dienstag, 23. Mai 2017, 13:15:40 CEST schrieb Baruch Siach:
> On Tue, May 23, 2017 at 11:54:26AM +0200, Heiko Stuebner wrote:
> > This is used by bootloaders to override the mac address in the devicetree
> > if needed.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > index db713c67ae17..3e1b1daa0964 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > @@ -56,6 +56,7 @@
> >  	#size-cells = <2>;
> >  
> >  	aliases {
> > +		ethernet = &gmac;
> 
> Consider adding an index number. E.g., see commit 10b6c0c2e2bb8c (ARM: dts: 
> bcm2835: add index to the ethernet alias).

I'm not so sure about that. At least the reason to work around uboot issues
is gone since u-boot commit 
	f8e57c650d69 (fdt_support: Fixup 'ethernet' aliases not ending in digits)
from march 20th 2017.

The rk3399 only has one ethernet controller, but the rk3288 also uses the
ethernet0 suffix, so it definitly makes sense to add it for rk3399 as well.

So tl;dr, I'll make this ethernet0 when applying :-)


Thanks for noticing
Heiko

    
