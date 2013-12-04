From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 10:45:54 +0100
Subject: [PATCH V3] dma: tegra: register as an OF DMA controller
In-Reply-To: <1386102787-21839-1-git-send-email-swarren@wwwdotorg.org>
References: <1386102787-21839-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131204094554.GQ19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 01:33:07PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Call of_dma_controller_register() so that DMA clients can look up the
> Tegra DMA controller using standard APIs. This requires the of_xlate()
> function to save off the DMA slave ID, and for tegra_dma_slave_config()
> not to over-write this information; once DMA client drivers are converted
> to dma_request_slave_channel() and DT-based lookups, they won't set this
> field of struct dma_slave_config anymore.
> 
> Cc: treding at nvidia.com
> Cc: pdeschrijver at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: dmaengine at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v3: Rework of_xlate() to use new dma_get_any_slave_channel().
> 
> v2: Use of_dma_slave_xlate() rather than of_dma_simple_xlate(), as
>     suggested by Arnd Bergmann.
> 
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
> ---
>  drivers/dma/tegra20-apb-dma.c | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/aa46848f/attachment.sig>
