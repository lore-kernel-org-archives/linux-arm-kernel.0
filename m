From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 29 Aug 2018 17:09:42 +0200
Subject: [PATCH] arm64: dts: add support for SolidRun Clearfog GT 8K
In-Reply-To: <8736uxxmai.fsf@tkos.co.il>
References: <3276b82491c1eda1e05a0e6b94560cfa451cf8d4.1535544789.git.baruch@tkos.co.il>
 <20180829141159.GB22270@lunn.ch> <8736uxxmai.fsf@tkos.co.il>
Message-ID: <20180829150942.GD22270@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The schematics say "AP Reset Switch". So it is probably meant to be a
> software controlled "back to default" button. Is there a suitable
> linux,code for that?

There is a reset code.

> It is not assembled here so I could not test. The schematics say SLB9670.

I think the standard SPI TPM TIS driver should work for that. But if
it is not populated, you cannot test it.

> >> +			port at 5 {
> >> +				reg = <5>;
> >> +				label = "cpu";
> >> +				ethernet = <&cp1_eth2>;
> >> +			};
> >
> > No fixed-link? It correctly defaults to 2.5G? I've never tested that.
> 
> Seems to work here

It would be good to test it really is using 2.5G, not 1G.

. There is also a patch from Rabeeh (which I did not
> apply while testing) to make it the default:
> 
>   https://github.com/SolidRun/openwrt/blob/openwrt-18.06-sr/target/linux/mvebu/patches-4.14/533-fix-88e6141-cpu-max-speed.patch

Which is why i don't think it actually is using 2.5G.

This patch will need a little rework, but it basically O.K. Change
mv88e6x41 to mv88e6341. We use the family name in function names.

	  Andrew
