From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Feb 2014 11:53:49 +0100
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <5302B306.8090503@samsung.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <201402141806.12711.arnd@arndb.de> <5302B306.8090503@samsung.com>
Message-ID: <2152943.isBRrxZ7xx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 February 2014 10:10:30 Kukjin Kim wrote:
> On 02/15/14 02:06, Arnd Bergmann wrote:
> > On Thursday 13 February 2014, Olof Johansson wrote:
> >> On Mon, Feb 10, 2014 at 6:52 PM, Kukjin Kim<kgene.kim@samsung.com>  wrote:
> >>> On 02/13/14 04:14, Arnd Bergmann wrote:
> >>>> On Wednesday 12 February 2014 13:04:40 Kumar Gala wrote:
> >>> Basically, I agreed with Arnd's suggestion to use ARCH_SBSA. Or we need to
> >>> define level in Kconfig like ARCH_SBSA_L1 for level1. BTW, how about
> >>> compliant with SBSA Level1 and having some specific features?
> >
> Well, how about ARMv8 mobile SoC? I think, it is not compatible with 
> SBSA. For example, you know MCT can be used for ARMv8 cores instead of 
> ARCH Timer. So I'm not sure ARCH_SBSA is really good choice...

Sure, if you are talking about an embedded SoC that is not SBSA compliant,
we shouldn't try to make it work with ARCH_SBSA and instead give it
its own Kconfig symbol.

> > My feeling is that we don't need to use the levels for Kconfig, although
> > we might want to use them DT compatible strings, even if it ends up looking
> > a little funny when you do
> >
> > 	compatible = "arm,sbsa-l3", "arm,sbsa-l2", "arm,sbsa-l1";
> >
> >> What kind of features are you expecting though? More IP
> >> blocks/devices? Those are just kernel config options to enable,
> >> ideally as modules.
> >
> > Right, I think we can just put them into defconfig. No need to
> > "select" them from Kconfig since the extra options wouldn't be
> > required for booting or using the system.
> >
> As I commented above, how about MCT? Samsung has a plan to use MCT on 
> ARMv8, it is not for used for GH7 though...

If it's just one driver that is needed in addition to the usual stuff,
we can also just make it a standalone option and turn it on in the
generic defconfig. We won't need a per-platform option in that case.

	Arnd
