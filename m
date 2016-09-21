From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 21 Sep 2016 10:34:34 +0300
Subject: [PATCH 5/9] dmaengine/ARM: omap-dma: Fix the DMAengine compile
 test on non OMAP configs
In-Reply-To: <20160921035326.GF2609@localhost>
References: <20160916083324.29133-1-peter.ujfalusi@ti.com>
 <20160916083324.29133-6-peter.ujfalusi@ti.com>
 <20160921035131.GD2609@localhost> <20160921035326.GF2609@localhost>
Message-ID: <498a255b-27a7-20fe-9736-ede2b5bdebe6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/16 06:53, Vinod Koul wrote:
> On Wed, Sep 21, 2016 at 09:21:32AM +0530, Vinod Koul wrote:
>> On Fri, Sep 16, 2016 at 11:33:20AM +0300, Peter Ujfalusi wrote:
>>> The DMAengine driver for omap-dma use three function calls from the
>>> plat-omap legacy driver. When the DMAengine driver is built when ARCH_OMAP
>>> is not set, the compilation will fail due to missing symbols.
>>> Add empty inline functions to allow the DMAengine driver to be compiled
>>> with COMPILE_TEST.
>>
>> Peter,
>>
>> This should be before you enable COMPILE_TEST otherwise build will break!
> 
> Ah never mind, you have three drivers in this series so I think this is fine
> before the omap one :)

Yep, patch 1-4 is for eDMA, patch 5-6 is for omap-dma and the remaining is for
ti-dma-crossbar.

I wanted to have them separate (including when I enable the COMPILE_TEST) so
we can revert easily if needed.

If I move the 'enable COMPILE_TEST' patches at the end of the series, I think
I will still have them as separate as they are enabling the test for three
different driver.

-- 
P?ter
