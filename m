From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Oct 2017 13:39:45 +0200
Subject: [PATCH v2 5/6] gpu: host1x: Add Tegra186 support
In-Reply-To: <20170905084306.19318-6-mperttunen@nvidia.com>
References: <20170905084306.19318-1-mperttunen@nvidia.com>
 <20170905084306.19318-6-mperttunen@nvidia.com>
Message-ID: <20171019113945.GP9005@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 05, 2017 at 11:43:05AM +0300, Mikko Perttunen wrote:
> Add support for the implementation of Host1x present on the Tegra186.
> The register space has been shuffled around a little bit, requiring
> addition of some chip-specific code sections. Tegra186 also adds
> several new features, most importantly the hypervisor, but those are
> not yet supported with this commit.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/host1x/Makefile                    |   3 +-
>  drivers/gpu/host1x/dev.c                       |  60 +++++++-
>  drivers/gpu/host1x/dev.h                       |   4 +
>  drivers/gpu/host1x/hw/cdma_hw.c                |  49 ++++---
>  drivers/gpu/host1x/hw/debug_hw.c               | 137 +------------------
>  drivers/gpu/host1x/hw/debug_hw_1x01.c          | 154 +++++++++++++++++++++
>  drivers/gpu/host1x/hw/debug_hw_1x06.c          | 133 ++++++++++++++++++
>  drivers/gpu/host1x/hw/host1x01.c               |   2 +
>  drivers/gpu/host1x/hw/host1x02.c               |   2 +
>  drivers/gpu/host1x/hw/host1x04.c               |   2 +
>  drivers/gpu/host1x/hw/host1x05.c               |   2 +
>  drivers/gpu/host1x/hw/host1x06.c               |  44 ++++++
>  drivers/gpu/host1x/hw/host1x06.h               |  26 ++++
>  drivers/gpu/host1x/hw/host1x06_hardware.h      | 142 +++++++++++++++++++
>  drivers/gpu/host1x/hw/hw_host1x06_hypervisor.h |  32 +++++
>  drivers/gpu/host1x/hw/hw_host1x06_uclass.h     | 181 +++++++++++++++++++++++++
>  drivers/gpu/host1x/hw/hw_host1x06_vm.h         |  47 +++++++
>  drivers/gpu/host1x/hw/intr_hw.c                |  29 ++--
>  18 files changed, 880 insertions(+), 169 deletions(-)
>  create mode 100644 drivers/gpu/host1x/hw/debug_hw_1x01.c
>  create mode 100644 drivers/gpu/host1x/hw/debug_hw_1x06.c
>  create mode 100644 drivers/gpu/host1x/hw/host1x06.c
>  create mode 100644 drivers/gpu/host1x/hw/host1x06.h
>  create mode 100644 drivers/gpu/host1x/hw/host1x06_hardware.h
>  create mode 100644 drivers/gpu/host1x/hw/hw_host1x06_hypervisor.h
>  create mode 100644 drivers/gpu/host1x/hw/hw_host1x06_uclass.h
>  create mode 100644 drivers/gpu/host1x/hw/hw_host1x06_vm.h

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171019/98939d90/attachment.sig>
