From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 21 Nov 2012 09:12:57 +0100
Subject: [PATCH V3 1/3] arm: dma mapping: Export dma ops functions
In-Reply-To: <50AC8B41.7080009@free-electrons.com>
References: <1353448587-2937-1-git-send-email-gregory.clement@free-electrons.com>
 <1353448587-2937-2-git-send-email-gregory.clement@free-electrons.com>
 <50AC7D59.1020000@samsung.com> <50AC8B41.7080009@free-electrons.com>
Message-ID: <50AC8D09.6050104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 11/21/2012 9:05 AM, Gregory CLEMENT wrote:
> On 11/21/2012 08:06 AM, Marek Szyprowski wrote:
> > On 11/20/2012 10:56 PM, Gregory CLEMENT wrote:
> >> Expose the DMA operations functions. Until now only the dma_ops
> >> structs in a whole or some dma operation were exposed. This patch
> >> exposes all the dma coherents operations. They can be reused when an
> >> architecture or a driver need to create its own set of dma_operation.
> >>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >
> > Besides arm_dma_set_mask() function I see no reason to export the other
> > arm dma related functions.
>
> The idea was to let other people use the arm dma related functions,
> for their own dma ops. But for the mvebu machines we only need
> arm_dma_set_mask() indeed.
>
> So you prefer that I only expose arm_dma_set_mask() and let future
> user expose other function if they need it, right?

I would prefer to avoid exporting functions which are not used anywhere
else. This improves readability of the code and simply forces others to
think twice before they use some static function and check if their use
case is really correct.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
