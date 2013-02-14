From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 14 Feb 2013 14:42:50 +0100
Subject: [PATCH 1/1] ARM: dt: add header to define tegra20 clocks
In-Reply-To: <20130214101220.GI3073@tbergstrom-lnx.Nvidia.com>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org><1360823899-17846-1-git-send-email-hdoyu@nvidia.com><20130214101220.GI3073@tbergstrom-lnx.Nvidia.com>
Message-ID: <20130214.154250.475978229890081002.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver <pdeschrijver@nvidia.com> wrote @ Thu, 14 Feb 2013 11:12:20 +0100:

> On Thu, Feb 14, 2013 at 07:38:17AM +0100, Hiroshi Doyu wrote:
> > To replace magic number in "clocks = <&tegra_car 28>;"
> > 
> 
> But then we should probably also remove the enum tegra20_clk and replace it
> with this header file. We should also consider removing the list of IDs from
> the documentation and refer to the header file instead. Otherwise we will have
> 3 places which define the same IDs and we need to be sure they stay in sync...

Actually I generate "arch/arm/boot/dts/tegra{20,30}-car.h" by parsing
"enum tegra{20,30}_clk {..};" with a python script.

There could be the same kind of requirement from others that both
"dtsip" and "C-source" want to share the same header file. If we
consider that DT is the exact H/W description, C-source should be able
to include a DT header file.

For example, a C-header file for "enum tegra{20,30}_clk" should be
generated from "arch/arm/boot/dts/tegra{20,30}-car.h" at runtime, or
alternatively just "drivers/clk/tegra/clk-tegra{20,30}.c" can include
"arch/arm/boot/dts/tegra{20,30}-car.h"? The latter may be easier.
