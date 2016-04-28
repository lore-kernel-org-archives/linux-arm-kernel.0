From: briannorris@chromium.org (Brian Norris)
Date: Thu, 28 Apr 2016 15:28:19 -0700
Subject: [PATCH v4 2/4] ARM64: dts: rockchip: add core dtsi file for
 RK3399 SoCs
In-Reply-To: <2138015.GmMsjTUH7U@diego>
References: <1461743693-10671-1-git-send-email-jay.xu@rock-chips.com>
 <20160428160353.GA95284@google.com>
 <20160428182938.GA3079@google.com> <2138015.GmMsjTUH7U@diego>
Message-ID: <20160428222819.GA98045@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 10:33:07PM +0200, Heiko Stuebner wrote:
> Am Donnerstag, 28. April 2016, 11:29:38 schrieb Brian Norris:
> > On Thu, Apr 28, 2016 at 09:03:53AM -0700, Brian Norris wrote:
> > > On Wed, Apr 27, 2016 at 03:54:51PM +0800, Jianqun Xu wrote:
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > > b/arch/arm64/boot/dts/rockchip/rk3399.dtsi new file mode 100644
> > > > index 0000000..5a8a915
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > > @@ -0,0 +1,1022 @@
> > > 
> > > [...]
> > > 
> > > > +	sdhci: sdhci at fe330000 {
> > > > +		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
> > > 
> > > Not to rain on the parade too much, as this is already applied, but is
> > > the "rockchip,rk3399-sdhci-5.1" string documented anywhere? I don't see
> > > it.
> 
> I don't think it is. I'm still not sure how those dangling (aka spare bindings 
> for later use) should be handled.
> 
> Their use is suggested by dt maintainers, to be able to handle ip-block quirks 
> later on without needing to touch the devicetree, but in this case spamming 
> the arasan dt-binding document with numerous of those compatible values also 
> feels wrong.

Hmm, good point. I was mostly tipped off by checkpatch when applying
locally, and I also didn't have any context for whether there were any
known quirks for rk3399 vs. the "standard" core. Given your comments, I
suppose it's fair to use without documenting it (do I get burned at the
stake for saying that?).

> > According to the latest binding for "arasan,sdhci-5.1", the "phy" and
> > "phy-names" properties are required. Fortunately, this device stays
> > "disabled" for now in your EVB DTS. But just FYI.
> 
> Thanks for catching this. As the patch was still local to my repository, I've 
> amended the commit and dropped the whole emmc block for now.

No problem.

> The emmc phy-binding just moved under the GRF (in 4.6-rc5 I think), so I guess 
> we should handle that whole thing in the next version, as we're nearing (or 
> are [nearly] over the armsoc cutoff already).

Sounds good. I'm already tracking/testing that modification.

Brian
