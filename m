From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 23 Jan 2015 15:51:53 +0900
Subject: [PATCH 1/2] clk: exynos5420: Add IDs for clocks used in DISP1
 power domain
In-Reply-To: <54BF81C2.3020000@collabora.co.uk>
References: <1421750127-22536-1-git-send-email-javier.martinez@collabora.co.uk>
 <1421750127-22536-2-git-send-email-javier.martinez@collabora.co.uk>
 <54BE6050.1090205@samsung.com> <20150120175402.22722.84342@quantum>
 <54BF81C2.3020000@collabora.co.uk>
Message-ID: <0c2601d036d9$1276e7d0$3764b770$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> 
> Hello,
> 
Hi,

> On 01/20/2015 06:54 PM, Mike Turquette wrote:
> > Quoting Sylwester Nawrocki (2015-01-20 06:04:00)
> >> Hi,
> >>
> >> On 20/01/15 11:35, Javier Martinez Canillas wrote:
> >> > When a power domain is powered off on Exynos5420 SoC, the input clocks of
> >> > the devices attached to this power domain are re-parented to oscclk and
> >> > restored to the original parent after powering on the power domain.
> >> >
> >> > So a reference to the input and parent clocks for the devices attached to
> >> > a power domain are needed to be able to do the re-parenting. The DISP1 pd
> >> > includes modules which uses the following clocks:
> >> >
> >> > ACLK_200_DISP1 (MIXER and HDMILINK)
> >> > ACLK_300_DISP1 (FIMD1)
> >> > ACLK_400_DISP1 (Internal Buses)
> >> >
> >> > Each of these clocks are generated as the output of a clock mux so add an
> >> > ID for all of these clock muxes and their parents to be referenced in the
> >> > DISP1 power domain device node.
> >> >
> >> > Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> >>
> >> The patch looks OK to me, I'm fine with it being merged via Kukjin's tree
> >> due to the dts dependencies (including other pending dts patches touching
> >> the arch/arm/boot/dts/exynos5420.dtsi file).
> >> I think we need also Mike ACK for that, I could also queue the patch for
> >> the clk tree and create a topic branch, but merging both patches via
> >> arm-soc seems a more sane option in this case.
> >>
> >> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >
> > Acked-by: Michael Turquette <mturquette@linaro.org>
> >
> 
> Thanks a lot Sylwester and Mike for your acks.
> 
> Kukjin, could you please pick $subject and "Patch 2/2 ARM: dts: Add DISP1
> power domain for exynos5420" through your tree?
> 
Sure, I will after applying Marek's generic power domain patch.

Thanks,
Kukjin
