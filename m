From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 17:52:59 +0200
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <20151015104045.04136253@xhacker>
References: <20151015101920.7fa592f7@canb.auug.org.au>
 <20151015104045.04136253@xhacker>
Message-ID: <8514405.TqbzRgirza@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 10:40:45 Jisheng Zhang wrote:
> On Thu, 15 Oct 2015 10:19:20 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > After merging the arm-soc tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> > 
> > arch/arm/boot/dts/berlin2q.dtsi:62.24-25 syntax error
> > FATAL ERROR: Unable to parse input tree
> 
> I just checked, this is caused by missing the following two commits
> 
> f72d787d9287 ("clk: berlin: move MAX_CLKS out of drivers/clk/berlin")
> 
> 44b2e5f96d5e ("clk: berlin: add cpuclk")

I've reverted 23998645f6e73 ("ARM: berlin: dts: add the cpufreq-dt
bindings on the BG2Q") on my for-next branch for the time being, to
get a working tree again and am waiting for a proper fixup patch
from Sebastian now to rectify the next/dt branch.

	Arnd
