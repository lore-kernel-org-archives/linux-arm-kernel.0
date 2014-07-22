From: airlied@gmail.com (Dave Airlie)
Date: Tue, 22 Jul 2014 15:07:25 +1000
Subject: [PATCH RESEND] drm/ttm: expose CPU address of DMA-allocated pages
In-Reply-To: <CAAVeFuJFCQdRuuJ=WQAL65MMoWzPj03evGiXmfQh=2K7+i5Gdg@mail.gmail.com>
References: <1405390206-5081-1-git-send-email-acourbot@nvidia.com>
 <CAAVeFuJFCQdRuuJ=WQAL65MMoWzPj03evGiXmfQh=2K7+i5Gdg@mail.gmail.com>
Message-ID: <CAPM=9txDw7fJpeFB72OdSgAVuaZbpfivV-9imT9V1MBYDvBv-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2014 14:21, Alexandre Courbot <gnurou@gmail.com> wrote:
> DRM maintainers, could I have a comment about this patch? A bunch of
> Nouveau changes depend on it.

I'm not sure we really have anyone who is in a great position to comment,

my major issue would be its allocate a large chunk of RAM that might
not be needed
in all cases, and if we could avoid that when we don't need it, then
it would be good.

Or maybe we could join some allocations together, but with the Linux
mm subsystem,
who knows maybe separate small allocs have a better hope of success.

Dave.
