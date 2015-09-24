From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 24 Sep 2015 12:56:47 +0300
Subject: [PATCH v3 10/24] ARM: davinci: Add set dma_mask to eDMA devices
In-Reply-To: <20150923172518.GH23801@atomide.com>
References: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
 <1442915675-7121-11-git-send-email-peter.ujfalusi@ti.com>
 <20150923172518.GH23801@atomide.com>
Message-ID: <5603C8DF.7000505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2015 08:25 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [150922 03:01]:
>> The upcoming change to merge the arch/arm/common/edma.c into
>> drivers/dma/edma.c will need this change when booting daVinci devices in
>> no DT mode.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  arch/arm/Kconfig                      |    1 -
>>  arch/arm/common/Kconfig               |    3 -
>>  arch/arm/common/Makefile              |    1 -
>>  arch/arm/common/edma.c                | 1431 --------------------------------
>>  arch/arm/mach-davinci/devices-da8xx.c |    2 +
>>  arch/arm/mach-davinci/dm355.c         |    1 +
>>  arch/arm/mach-davinci/dm644x.c        |    1 +
>>  arch/arm/mach-davinci/dm646x.c        |    1 +
>>  arch/arm/mach-omap2/Kconfig           |    1 -
>>  drivers/dma/Kconfig                   |    1 -
>>  drivers/dma/edma.c                    | 1447 +++++++++++++++++++++++++++++++--
>>  include/linux/platform_data/edma.h    |   74 --
>>  12 files changed, 1394 insertions(+), 1570 deletions(-)
>>  delete mode 100644 arch/arm/common/edma.c
> 
> Hmm I think I already acked the mach-omap2/Kconfig change,
> but if not, here you are:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Yes, sorry that I have failed to add it.
But for some reason two patch got squashed here which I don't really
understand since between v2-v3 I have not touched these commits.
This patch actually was:
[PATCH v2 10/23] ARM: davinci: Add set dma_mask to eDMA devices
[PATCH v2 11/23] ARM/dmaengine: edma: Merge the two drivers under
drivers/dmaengine

I'm going to send v4 in couple of minutes

-- 
P?ter
