From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 3 Jan 2018 05:13:29 +0000
Subject: [LINUX PATCH 3/4] dmaengine: xilinx_dma: Fix compilation warning
In-Reply-To: <20180103035918.GH18649@localhost>
References: <1513851098-15787-1-git-send-email-appanad@xilinx.com>
 <1513851098-15787-4-git-send-email-appanad@xilinx.com>
 <20180103035918.GH18649@localhost>
Message-ID: <CY1PR02MB169249D209C6E76AA7067269DC1E0@CY1PR02MB1692.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

	Thanks for the review... 

>
>On Thu, Dec 21, 2017 at 03:41:37PM +0530, Kedareswara rao Appana wrote:
>
>Fix title here too

Sure will fix in v2... 

>
>BTW whats with LINUX tag in patches, pls drop them

Ok will mention the Linux tag info in the cover letter patch from the next patch series on wards...

Regards,
Kedar.

>
>> This patch fixes the below sparse warning in the driver
>> drivers/dma/xilinx/xilinx_dma.c: In function
>?xilinx_vdma_dma_prep_interleaved?:
>> drivers/dma/xilinx/xilinx_dma.c:1614:43: warning: variable ?prev? set but not
>used [-Wunused-but-set-variable]
>>   struct xilinx_vdma_tx_segment *segment, *prev = NULL;
>>
>> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
>> ---
>>  drivers/dma/xilinx/xilinx_dma.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c
>> b/drivers/dma/xilinx/xilinx_dma.c index 8467671..845e638 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -1611,7 +1611,7 @@ xilinx_vdma_dma_prep_interleaved(struct dma_chan
>> *dchan,  {
>>  	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
>>  	struct xilinx_dma_tx_descriptor *desc;
>> -	struct xilinx_vdma_tx_segment *segment, *prev = NULL;
>> +	struct xilinx_vdma_tx_segment *segment;
>>  	struct xilinx_vdma_desc_hw *hw;
>>
>>  	if (!is_slave_direction(xt->dir))
>> @@ -1665,8 +1665,6 @@ xilinx_vdma_dma_prep_interleaved(struct dma_chan
>*dchan,
>>  	/* Insert the segment into the descriptor segments list. */
>>  	list_add_tail(&segment->node, &desc->segments);
>>
>> -	prev = segment;
>> -
>>  	/* Link the last hardware descriptor with the first. */
>>  	segment = list_first_entry(&desc->segments,
>>  				   struct xilinx_vdma_tx_segment, node);
>> --
>> 2.7.4
>>
>
>--
>~Vinod
