From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 17 Sep 2012 10:16:53 +0300
Subject: [PATCH v2 04/15] dmaengine: Pass no_wakeup parameter via
 device_prep_dma_cyclic() callback
In-Reply-To: <20120917063451.GB6413@S2101-09.ap.freescale.net>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
 <20120917063451.GB6413@S2101-09.ap.freescale.net>
Message-ID: <5056CE65.9080401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2012 09:34 AM, Shawn Guo wrote:
> On Thu, Sep 13, 2012 at 04:37:54PM +0300, Peter Ujfalusi wrote:
>> Change the parameter list of device_prep_dma_cyclic() so the DMA drivers
>> can receive the no_wakeup request coming from client drivers.
>> This feature can be used during audio operation to disable all audio
>> related interrupts.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
>> CC: Barry Song <baohua.song@csr.com>
>> CC: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
>> CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
>> CC: Vista Silicon <javier.martin@vista-silicon.com>
>> CC: Zhangfei Gao <zhangfei.gao@marvell.com>
>> CC: Shawn Guo <shawn.guo@linaro.org>
>> CC: Laxman Dewangan <ldewangan@nvidia.com>
>> ---
>>  drivers/dma/at_hdmac.c        | 3 ++-
>>  drivers/dma/ep93xx_dma.c      | 4 +++-
>>  drivers/dma/imx-dma.c         | 2 +-
>>  drivers/dma/imx-sdma.c        | 2 +-
>>  drivers/dma/mmp_tdma.c        | 2 +-
>>  drivers/dma/mxs-dma.c         | 2 +-
>>  drivers/dma/omap-dma.c        | 3 ++-
>>  drivers/dma/pl330.c           | 2 +-
>>  drivers/dma/sa11x0-dma.c      | 2 +-
>>  drivers/dma/sirf-dma.c        | 2 +-
>>  drivers/dma/ste_dma40.c       | 3 ++-
>>  drivers/dma/tegra20-apb-dma.c | 2 +-
>>  include/linux/dmaengine.h     | 5 +++--
>>  13 files changed, 20 insertions(+), 14 deletions(-)
>>
> API changes without updating users?

All users of this callback is updated with this patch.
The public API (dmaengine_prep_dma_cyclic) is only used by ASoC, which has
been updated by the previous patch.
Note: this part has been updated for v3.

-- 
P?ter
