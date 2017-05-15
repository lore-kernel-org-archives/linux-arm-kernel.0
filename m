From: robh@kernel.org (Rob Herring)
Date: Mon, 15 May 2017 15:48:56 -0500
Subject: [PATCH v3 1/3] dt-bindings: mt8173: Fix mdp device tree
In-Reply-To: <1494559361-42835-2-git-send-email-minghsiu.tsai@mediatek.com>
References: <1494559361-42835-1-git-send-email-minghsiu.tsai@mediatek.com>
 <1494559361-42835-2-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <20170515204856.p7zwsfwear5b6nyx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 11:22:39AM +0800, Minghsiu Tsai wrote:
> If the mdp_* nodes are under an mdp sub-node, their corresponding
> platform device does not automatically get its iommu assigned properly.
> 
> Fix this by moving the mdp component nodes up a level such that they are
> siblings of mdp and all other SoC subsystems.  This also simplifies the
> device tree.
> 
> Although it fixes iommu assignment issue, it also break compatibility
> with old device tree. So, the patch in driver is needed to iterate over
> sibling mdp device nodes, not child ones, to keep driver work properly.
> 
> Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> 
> ---
>  Documentation/devicetree/bindings/media/mediatek-mdp.txt | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
