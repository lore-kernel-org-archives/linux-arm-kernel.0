From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 4 Apr 2017 16:01:03 +0200
Subject: [PATCH V3 2/6] soc/tegra: Move Tegra flowctrl driver
In-Reply-To: <1490704978-22906-3-git-send-email-jonathanh@nvidia.com>
References: <1490704978-22906-1-git-send-email-jonathanh@nvidia.com>
 <1490704978-22906-3-git-send-email-jonathanh@nvidia.com>
Message-ID: <20170404140103.GE843@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 01:42:54PM +0100, Jon Hunter wrote:
> The flowctrl driver is required for both ARM and ARM64 Tegra devices
> and in order to enable support for it for ARM64, move the Tegra flowctrl
> driver into drivers/soc/tegra.
> 
> By moving the flowctrl driver, tegra_flowctrl_init() is now called by
> via an early initcall and to prevent this function from attempting to
> mapping IO space for a non-Tegra device, a test for 'soc_is_tegra()'
> is also added.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/mach-tegra/Makefile          |   1 -
>  arch/arm/mach-tegra/cpuidle-tegra20.c |   3 +-
>  arch/arm/mach-tegra/flowctrl.c        | 179 --------------------------------
>  arch/arm/mach-tegra/flowctrl.h        |  66 ------------
>  arch/arm/mach-tegra/platsmp.c         |   2 +-
>  arch/arm/mach-tegra/pm.c              |   2 +-
>  arch/arm/mach-tegra/reset-handler.S   |   2 +-
>  arch/arm/mach-tegra/sleep-tegra20.S   |   3 +-
>  arch/arm/mach-tegra/sleep-tegra30.S   |   2 +-
>  arch/arm/mach-tegra/tegra.c           |   2 -
>  drivers/soc/tegra/Kconfig             |   7 ++
>  drivers/soc/tegra/Makefile            |   1 +
>  drivers/soc/tegra/flowctrl.c          | 187 ++++++++++++++++++++++++++++++++++
>  include/soc/tegra/flowctrl.h          |  82 +++++++++++++++
>  14 files changed, 285 insertions(+), 254 deletions(-)
>  delete mode 100644 arch/arm/mach-tegra/flowctrl.c
>  delete mode 100644 arch/arm/mach-tegra/flowctrl.h
>  create mode 100644 drivers/soc/tegra/flowctrl.c
>  create mode 100644 include/soc/tegra/flowctrl.h

Applied to for-4.12/soc, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/53dd5447/attachment.sig>
