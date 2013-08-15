From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Aug 2013 18:00:44 +0200
Subject: [PATCHv2 0/2] dma: mv_xor: big endian support
In-Reply-To: <1375112534-748-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375112534-748-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130815180044.224b14ea@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod, Dan,

I've sent the below two patches about three weeks ago, and they haven't
received any comments. They are relatively simple, so would it be
possible to queue them for 3.12 ?

Jason, Andrew, Gregory, as the Marvell EBU maintainers, it would be
great if you could give your Acked-by and/or Tested-by on those patches.

Thanks!

Thomas

On Mon, 29 Jul 2013 17:42:12 +0200, Thomas Petazzoni wrote:
> Vinod, Dan,
> 
> This small set of patches adds support for big endian operation in the
> DMA mv_xor driver. It has been tested in both little-endian and
> big-endian modes on the Armada XP GP board.
> 
> If possible, I'd like those to be merged for 3.12.
> 
> Changes since v1:
>  * Use readl_relaxed() and writel_relaxed() instead of readl/writel
>    when converting from raw_readl/raw_writel, since they preserve the
>    same barrier behavior. Suggested by Russell King.
> 
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (2):
>   mv_xor: use {readl,writel}_relaxed instead of __raw_{readl,writel}
>   mv_xor: support big endian systems using descriptor swap feature
> 
>  drivers/dma/mv_xor.c | 47 +++++++++++++++++++++++++++--------------------
>  drivers/dma/mv_xor.h | 28 +++++++++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 21 deletions(-)
> 



-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
