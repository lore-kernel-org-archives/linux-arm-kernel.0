From: horms@verge.net.au (Simon Horman)
Date: Tue, 12 Nov 2013 10:58:53 +0900
Subject: [PATCH 03/14] ARM: shmobile: r8a7779: add HPB-DMAC support
In-Reply-To: <5281501A.9070009@cogentembedded.com>
References: <cover.1381293239.git.horms+renesas@verge.net.au>
 <441f750236f3d3d435a1e89ad885ec896832b9c6.1381293239.git.horms+renesas@verge.net.au>
 <52814F8E.4090606@cogentembedded.com>
 <5281501A.9070009@cogentembedded.com>
Message-ID: <20131112015853.GC9863@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 12:46:02AM +0300, Sergei Shtylyov wrote:
> On 11/12/2013 12:43 AM, Sergei Shtylyov wrote:
> 
> >>From: Max Filippov <max.filippov@cogentembedded.com>
> 
> >>Add HPB-DMAC platform device on R8A7779 SoC along with its slave and channel
> >>configurations (only for SDHI0 so far).
> 
> >>Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> >>[Sergei: moved *enum* declaring HPB-DMAC slave IDs from now removed
> >><mach/dma.h>
> >>to <mach/r8a7779.h>, removed #include <mach/dma.h> from setup-r8a7779.c,
> >>removed
> >>SSI-related *enum* values and SSI-related data from hpb_dmae_slaves[] and
> >>hpb_dmae_channels[], added ASYNCMDR.ASBTMD{20|24|43} and
> >>ASYNCMDR.ASMD{20|24|43}
> >>fields/values, fixed comments to ASYNCMDR.ASBTMD2[123] and ASYNCMDR.ASMD2[123]
> >>fields/values, renamed all the bit/field/value #define's to include 'HBP_DMAE_'
> >>prefix to match the driver, moved comments after the element initializers of
> >>hpb_dmae_channels[].]
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >>---
> >>  arch/arm/mach-shmobile/include/mach/r8a7779.h |   7 ++
> >>  arch/arm/mach-shmobile/setup-r8a7779.c        | 154
> >>++++++++++++++++++++++++++
> >>  2 files changed, 161 insertions(+)
> 
> >    Hm, Simon, do you know how this patch and the next one ended up being
> >merged twice into Linus' tree?
> 
>    Sorry, I followed up to the wrong patch. So, the question was
> about this patch and the previous one.
> 
> >https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=1eb6b5a0e55bfcfb0852b7d0f9442841ff807345
> >https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=338c4991ed350abd7c5b3cb807fe022cb712a8ba
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a43e5bd76a4a3df58167d85e8020a1c9e566ad75
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=441f750236f3d3d435a1e89ad885ec896832b9c6

I assume that the reference to above git IDs implies that the answer
to your question is yes.
