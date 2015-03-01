From: horms@verge.net.au (Simon Horman)
Date: Sun, 1 Mar 2015 11:17:38 +0900
Subject: [PATCH/RFC] ARM: shmobile: r8a7791: Fix IPMMU-GP clock to device
 tree
In-Reply-To: <20150225235806.GM23723@verge.net.au>
References: <1424352546-27313-1-git-send-email-ykaneko0929@gmail.com>
 <20150225235806.GM23723@verge.net.au>
Message-ID: <20150301021737.GC31918@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 08:58:07AM +0900, Simon Horman wrote:
> On Thu, Feb 19, 2015 at 10:29:06PM +0900, Yoshihiro Kaneko wrote:
> > From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > 
> > Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > ---
> > 
> > This patch is based on devel branch of Simon Horman's renesas tree.
>
> Hi,
> 
> while I am inclined to take this patch on face value I am wondering
> if anyone is able to confirm this change against the documentation:
> I have drawn a blank there.

I have decided to queue this up rather than let it fester any longer.

> >  arch/arm/boot/dts/r8a7791.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> > index afba8af..1e75a5f 100644
> > --- a/arch/arm/boot/dts/r8a7791.dtsi
> > +++ b/arch/arm/boot/dts/r8a7791.dtsi
> > @@ -1154,7 +1154,7 @@
> >  		mstp8_clks: mstp8_clks at e6150990 {
> >  			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
> >  			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> > -			clocks = <&zg_clk>, <&hp_clk>, <&zg_clk>, <&zg_clk>,
> > +			clocks = <&zx_clk>, <&hp_clk>, <&zg_clk>, <&zg_clk>,
> >  			         <&zg_clk>, <&p_clk>, <&zs_clk>, <&zs_clk>;
> >  			#clock-cells = <1>;
> >  			clock-indices = <
> > -- 
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
