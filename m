From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 28 Apr 2016 22:33:07 +0200
Subject: [PATCH v4 2/4] ARM64: dts: rockchip: add core dtsi file for
 RK3399 SoCs
In-Reply-To: <20160428182938.GA3079@google.com>
References: <1461743693-10671-1-git-send-email-jay.xu@rock-chips.com>
 <20160428160353.GA95284@google.com> <20160428182938.GA3079@google.com>
Message-ID: <2138015.GmMsjTUH7U@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 28. April 2016, 11:29:38 schrieb Brian Norris:
> One more thing:
> 
> On Thu, Apr 28, 2016 at 09:03:53AM -0700, Brian Norris wrote:
> > Hi Heiko, Jianqun,
> > 
> > On Wed, Apr 27, 2016 at 03:54:51PM +0800, Jianqun Xu wrote:
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > b/arch/arm64/boot/dts/rockchip/rk3399.dtsi new file mode 100644
> > > index 0000000..5a8a915
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > @@ -0,0 +1,1022 @@
> > 
> > [...]
> > 
> > > +	sdhci: sdhci at fe330000 {
> > > +		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
> > 
> > Not to rain on the parade too much, as this is already applied, but is
> > the "rockchip,rk3399-sdhci-5.1" string documented anywhere? I don't see
> > it.

I don't think it is. I'm still not sure how those dangling (aka spare bindings 
for later use) should be handled.

Their use is suggested by dt maintainers, to be able to handle ip-block quirks 
later on without needing to touch the devicetree, but in this case spamming 
the arasan dt-binding document with numerous of those compatible values also 
feels wrong.

> According to the latest binding for "arasan,sdhci-5.1", the "phy" and
> "phy-names" properties are required. Fortunately, this device stays
> "disabled" for now in your EVB DTS. But just FYI.

Thanks for catching this. As the patch was still local to my repository, I've 
amended the commit and dropped the whole emmc block for now.

The emmc phy-binding just moved under the GRF (in 4.6-rc5 I think), so I guess 
we should handle that whole thing in the next version, as we're nearing (or 
are [nearly] over the armsoc cutoff already).

> > > +		reg = <0x0 0xfe330000 0x0 0x10000>;
> > > +		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > > +		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> > > +		clock-names = "clk_xin", "clk_ahb";
> > > +		status = "disabled";
> > > +	};
> 
> Brian
