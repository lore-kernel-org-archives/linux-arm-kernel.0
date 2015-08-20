From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 20 Aug 2015 12:40:28 +0530
Subject: [PATCH v1 3/4] Crypto: Add support for APM X-Gene SoC CRC32C h/w
 accelerator driver
In-Reply-To: <CAFd313xG2_4NGHspuJwThY=jUSPiBm3egvXVvhv8XxKctgMv1A@mail.gmail.com>
References: <1438258268-3099-1-git-send-email-rsahu@apm.com>
 <1438258268-3099-4-git-send-email-rsahu@apm.com>
 <20150820054828.GY13546@localhost>
 <CAFd313xG2_4NGHspuJwThY=jUSPiBm3egvXVvhv8XxKctgMv1A@mail.gmail.com>
Message-ID: <20150820071028.GH13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 12:31:44PM +0530, Rameshwar Sahu wrote:
> Hi Vinod,
> 
> On Thu, Aug 20, 2015 at 11:18 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Thu, Jul 30, 2015 at 05:41:07PM +0530, Rameshwar Prasad Sahu wrote:
> >> +     nents = sg_nents(req->src);
> >> +     sg_count = dma_map_sg(dev, req->src, nents, DMA_TO_DEVICE);
> >> +     if (!sg_count) {
> >> +             dev_err(dev, "Failed to map src sg");
> >> +             return -ENOMEM;
> > mapping error shouldn't be no mem error
> Okay, I guess then -EIO will be fine here??

yes better

-- 
~Vinod
