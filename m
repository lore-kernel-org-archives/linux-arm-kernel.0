From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 12:15:37 -0500
Subject: [PATCH 2/6 v3] iommu: of: make of_pci_map_rid() available for
 other devices too
In-Reply-To: <1524824826-29473-3-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-3-git-send-email-nipun.gupta@nxp.com>
Message-ID: <20180427171537.lvzygghnuolk6cnh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 03:57:02PM +0530, Nipun Gupta wrote:
> iommu-map property is also used by devices with fsl-mc. This
> patch moves the of_pci_map_rid to generic location, so that it
> can be used by other busses too.
> 
> 'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
> functional change done in the API.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  drivers/iommu/of_iommu.c   |   6 +--
>  drivers/of/address.c       | 102 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/irq.c           |   7 ++--
>  drivers/pci/of.c           | 101 --------------------------------------------
>  include/linux/of_address.h |  11 +++++
>  include/linux/of_pci.h     |  10 -----
>  6 files changed, 120 insertions(+), 117 deletions(-)

of/address.c isn't really the best fit either, though I don't have a 
better suggestion. 

I'm guessing this breaks on Sparc which doesn't build of/address.c. 
I guess move it to base.c and of.h if that is the case.

Rob
