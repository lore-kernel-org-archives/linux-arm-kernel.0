From: acourbot@nvidia.com (Alexandre Courbot)
Date: Mon, 11 Apr 2016 16:55:38 +0900
Subject: Nouveau crashes in 4.6-rc on arm64
In-Reply-To: <570B50B4.4020304@nvidia.com>
References: <57064992.1060509@arm.com> <570737F5.30105@nvidia.com>
 <5707FC9F.50905@arm.com> <570B50B4.4020304@nvidia.com>
Message-ID: <570B587A.5090509@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 04:22 PM, Alexandre Courbot wrote:
> ... or maybe we could just unconditionally sync all buffers and let the
> DMA API abstract this away. My concern is that on coherent architectures
> we would still need to loop over all the pages for nothing, as I don't
> think the loop (see e.g. nouveau_bo_sync_for_cpu in nouveau_bo.c) can be
> optimized away by the compiler.

Looking at the code it actually turns out we are already calling the 
sync functions on coherent buses anyway, so maybe we have little reasons 
to keep this at all?
