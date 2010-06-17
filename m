From: benjamin.zores@alcatel-lucent.com (Benjamin Zores)
Date: Thu, 17 Jun 2010 08:45:29 +0200
Subject: Request review of device tree documentation
In-Reply-To: <4C190D50.2010501@am.sony.com>
References: <4C13430B.5000907@firmworks.com>	<1276339529.1962.184.camel@pasglop>	<1276339684.1962.186.camel@pasglop>	<4C13B618.1030006@firmworks.com>	<1276383132.1962.195.camel@pasglop>	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>	<4C146F18.9030008@firmworks.com>	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>	<20100614124438.GF9323@yookeroo>	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>	<20100614160201.GD9550@shareable.org>	<4C165FD1.6080505@firmworks.com>	<4C186AA8.4040709@compulab.co.il>	<4C186B7B.1060308@firmworks.com>	<4C186C72.2020506@compulab.co.il>	<4C187013.5000400@firmworks.com>	<4C18738C.4090809@compulab.co.il>	<4C187FF0.5020806@firmworks.com>	<4C18A9C7.5070800@compulab.co.il>	<alpine.LFD.2.00.1006160917390.13427@xanadu.home>
	<4C190D50.2010501@am.sony.com>
Message-ID: <4C19C489.1010008@alcatel-lucent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/06/2010 19:43, Tim Bird wrote:
> On 06/16/2010 07:39 AM, Nicolas Pitre wrote:
>    
>> The cost function _is_ different for the Linux community and decision
>> makers at chip vendor companies. I know that for having worked long
>> enough at a prominent chip vendor already.
>>
>> Those vendors want to ship a product and be first on the market before
>> the competitors do.  They grab a kernel tree, fit in their existing HAL
>> as quickly as they can, so that they are able to demo the new chip to
>> potential customers even before moving to full production.  And if the
>> HAL fitting work has been done into last year's kernel already, then
>> they will simply reuse that kernel to minimize the effort further as in
>> theory only the HAL part needs to be swapped with the new one (doesn't
>> matter if last year's kernel was itself already based on a kernel from
>> the year before).  Once the software appears to work, they send it to
>> customers and forget about it as they move to the next chip design.  So
>> here, the cost is directly related to bring-up time, and quick (or big)
>> ugly software hacks are more than a convenience but rather a necessity
>> if you want to win the race.
>>
>> People from the Linux community care about totally different things. The
>> most important factor here is _long term_ maintainability.  It is
>> important that the code be clean, use a uniform coding style, and follow
>> common interfaces.  This is so because the cost function here is
>> directly related to the difficulty for the Linux community to evolve the
>> kernel with generic improvements and new features.  If each driver has a
>> different style, or rely on a different HAL, then it quickly becomes
>> extremely expensive to update those drivers along with the generic
>> improvements.  And if the HAL is in binary form only, or stuck behind
>> some unalterable BIOS-like calls or firmware API, then it may even be
>> impossible to update those drivers as the execution context assumed by
>> the HAL firmware may not be guaranteed anymore (think about UP vs SMP,
>> different preemption modes, different realtime kernel modes, etc.)  And
>> of course it is impossible to anticipate what execution context and
>> requirements the kernel might need in the future, hence this can't be
>> provisioned for (and much less validated) into the HAL design in advance
>> (and see above why it is next to hopeless to expect vendors to update
>> their HAL for old products in a timely fashion).
>>
>> So there *is* indeed a big difference between both points of view.  And
>> sometimes the imperatives from each group are in total conflict.
>>      
> This is absolutely correct.  At the CE Linux Forum, we've been working
> for years to try to get vendors more involved in the community, with
> a variety of techniques, including white papers for management,
> magazine articles, outreach at industry events, and hosting our
> own events to introduce "industry" and "community" developers.
>    

Which they somehow do more and more.

I second Nicolas' theory (for having worked with his previous employer 
he's talking about but also others)
and it's true that chip vendors usually want to have their chip 
supported in a BSP ASAP
whatever the code looks like or how easy/hard it may be to use it for a 
customized board.

Though, more and more are now duplicating efforts, having 2 kernel 
development teams: one doing BSP
and one trying to push code in upstream Linux, conforming to the 
expected level of quality and maintainability.

While it's true that having this second team doing so is fully welcomed, 
one has to say that most of the times
there are no communication between these teams in the same company, 
people redoing the same mistakes
(or having to fix the same bugs) twice.

Ben
