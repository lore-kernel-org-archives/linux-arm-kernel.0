From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 23 Jan 2017 17:12:28 +0100
Subject: [PATCH v4 2/9] ARM: dts: rockchip: update compatible property for
 rk3228 timer
In-Reply-To: <20170123154046.GF2166@mai>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-3-git-send-email-al.kochet@gmail.com>
 <20170123154046.GF2166@mai>
Message-ID: <4475824.nuxyXyzqsG@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 23. Januar 2017, 16:40:46 CET schrieb Daniel Lezcano:
> On Tue, Nov 29, 2016 at 07:14:45PM +0300, Alexander Kochetkov wrote:
> > Property set to '"rockchip,rk3228-timer", "rockchip,rk3288-timer"'
> > to match devicetree bindings.
> > 
> > Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> > ---
> > 
> >  arch/arm/boot/dts/rk3228-evb.dts |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/rk3228-evb.dts
> > b/arch/arm/boot/dts/rk3228-evb.dts index 904668e..38eab87 100644
> > --- a/arch/arm/boot/dts/rk3228-evb.dts
> > +++ b/arch/arm/boot/dts/rk3228-evb.dts
> > @@ -70,3 +70,7 @@
> > 
> >  &uart2 {
> >  
> >  	status = "okay";
> >  
> >  };
> > 
> > +
> > +&timer {
> > +	compatible = "rockchip,rk3228-timer", "rockchip,rk3288-timer";
> > +};
> 
> I'm not sure this is correct, to which timer &timer will refer ?
> 
>         timer {
>                 compatible = "arm,armv7-timer";
> 		...
> 	}
> 
>         timer: timer at 110c0000 {
>                 compatible = "rockchip,rk3288-timer";
> 		...
> 	}
> 
> Why not change the compatible string in the timer definition in rk322x.dtsi
> ?
> 
> Same comment for the other patches doing these changes.

I think Alexander didn't know which timer name to use.
Both the rk3228 and rk3229 are so similar that so far no-one has seen any 
difference and thus they really share the whole rk322x.dtsi file.

On the other hand compatibles are supposed to be explicit, so a rk322x-timer 
compatible is not allowed.


But as the socs are soooo similar, I'd suggest just using the rk3228-timer 
compatible in the rk322x.dtsi and not changing individual board files.
Similar to what Daniel suggested.

Heiko
