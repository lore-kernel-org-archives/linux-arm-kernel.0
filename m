From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 14 Sep 2011 12:00:03 +0530
Subject: [PATCH v8 00/16] To use DMA generic APIs for Samsung DMA
In-Reply-To: <1315980099.26251.498.camel@vkoul-udesk3>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
	<1315980099.26251.498.camel@vkoul-udesk3>
Message-ID: <CABb+yY25NTbtRPOw-KH8U4zA1Bo8q0BDM8SXyrsobG7NEv8edg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 11:31 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Fri, 2011-09-02 at 09:44 +0900, Boojin Kim wrote:
>> This patchset adds support DMA generic APIs for samsung DMA.
>>
>> The changes from V7 is following:
>> - Divides patch file.
>> ? : The 03 patch on V7 patchset is divided into the 03 and 04 patch on V8 patchset.
>> ? ? The O3 patch is only for DMA_SLAVE_CONFIG command.
>> ? ? The 04 patch is only for DMA_TERMINATE_ALL command.
>> - Code clean-up
>> ? : Remove unnecessary code on 05 patch.
>>
>> [PATCH v8 01/16] DMA: PL330: Add support runtime PM for PL330 DMAC
>> [PATCH v8 02/16] DMA: PL330: Update PL330 DMA API driver
>> [PATCH v8 03/16] DMA: PL330: Support DMA_SLAVE_CONFIG command
>> [PATCH v8 04/16] DMA: PL330: Remove the start operation for handling DMA_TERMINATE_ALL command
>> [PATCH v8 05/16] DMA: PL330: Add DMA_CYCLIC capability
>> [PATCH v8 06/16] ARM: SAMSUNG: Update to use PL330-DMA driver
>> [PATCH v8 07/16] ARM: SAMSUNG: Add common DMA operations
>> [PATCH v8 08/16] ARM: EXYNOS4: Use generic DMA PL330 driver
>> [PATCH v8 09/16] ARM: S5PV210: Use generic DMA PL330 driver
>> [PATCH v8 10/16] ARM: S5PC100: Use generic DMA PL330 driver
>> [PATCH v8 11/16] ARM: S5P64X0: Use generic DMA PL330 driver
>> [PATCH v8 12/16] ARM: SAMSUNG: Remove S3C-PL330-DMA driver
>> [PATCH v8 13/16] spi/s3c64xx: Add support DMA engine API
>> [PATCH v8 14/16] spi/s3c64xx: Merge dma control code
>> [PATCH v8 15/16] ASoC: Samsung: Update DMA interface
>> [PATCH v8 16/16] ARM: SAMSUNG: Remove Samsung specific enum type for dma direction
> Thanks,
>
> I have pushed these into my samsung-dma branch, Fixed the typos in the
> changelog of patch 4.
>
> Please check and let me know if all are fine, I will push them to my
> next tomorrow
>
> If anyone has concerns on this series please let me know by tomorrow
>

I have no concern about patches modifying samsung specific code.

Of the patches touching common pl330 code, I had acked Patch-1,2,3 & 5
in previous revisions already. So for them, you may add my
     Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

The changelog for [PATCH v8 04/16] is misleading - we don't need any
modification for the reason mentioned in changelog. But the modification
has positive side-effect of preventing callbacks during terminate_all which
is no way understood from the changelog. So I would like to changelog
corrected.

thanks,
-jassi
