From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 12:45:14 +0200
Subject: [PATCH 04/23] ARM: dt: tegra30: Register AHB/IOMMU device first
In-Reply-To: <1372238906-9346-5-git-send-email-hdoyu@nvidia.com>
References: <1372238906-9346-5-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130626104514.GJ27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:28:07PM +0300, Hiroshi Doyu wrote:
> Move up AHB/IOMMU to register them earlier than others. IOMMU needs
> AHB, and IOMMU needs to register all platform devices as
> IOMMU'able. So AHB/IOMMU needs to be instanciated at very beginning.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra30.dtsi | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)

This just happens to work because DTC keeps the order from the DTS in
the DTB and the Linux implementation sequentially instantiates devices
from DT nodes. Neither should be assumed though when writing DTS files.
Other implementations (DTC or OS) could do things differently.

But if I understand correctly there is another solution which should
solve this issue properly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/93649077/attachment-0001.sig>
