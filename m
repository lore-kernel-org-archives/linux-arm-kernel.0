From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 13 Oct 2015 11:58:33 +0300
Subject: [PATCH v4 11/25] ARM/dmaengine: edma: Merge the two drivers under
 drivers/dma/
In-Reply-To: <20151012160024.GF27370@localhost>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
 <1443088932-21731-12-git-send-email-peter.ujfalusi@ti.com>
 <20151012160024.GF27370@localhost>
Message-ID: <561CC7B9.8000201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2015 07:00 PM, Vinod Koul wrote:
> On Thu, Sep 24, 2015 at 01:01:58PM +0300, Peter Ujfalusi wrote:
>> Move the code out from arch/arm/common and merge it inside of the dmaengine
>> driver.
>> This change is done with as minimal change to the code as possible to avoid
>> any possibilities to introducing regression.
> 
> Is this a pure move patch or code has been modified, if latter am
> disappointed that existing code style issue have not been fixed

Yes, it is mostly code move, I have done minimal changes only needed to get
the moved code working in the new location.
Patch 13 in this series will go through the file and will fix up most (I hope
all) of the outstanding coding style issues.
At this point I wanted to have as small change as possible.

>> +static inline void edma_write(struct edma_cc *ecc, int offset, int val)
>> +{
>> +	__raw_writel(val, ecc->base + offset);
>> +}
>> +static inline void edma_modify(struct edma_cc *ecc, int offset, unsigned and,
>> +			       unsigned or)
> 
> This looks bad on my 80 char screen, and few more places below
> 
>> +{
>> +	unsigned val = edma_read(ecc, offset);
> 
> checkpatch should have asked you to add empty line here, many places below
> too
> 
>> +	val &= and;
>> +	val |= or;
>> +	edma_write(ecc, offset, val);
>> +}
> 
> empty line here and few more places
> 
> More later :)
> 


-- 
P?ter
