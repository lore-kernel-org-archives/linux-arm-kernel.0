From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 27 Oct 2014 13:13:05 +0100
Subject: [PATCH v2 0/4] Low/high memory CMA reservation fixes
In-Reply-To: <1414145922-26042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1414145922-26042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <544E36D1.3090609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-10-24 12:18, Laurent Pinchart wrote:
> Hello,
>
> This patch set fixes an issue introduced by commits 95b0e655f914 ("ARM: mm:
> don't limit default CMA region only to low memory") and f7426b983a6a ("mm:
> cma: adjust address limit to avoid hitting low/high memory boundary")
> resulting in reserved areas crossing the low/high memory boundary.
>
> Patches 1/4 and 2/4 fix sides issues, with the bulk of the work in patch 3/4.
> Patch 4/4 then fixes a printk issue that got me puzzled wondering why memory
> reported under the lowmem limit was actually highmem.
>
> This series fixes a v3.18-rc1 regression causing Renesas Koelsch boot
> breakages when CMA is enabled.

I've applied the whole series to my fixes-for-v3.18 branch.

> Changes since v1:
>
> - Use the cma count field to detect non-activated reservations
> - Remove the redundant limit adjustment
>
> Laurent Pinchart (4):
>    mm: cma: Don't crash on allocation if CMA area can't be activated
>    mm: cma: Always consider a 0 base address reservation as dynamic
>    mm: cma: Ensure that reservations never cross the low/high mem
>      boundary
>    mm: cma: Use %pa to print physical addresses
>
>   mm/cma.c | 68 +++++++++++++++++++++++++++++++++++++++++-----------------------
>   1 file changed, 44 insertions(+), 24 deletions(-)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
