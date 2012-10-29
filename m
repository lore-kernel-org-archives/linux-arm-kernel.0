From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 29 Oct 2012 22:45:48 +0100
Subject: [PATCH 4/4] DMA: PL330: add device tree property for DMA_MEMCPY
 capability
In-Reply-To: <1351504796-24788-5-git-send-email-b.zolnierkie@samsung.com>
References: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
 <1351504796-24788-5-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <CABb+yY1Ztu2n38ObXJq+shOoXw6yk0YK39QUHhDN_pJKziAFQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 10:59 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> * Add device tree (DT) property ("pl330,dma-memcpy") for DMA_MEMCPY
>   capability and instead of setting this capability unconditionally
>   in pl330_probe() do it only when property is present.
>
Perhaps we should pass the array of peripheral interfaces via DT, the
lack of which could imply MEMCPY capability ? (while it works, I doubt
if pl330 is supposed to have SLAVE and MEMCPY capabilities in any
instance)
That would also be a step towards discarding "struct dma_pl330_platdata".
