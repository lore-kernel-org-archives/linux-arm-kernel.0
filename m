From: daniel@zonque.org (Daniel Mack)
Date: Sat, 03 May 2014 00:29:02 +0200
Subject: [PATCH RESEND] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <534EB276.4000408@zonque.org>
References: <1392636546-15541-1-git-send-email-zonque@gmail.com>
 <20140319151352.GJ1976@intel.com> <534576C3.2020409@zonque.org>
 <20140416064534.GL32284@intel.com> <534E3F3D.5080003@zonque.org>
 <20140416082326.GM32284@intel.com> <534E4172.8030401@zonque.org>
 <20140416090923.GR32284@intel.com> <534E9AC1.1040706@zonque.org>
 <20140416160109.GU32284@intel.com> <534EB276.4000408@zonque.org>
Message-ID: <53641C2E.8020101@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 04/16/2014 06:40 PM, Daniel Mack wrote:
> On 04/16/2014 06:01 PM, Vinod Koul wrote:
>> On Wed, Apr 16, 2014 at 04:59:13PM +0200, Daniel Mack wrote:
>>> On 04/16/2014 11:09 AM, Vinod Koul wrote:
>>>> On Wed, Apr 16, 2014 at 10:38:10AM +0200, Daniel Mack wrote:
>>>>>>> It might add to the readability of the drivers, but for the current
>>>>>>> case, I don't think it's really necessary.
>>>>>> That is because you are maintaining the current descriptors in chain_running. If
>>>>>> we use above method then you dont need to use this, right?
>>>>>
>>>>> Jup, but that would result in a rewrite of larger parts of the code. The
>>>>> concept of hot-linking the two list so there's only one resulting list
>>>>> of currently active descriptors is built-in deeply into the driver's
>>>>> concept.
>>>> Ah I suspected so :)
>>>>
>>>> I think for now this is fine you can perhaps upgrade this later :)
>>>
>>> So, do you want me to resend with the minor dma_set_residue() change?
>> Yes please...
>>
> 
> Ah, just checked again and my call to
> 
> 	dma_set_residue(txstate, mmp_pdma_residue(chan, cookie));
> 
> resolves to ...
> 
> static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
> {
>         if (state)
>                 state->residue = residue;
> }
> 
> 
> So there's no need to check for txstate != NULL on the caller side :)

Just in case you missed that over the other mmp_pdma patches: as pointed
out above, dma_set_residue() already does the NULL pointer check you
asked for, so there's nothing to fix up here. IIRC, we were eventually
on the same page regarding all the other details, right?


Many thanks,
Daniel
