From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 4 May 2012 08:40:30 +0200
Subject: [PATCHv3 1/4] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <4FA2C785.2080703@wwwdotorg.org>
References: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com><4FA2C785.2080703@wwwdotorg.org>
Message-ID: <20120504.094030.1816474762821188264.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv3 1/4] ARM: tegra: Add Tegra AHB driver
Date: Thu, 3 May 2012 19:59:33 +0200
Message-ID: <4FA2C785.2080703@wwwdotorg.org>

> On 05/03/2012 10:05 AM, Hiroshi DOYU wrote:
> > Tegra AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> > High-performance Bus (AHB) architecture.
> > 
> > The AHB Arbiter controls AHB bus master arbitration. This effectively
> > forms a second level of arbitration for access to the memory
> > controller through the AHB Slave Memory device. The AHB pre-fetch
> > logic can be configured to enhance performance for devices doing
> > sequential access. Each AHB master is assigned to either the high or
> > low priority bin. Both Tegra20/30 have this AHB bus.
> > 
> > Some of configuration param could be passed from DT too.
> 
> This patch should add
> Documentation/devicetree/bindings/arm/tegra/tegra20-ahb.txt to describe
> the DT binding.

>From 'dts' POV, there's no difference between tegra20 and
tegra30. They just have a register range. Is
"../bindings/arm/tegra/tegra-ahb.txt" ok, instead of having both
tegra{20,30}-ahb.txt?
