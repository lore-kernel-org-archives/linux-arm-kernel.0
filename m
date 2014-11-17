From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 17 Nov 2014 14:47:07 +0100
Subject: [PATCH v7 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <1415871157-21968-6-git-send-email-thierry.reding@gmail.com>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
 <1415871157-21968-6-git-send-email-thierry.reding@gmail.com>
Message-ID: <20141117134707.GA3762@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 10:32:30AM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The memory controller on NVIDIA Tegra exposes various knobs that can be
> used to tune the behaviour of the clients attached to it.
> 
> Currently this driver sets up the latency allowance registers to the HW
> defaults. Eventually an API should be exported by this driver (via a
> custom API or a generic subsystem) to allow clients to register latency
> requirements.
> 
> This driver also registers an IOMMU (SMMU) that's implemented by the
> memory controller. It is supported on Tegra30, Tegra114 and Tegra124
> currently. Tegra20 has a GART instead.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Hi Joerg,
> 
> As I mentioned in the cover-letter, I would like to take this whole series
> through the Tegra tree to simplify dependency handling. Can I have your
> Acked-by on this patch?

Sure!

>  drivers/iommu/Kconfig                    |   12 +-
>  drivers/iommu/tegra-smmu.c               | 1601 ++++++++++--------------------
>  drivers/memory/Kconfig                   |   12 +-
>  drivers/memory/Makefile                  |    3 +-
>  drivers/memory/tegra/Kconfig             |    7 +
>  drivers/memory/tegra/Makefile            |    7 +
>  drivers/memory/tegra/mc.c                |  301 ++++++
>  drivers/memory/tegra/mc.h                |   53 +
>  drivers/memory/tegra/tegra114.c          |  948 ++++++++++++++++++
>  drivers/memory/tegra/tegra124.c          |  995 +++++++++++++++++++
>  drivers/memory/tegra/tegra30.c           |  970 ++++++++++++++++++
>  drivers/memory/tegra30-mc.c              |  377 -------
>  include/dt-bindings/memory/tegra114-mc.h |   25 +
>  include/dt-bindings/memory/tegra124-mc.h |   31 +
>  include/dt-bindings/memory/tegra30-mc.h  |   24 +
>  include/soc/tegra/mc.h                   |  107 ++
>  16 files changed, 3992 insertions(+), 1481 deletions(-)

Acked-by: Joerg Roedel <jroedel@suse.de>
