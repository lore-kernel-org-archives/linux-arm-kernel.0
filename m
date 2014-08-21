From: drake@endlessm.com (Daniel Drake)
Date: Thu, 21 Aug 2014 10:26:30 +0100
Subject: [PATCH 2/2] ARM: mm: don't limit default CMA region only to low
 memory
In-Reply-To: <1408610714-16204-3-git-send-email-m.szyprowski@samsung.com>
References: <1408610714-16204-1-git-send-email-m.szyprowski@samsung.com>
 <1408610714-16204-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAD8Lp44MHLv_C0SscRAxq_09Ux+Uz=9B3KvDKvUkamBenoSm=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Thu, Aug 21, 2014 at 9:45 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> DMA-mapping supports CMA regions places either in low or high memory, so
> there is no longer needed to limit default CMA regions only to low memory.
> The real limit is still defined by architecture specific DMA limit.

Thanks for working on this!

I think you need to update the comment here though, which still says:
    /*
     * reserve memory for DMA contigouos allocations,
     * must come from DMA area inside low memory
     */

If you're making a second version, as a minor nitpick you could also
s/places/placed in the commit message.

Daniel
