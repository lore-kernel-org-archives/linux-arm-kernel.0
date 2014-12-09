From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Tue, 9 Dec 2014 09:35:47 +0000
Subject: [PATCHv4] dmaengine: fsl-edma: fixup reg offset and hw S/G
 support in big-endian model
In-Reply-To: <20141209091248.GA16827@intel.com>
References: <1413968035-12855-1-git-send-email-jingchang.lu@freescale.com>
 <20141209091248.GA16827@intel.com>
Message-ID: <BN3PR0301MB1236551BC121795218B2EAB387650@BN3PR0301MB1236.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Vinod,
  
  Many thanks!
  I resend the patch just before I saw this email, please ignore the
resend one since they are the same.


Thanks and Best Regards,
Jingchang

>-----Original Message-----
>From: Vinod Koul [mailto:vinod.koul at intel.com]
>Sent: Tuesday, December 09, 2014 5:13 PM
>To: Lu Jingchang-B35083
>Cc: dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>linux-kernel at vger.kernel.org
>Subject: Re: [PATCHv4] dmaengine: fsl-edma: fixup reg offset and hw S/G
>support in big-endian model
>
>On Wed, Oct 22, 2014 at 04:53:55PM +0800, Jingchang Lu wrote:
>> The offset of all 8-/16-bit registers in big-endian eDMA model are
>> swapped in a 32-bit size opposite those in the little-endian model.
>>
>> The hardware Scatter/Gather requires the subsequent TCDs stored in
>> memory in little endian independent of the register endian model, the
>> eDMA engine will do the swap if need.
>>
>> This patch also use regular assignment for tcd variables r/w instead
>> of with io function previously that may not always be true.
>Applied, thanks
>
>--
>~Vinod
