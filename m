From: sam.van.den.berge@telenet.be (Sam Van Den Berge)
Date: Thu, 22 Sep 2016 20:48:51 +0200
Subject: [PATCH v2] dmaengine: s3c24xx: Add dma_slave_map for s3c2440
 devices
In-Reply-To: <b32bfb03-e0d1-09b4-95fc-5a6301a9bde5@kernel.org>
References: <CGME20160915194201eucas1p2961ce91633437ed68c5f61877a3f47c3@eucas1p2.samsung.com>
 <1473968506-4150-1-git-send-email-sam.van.den.berge@telenet.be>
 <b32bfb03-e0d1-09b4-95fc-5a6301a9bde5@kernel.org>
Message-ID: <20160922184850.GA7132@sam-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 01:16:31PM +0200, Krzysztof Kozlowski wrote:
> On 09/15/2016 09:41 PM, Sam Van Den Berge wrote:
> > This patch updates the s3c24xx dma driver to be able to pass a
> > dma_slave_map array via the platform data. This is needed to
> > be able to use the new, simpler dmaengine API [1].
> > I used the virtual DMA channels as a parameter for the dma_filter
> > function. By doing that, I could reuse the existing filter function in
> > drivers/dma/s3c24xx-dma.c.
> > 
> > I have tested this on my mini2440 board with the audio driver.
> > (I first applied the audio fixes from Sylwester Nawrocki [2])
> > According to my observations, dma_request_slave_channel in the
> > function dmaengine_pcm_new in the file
> > sound/soc/soc-generic-dmaengine-pcm.c now returns a valid DMA channel
> > whereas before no DMA channel was returned at that point.
> > 
> > Entries for DMACH_XD0, DMACH_XD1 and DMACH_TIMER are missing because I
> > don't realy know which driver to use for these.
> > 
> > [1]
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393635.html
> > [2] http://www.spinics.net/lists/arm-kernel/msg521918.html
> > 
> > Signed-off-by: Sam Van Den Berge <sam.van.den.berge@telenet.be>
> > Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > ---
> > 
> > Changes since v1:
> > - rename arm into dmaengine in title
> > - one channel for s3c2440-sdi named "rx-tx"
> > 
> >  arch/arm/mach-s3c24xx/common.c            | 35 +++++++++++++++++++++++++++++++
> >  drivers/dma/s3c24xx-dma.c                 |  3 +++
> >  include/linux/platform_data/dma-s3c24xx.h |  6 ++++++
> >  3 files changed, 44 insertions(+)
> 
> Vinod, do you want to take it through your tree? Not much difference for
> me, so in such case:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

I was kinda waiting for an answer on this question because I didn't know
if I should add the acked-by or not but I'm going to assume that it's ok
so I'll include it in the third version of this patch.

> 
> Best regards,
> Krzysztof
> 
> 
