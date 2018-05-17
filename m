From: jacopo@jmondi.org (jacopo mondi)
Date: Thu, 17 May 2018 11:01:10 +0200
Subject: [PATCH 5/6] ARM: dts: rcar-gen2: Remove unused VIN properties
In-Reply-To: <20180516221307.GF17948@bigcity.dyn.berto.se>
References: <1526488352-898-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526488352-898-6-git-send-email-jacopo+renesas@jmondi.org>
 <20180516221307.GF17948@bigcity.dyn.berto.se>
Message-ID: <20180517090110.GA20190@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

On Thu, May 17, 2018 at 12:13:07AM +0200, Niklas S?derlund wrote:
> Hi Jacopo,
>
> Thanks for your work.
>
> On 2018-05-16 18:32:31 +0200, Jacopo Mondi wrote:
> > The 'bus-width' and 'pclk-sample' properties are not parsed by the VIN
> > driver and only confuse users. Remove them in all Gen2 SoC that used
> > them.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> >  arch/arm/boot/dts/r8a7790-lager.dts   | 3 ---
> >  arch/arm/boot/dts/r8a7791-koelsch.dts | 3 ---
> >  arch/arm/boot/dts/r8a7791-porter.dts  | 1 -
> >  arch/arm/boot/dts/r8a7793-gose.dts    | 3 ---
> >  arch/arm/boot/dts/r8a7794-alt.dts     | 1 -
> >  arch/arm/boot/dts/r8a7794-silk.dts    | 1 -
> >  6 files changed, 12 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> > index 063fdb6..b56b309 100644
> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > @@ -873,10 +873,8 @@
> >  	port {
> >  		vin0ep2: endpoint {
> >  			remote-endpoint = <&adv7612_out>;
> > -			bus-width = <24>;
>
> I can't really make up my mind if this is a good thing or not. Device
> tree describes the hardware and not what the drivers make use of. And
> the fact is that this bus is 24 bits wide. So I'm not sure we should
> remove these properties. But I would love to hear what others think
> about this.
>

Just to point out those properties are not even documented in rcar-vin
bindings (actually, none of them was).

I feel it's wrong to have them here, as someone may think that
changing their value should actually change the VIN interface behavior,
which it's not true, leading to massive confusion and quite some code
digging for no reason (and they will get mad at us at some point, probably :)

Thanks
   j

> >  			hsync-active = <0>;
> >  			vsync-active = <0>;
> > -			pclk-sample = <1>;
> >  			data-active = <1>;
> >  		};
> >  	};
> > @@ -895,7 +893,6 @@
> >
> >  		vin1ep0: endpoint {
> >  			remote-endpoint = <&adv7180>;
> > -			bus-width = <8>;
> >  		};
> >  	};
> >  };
> > diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > index f40321a..9967666 100644
> > --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> > +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > @@ -849,10 +849,8 @@
> >
> >  		vin0ep2: endpoint {
> >  			remote-endpoint = <&adv7612_out>;
> > -			bus-width = <24>;
> >  			hsync-active = <0>;
> >  			vsync-active = <0>;
> > -			pclk-sample = <1>;
> >  			data-active = <1>;
> >  		};
> >  	};
> > @@ -870,7 +868,6 @@
> >
> >  		vin1ep: endpoint {
> >  			remote-endpoint = <&adv7180>;
> > -			bus-width = <8>;
> >  		};
> >  	};
> >  };
> > diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
> > index c14e6fe..055a7f1 100644
> > --- a/arch/arm/boot/dts/r8a7791-porter.dts
> > +++ b/arch/arm/boot/dts/r8a7791-porter.dts
> > @@ -391,7 +391,6 @@
> >
> >  		vin0ep: endpoint {
> >  			remote-endpoint = <&adv7180>;
> > -			bus-width = <8>;
> >  		};
> >  	};
> >  };
> > diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
> > index 9ed6961..9d3fba2 100644
> > --- a/arch/arm/boot/dts/r8a7793-gose.dts
> > +++ b/arch/arm/boot/dts/r8a7793-gose.dts
> > @@ -759,10 +759,8 @@
> >
> >  		vin0ep2: endpoint {
> >  			remote-endpoint = <&adv7612_out>;
> > -			bus-width = <24>;
> >  			hsync-active = <0>;
> >  			vsync-active = <0>;
> > -			pclk-sample = <1>;
> >  			data-active = <1>;
> >  		};
> >  	};
> > @@ -781,7 +779,6 @@
> >
> >  		vin1ep: endpoint {
> >  			remote-endpoint = <&adv7180_out>;
> > -			bus-width = <8>;
> >  		};
> >  	};
> >  };
> > diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
> > index 26a8834..4bbb9cc 100644
> > --- a/arch/arm/boot/dts/r8a7794-alt.dts
> > +++ b/arch/arm/boot/dts/r8a7794-alt.dts
> > @@ -380,7 +380,6 @@
> >
> >  		vin0ep: endpoint {
> >  			remote-endpoint = <&adv7180>;
> > -			bus-width = <8>;
> >  		};
> >  	};
> >  };
> > diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
> > index 351cb3b..c0c5d31 100644
> > --- a/arch/arm/boot/dts/r8a7794-silk.dts
> > +++ b/arch/arm/boot/dts/r8a7794-silk.dts
> > @@ -480,7 +480,6 @@
> >
> >  		vin0ep: endpoint {
> >  			remote-endpoint = <&adv7180>;
> > -			bus-width = <8>;
> >  		};
> >  	};
> >  };
> > --
> > 2.7.4
> >
>
> --
> Regards,
> Niklas S?derlund
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/c1578eef/attachment-0001.sig>
