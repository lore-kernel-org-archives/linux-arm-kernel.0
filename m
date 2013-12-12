From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 11 Dec 2013 17:11:44 -0700
Subject: [PATCH 00/31] ARM: tegra: use common reset and DMA bindings
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <52A8FF40.6000809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2013 01:53 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This series implements a common reset framework driver for Tegra, and
> updates all relevant Tegra drivers to use it. It also removes the custom
> DMA bindings and replaced them with the standard DMA DT bindings.
> 
> Historically, the Tegra clock driver has exported a custom API for module
> reset. This series removes that API, and transitions DT and drivers to
> the new reset framework.
> 
> The custom API used a "struct clk" to identify which module to reset, and
> consequently some DT bindings and drivers required clocks to be provided
> where they really needed just a reset identifier instead. Due to this
> known deficiency, I have always considered most Tegra bindings to be
> unstable. This series removes this excuse for instability, although I
> still consider some Tegra bindings unstable due to the need to convert to
> the common DMA bindings.
> 
> Historically, Tegra DMA channels have been represented in DT using a
> custom nvidia,dma-request-selector property. Now that standard DMA DT
> bindings exist, convert all Tegra bindings, DTs, and drivers to use the
> standard instead.
> 
> This series makes a DT-ABI-incompatible change to:
> - Require reset specifiers in DT where relevant.
> - Require standard DMA specifiers.
> - Remove clock specifiers from DT where they were only needed for reset.
> - Remove legacy DMA specifier properties.
> 
> I anticipate merging this whole series into the Tegra and arm-soc trees
> as its own branch, due to internal dependencies. This branch will be
> stable and can then be merged into any other subsystem trees should any
> conflicts arise.
> 
> This series depends on Peter's Tegra clock driver rework, available at
> git://nv-tegra.nvidia.com/user/pdeschrijver/linux tegra-clk-tegra124-0
> (or whatever version of that gets included in 3.14)

I've applied this series (and pulled in the DMA/ASoC/clk dependencies
required) to Tegra's for-3.14/dmas-resets-rework branch.
