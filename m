From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 30 Oct 2012 10:21:42 +0100
Subject: [PATCH 4/4] DMA: PL330: add device tree property for DMA_MEMCPY
 capability
In-Reply-To: <CABb+yY1Ztu2n38ObXJq+shOoXw6yk0YK39QUHhDN_pJKziAFQg@mail.gmail.com>
References: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
 <1351504796-24788-5-git-send-email-b.zolnierkie@samsung.com>
 <CABb+yY1Ztu2n38ObXJq+shOoXw6yk0YK39QUHhDN_pJKziAFQg@mail.gmail.com>
Message-ID: <201210301021.42803.b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday 29 October 2012 22:45:48 Jassi Brar wrote:
> On Mon, Oct 29, 2012 at 10:59 AM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > * Add device tree (DT) property ("pl330,dma-memcpy") for DMA_MEMCPY
> >   capability and instead of setting this capability unconditionally
> >   in pl330_probe() do it only when property is present.
> >
> Perhaps we should pass the array of peripheral interfaces via DT, the
> lack of which could imply MEMCPY capability ? (while it works, I doubt
> if pl330 is supposed to have SLAVE and MEMCPY capabilities in any
> instance)

In case of PL330 on EXYNOS4 we have two interfaces with SLAVE capability
and one interface with MEMCPY capability.  Could you please explain more
the idea of passing the array of peripherals through DT so we can detect
which interface has MEMCPY capability?

> That would also be a step towards discarding "struct dma_pl330_platdata".

I don't know if getting rid of "struct dma_pl330_platdata" is possible
but we still need to come up with some way to pass the needed information
through DT.  Do you have an idea how it could be done?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung Poland R&D Center
