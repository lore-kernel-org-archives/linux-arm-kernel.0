From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Dec 2014 15:35:35 +0100
Subject: [PATCH v2 0/4] Add basic support for Mediatek MT8173 SoC
In-Reply-To: <1418825853-10934-1-git-send-email-eddie.huang@mediatek.com>
References: <1418825853-10934-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1808813.15ih7rDt4r@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 December 2014 22:17:29 Eddie Huang wrote:
> MT8173 is a SoC based on 64bit ARMv8 architecture. It contains 2 CA53 + 2 CA57 cores. MT8173 share many HW IP with MT8135 and other MT65xx series. This patchset was tested on MT8173 engineer sample, and boot to shell ok.
> 
> This series contains document bindings, device tree, defconfig, and one sysirq modification for MT8173.
> 
> Changes in v2:
> 
> 1. Modify mt8173.dtsi and mt8173-evb.dts according to Mark Rutland's comment, change cpu-maps, psci, clock, GIC properties.
> 2. Modify irq-mtk-sysirq.c according to Arnd Bergmann's comment to calculate irq number from reg range.
> 
> 

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

In the 3.19 merge window, we had a few problems with new arm64 platforms,
as it wasn't entirely clear to us who is a maintainer and whether patches
were sent for review or inclusion. I see no problem including your series
in 3.20, but we probably need to figure out the best process for making
sure we don't miss it.

For now, I'd suggest we do this the same way as the arm32 patches, and
you send them to Matthias for inclusion in his tree, who will then
send a pull request for an arm64 branch.

	Arnd
