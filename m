From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Apr 2012 20:56:45 +0100
Subject: [PATCH v2 1/3] ARM: tegra: Add AHB driver
In-Reply-To: <1335269116-9578-1-git-send-email-hdoyu@nvidia.com>
References: <1335269116-9578-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <20120424195645.GB3628@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 03:05:14PM +0300, Hiroshi DOYU wrote:
> The AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> High-performance Bus (AHB) architecture.
> 
> The AHB Arbiter controls AHB bus master arbitration. This effectively
> forms a second level of arbitration for access to the memory
> controller through the AHB Slave Memory device. The AHB pre-fetch
> logic can be configured to enhance performance for devices doing
> sequential access. Each AHB master is assigned to either the high or
> low priority bin. Both Tegra20/30 have this AHB bus.
> 
> Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> Update:
> - Use platform_device to get info from dt dynamically.(Felipe/Arnd)
> ---
>  arch/arm/mach-tegra/Makefile    |    1 +
>  arch/arm/mach-tegra/tegra-ahb.c |  285 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 286 insertions(+), 0 deletions(-)

1. I thought we weren't going to have any more drivers under arch/arm
2. From the way you describe it above, this sounds like it should be some
   kind of generic driver, which obtains the necessary settings to be
   programmed into registers from (eg) DT.
