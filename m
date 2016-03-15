From: hare@suse.de (Hannes Reinecke)
Date: Tue, 15 Mar 2016 07:49:56 +0100
Subject: [PATCH 09/22] ncr5380: Adopt uniform DMA setup convention
In-Reply-To: <alpine.LNX.2.00.1603151313510.9662@nippy.intranet>
References: <20160314042700.596192247@telegraphics.com.au>
 <20160314042702.976019738@telegraphics.com.au> <56E669F6.8070407@suse.de>
 <alpine.LNX.2.00.1603151313510.9662@nippy.intranet>
Message-ID: <56E7B094.3000301@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2016 04:19 AM, Finn Thain wrote:
> 
> On Mon, 14 Mar 2016, Hannes Reinecke wrote:
> 
>>> @@ -1555,8 +1555,7 @@ static int NCR5380_transfer_dma(struct S
>>>  	NCR5380_read(RESET_PARITY_INTERRUPT_REG);
>>>  	*data = d + c;
>>>  	*count = 0;
>>> -	*phase = NCR5380_read(STATUS_REG) & PHASE_MASK;
>>> -	return foo;
>>> +	return result;
>>>  }
>>>  
>>>  /*
>>
>> Don't you miss a phase update here?
> 
> I guess I missed explaining the change in the commit log.
> 
> The *phase assignment is redundant because after NCR5380_transfer_dma() 
> returns control to NCR5380_information_transfer(), the latter routine then 
> also returns, and so *phase is dead.
> 
Right. Please add this to the commit message.

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
