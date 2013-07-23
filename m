From: olof@lixom.net (Olof Johansson)
Date: Mon, 22 Jul 2013 19:41:12 -0700
Subject: [PATCH fix for v3.11 (repost)] dmaengine: shdma: fix a build
 failure on platforms with no DMA support
In-Reply-To: <20130717235058.GA10683@verge.net.au>
References: <20130717235058.GA10683@verge.net.au>
Message-ID: <20130723024112.GA15637@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 08:50:58AM +0900, Simon Horman wrote:
> From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> On platforms with no support for the shdma dmaengine driver build is
> currently failing with
> 
> drivers/built-in.o: In function `sh_mobile_sdhi_probe':
> drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to`shdma_chan_filter'
> 
> Fix the breakage by defining shdma_chan_filter to NULL in such
> configurations.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> [horms+renesas at verge.net.au: Apply change to shdma-base.h instead of sh_dma.h]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  include/linux/shdma-base.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> Hi Vinod,
> 
> please consider this fix from Guennadi for v3.11 which I have rebased on top of
> next-20130709. It fixes a build problem on a number of shmobile defconfigs
> including bockw.
> 
> Alternatively, I would be happy to take this through the renesas tree.
> 
> I posted this patch last week but I'm wondering if you missed it somehow.
> This patch resolves a regression in v3.11-rc1.

As mentioned on the other thread, I have applied this in the arm-soc fixes
branch for 3.11 now.


-Olof
