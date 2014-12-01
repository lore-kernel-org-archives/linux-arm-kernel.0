From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 1 Dec 2014 09:56:43 +0000
Subject: [PATCHv4] dmaengine: fsl-edma: fixup reg offset and hw S/G
 support in big-endian model
References: <1413968035-12855-1-git-send-email-jingchang.lu@freescale.com> 
Message-ID: <BN3PR0301MB1236DA27ED13519CB8724F26877D0@BN3PR0301MB1236.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Vinod,

  Could you please help review and merge this patch if possible. Thanks.

Thanks and Best Regards,
Jingchang

>>-----Original Message-----
>>From: Jingchang Lu [mailto:jingchang.lu at freescale.com]
>>Sent: Wednesday, October 22, 2014 4:54 PM
>>To: vinod.koul at intel.com
>>Cc: dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>>linux-kernel at vger.kernel.org; Lu Jingchang-B35083
>>Subject: [PATCHv4] dmaengine: fsl-edma: fixup reg offset and hw S/G
>>support in big-endian model
>>
>>The offset of all 8-/16-bit registers in big-endian eDMA model are
>>swapped in a 32-bit size opposite those in the little-endian model.
>>
>>The hardware Scatter/Gather requires the subsequent TCDs stored in
>>memory in little endian independent of the register endian model, the
>>eDMA engine will do the swap if need.
>>
>>This patch also use regular assignment for tcd variables r/w instead of
>>with io function previously that may not always be true.
>>
>>Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
>>---
>>changes in v4:
>> use __le32/16 define little endian tcd struct explicitly.
>> modify fsl_edma_set_tcd_regs() to simplify parameters.
>> define fsl_edma_fill_tcd() as inline function.
>>
>>changes in v3:
>> use unsigned long instead of u32 in reg offset swap cast to avoid
>warning.
>>
>>changes in v2:
>> simplify register offset swap calculation.
>> use regular assignment for tcd variables r/w instead of io function.
>>
>> drivers/dma/fsl-edma.c | 189
>>+++++++++++++++++++++++++-------------------
>>-----
>> 1 file changed, 96 insertions(+), 93 deletions(-)
