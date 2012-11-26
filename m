From: elen.song@atmel.com (Elen Song)
Date: Mon, 26 Nov 2012 18:37:28 +0800
Subject: [question] some question about the residue
In-Reply-To: <20121126102200.GB19440@n2100.arm.linux.org.uk>
References: <1353912197-16616-1-git-send-email-elen.song@atmel.com>
 <1353912597.7077.67.camel@vkoul-udesk3> <50B31BCE.6020100@atmel.com>
 <20121126102200.GB19440@n2100.arm.linux.org.uk>
Message-ID: <50B34668.1090402@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-26 18:22, Russell King - ARM Linux wrote:
> On Mon, Nov 26, 2012 at 03:35:42PM +0800, Elen Song wrote:
>> On 2012-11-26 14:49, Vinod Koul wrote:
>>> On Mon, 2012-11-26 at 14:43 +0800, Elen Song wrote:
>>>> Hi All:
>>>>
>>>> 	I got a question about the residue in struct dma_tx_state:
>>>>
>>>> 	I wonder what residue means, is it the current descriptor residue or
>>>>
>>>> 	the total dma buffer residue?
>>> You read the status for descriptor, so it means this is residue for said
>>> descriptor.
>>>
>>>
>> Hi Koul:
>>
>> Well , I don't get it , if I read the status of a LLI, is it means the
>> residue of total LLI length?
>>
>> I saw driver/dma/amba-pl08x.c drivers/dma/coh901318.c, if read status of
>> a LLI, residue is the remain of LLI, not only
>> current descriptor.
>>
>> 1 patch from Russel King how he realize device_tx_status said:
>>
>> [PATCH] ARM: PL08x: clean up LLI lookup
>> As the LLI list is an array, we can use maths to locate which LLI
>> index we're currently at, and then sum up the remaining LLI entries
>> until we reach the end of the list.
>>
>> Is it right?
> It is as far as fixing a pretty major bug in the driver, but it doesn't
> fix the other bug in the driver where it sums up all outstanding
> descriptors, which pre-dates the understanding of 'residue'.
So residue actually means current active descriptor remain, it should 
not sums up all outstanding descriptors.
the way amba-p108x.c and coh901318.c is wrong , right?

best regards
