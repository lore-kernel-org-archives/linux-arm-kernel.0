From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 07:44:49 -0500
Subject: [PATCH v4 2/6] iommu: of: make of_pci_map_rid() available for
 other devices too
In-Reply-To: <1525069641-8523-3-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-3-git-send-email-nipun.gupta@nxp.com>
Message-ID: <20180501124449.GA3009@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 11:57:17AM +0530, Nipun Gupta wrote:
> iommu-map property is also used by devices with fsl-mc. This
> patch moves the of_pci_map_rid to generic location, so that it
> can be used by other busses too.
> 
> 'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
> functional change done in the API.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  drivers/iommu/of_iommu.c |   5 +--
>  drivers/of/base.c        | 102 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/irq.c         |   5 +--
>  drivers/pci/of.c         | 101 ----------------------------------------------
>  include/linux/of.h       |  11 +++++
>  include/linux/of_pci.h   |  10 -----
>  6 files changed, 117 insertions(+), 117 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
