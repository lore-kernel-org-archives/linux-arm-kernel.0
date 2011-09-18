From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 18 Sep 2011 11:28:04 +0200
Subject: [PATCH] arm/dt: Add SoC detection macros
In-Reply-To: <20110918004615.GC16141@game.jcrosoft.org>
References: <1315555339-12685-1-git-send-email-amartin@nvidia.com>
	<3353131.FJY7smc8i5@wuerfel>
	<20110918004615.GC16141@game.jcrosoft.org>
Message-ID: <7625276.j6vA9T0aOV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 September 2011 02:46:15 Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 22:56 Sat 17 Sep     , Arnd Bergmann wrote:
> > On Saturday 17 September 2011 20:19:07 Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > 
> > > I agree about it I just mean that if you have the same board with 2 SoC which
> > > are pin to pin compatible detect the soc type will be usefull as the soc
> > > resource may not be the same
> > 
> > In that scenario, you would put all SOC specific data into one .dtsi
> > file and all board data into another .dtsi file and then create a
> > description for the combination using a trivial .dts file with two
> > include statements. This is all solved outside of the kernel already,
> > so there is no need for infrastructure in the kernel.
> except in this case you must have 2 machine id which can be avoided if you can
> detect the soc at kernel level

But when you move to device tree based probing, you don't use machine numbers
at all, so it doesn't matter.

Detecting the soc in the kernel is pointless, since you describe it in
the device tree anyway. Ideally, the kernel should not need to know about
the possible SoCs at all, it just needs to know the components on it.

While we first want to get to the point where the device tree only needs
to describe the off-chip devices, in the long run it's much better to
describe all of the hardware in the device tree, as we do with new platforms
(zynq, prima2, ...) already. I don't think we need to introduce
infrastructure now when we know that we want to get rid of it later.

	Arnd
