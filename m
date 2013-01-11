From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 10 Jan 2013 17:15:07 -0700
Subject: [PATCH 09/14] ARM: tegra: Move pmc.h to include/mach
In-Reply-To: <1357764194-12677-10-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-10-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <50EF598B.2030307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 01:43 PM, Thierry Reding wrote:
> In preparation for moving the PCIe driver into the drivers/pci/host
> directory, this header, which contains prototypes that are required by
> the PCIe driver, needs to be moved to a globally visible location.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Note that eventually the code in pmc.c and powergate.c should probably
> be split out into a separate driver. The PMC registers are also directly
> accessed from tegra20_clocks.c and tegra30_clocks.c, so that it might be
> required to provide that functionality through the new driver as well.
> ---
>  arch/arm/mach-tegra/common.c           |  2 +-
>  arch/arm/mach-tegra/include/mach/pmc.h | 24 ++++++++++++++++++++++++
>  arch/arm/mach-tegra/pmc.h              | 24 ------------------------

On IRC, we'd talked about putting the public functionality in
include/linux/tegra-pmc.h so that we wouldn't add to include/mach, which
would make it harder to make Tegra support ARM multi-platform. Perhaps
that IRC discussion happened after you posted this series?
