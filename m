From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 18 Jul 2017 21:56:03 +0530
Subject: [PATCH V3 2/2] dmaengine: dmatest: add support for memset test
In-Reply-To: <1498789858-18583-2-git-send-email-okaya@codeaurora.org>
References: <1498789858-18583-1-git-send-email-okaya@codeaurora.org>
 <1498789858-18583-2-git-send-email-okaya@codeaurora.org>
Message-ID: <20170718162602.GW3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 10:30:58PM -0400, Sinan Kaya wrote:
> Introducing memset test into dmatest. This change allows us to test
> memset capable HW using the dmatest test procedure. The new dmatest
> value for memset is 2 and it is not the default value.
> 
> Memset support patch shares the same code path as the other dmatest
> code to reuse as much as we can.
> 
> The first value inside the source buffer is used as a pattern
> to fill in the destination buffer space.
> 
> Prior to running the test, source/destination buffers are initialized
> in the current code.
> 
> "The remaining bits are the inverse of a counter which increments by
>  one for each byte address."
> 
> Memset test will fill in the upper bits of pattern with the inverse of
> fixed counter value 1 as opposed to an incrementing value in a loop.
> 
> An example run is as follows:
> 
> echo dma0chan0 > /sys/module/dmatest/parameters/channel
> echo 2 >  /sys/module/dmatest/parameters/dmatest
> echo 2000 >  /sys/module/dmatest/parameters/timeout
> echo 10 >  /sys/module/dmatest/parameters/iterations
> echo 1 >  /sys/module/dmatest/parameters/run

Applied, thanks

-- 
~Vinod
