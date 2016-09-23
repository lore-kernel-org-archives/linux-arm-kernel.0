From: eric@nelint.com (Eric Nelson)
Date: Fri, 23 Sep 2016 11:49:29 -0700
Subject: Alignment issues with freescale FEC driver
In-Reply-To: <20160923183725.GC1041@n2100.armlinux.org.uk>
References: <troy.kisky@boundarydevices.com>
 <02afb707-65de-5101-a79b-355929c4e00b@nelint.com>
 <CANn89iLb+QJu+MYh859oAAjcLCsKRpBbzVf43yOdq+HJVtZDpQ@mail.gmail.com>
 <5ee28ee0-cf0c-bdab-1271-f17755365c13@nelint.com>
 <20160923173751.GA1041@n2100.armlinux.org.uk>
 <d0d6f333-c6fc-6572-0633-d7c2c29b8b3f@nelint.com>
 <20160923183725.GC1041@n2100.armlinux.org.uk>
Message-ID: <2a14f7ea-dd86-d188-2288-a0a0cf6f97cd@nelint.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Russell,

On 09/23/2016 11:37 AM, Russell King - ARM Linux wrote:
> On Fri, Sep 23, 2016 at 11:26:18AM -0700, Eric Nelson wrote:
>> So the question is: should we just live with this and acknowledge a
>> performance penalty of bad alignment or do something about it?
> 
> Well, I've no interest in trying to do anything with the FEC driver
> anymore, as I'll just generate another big patch stack which won't
> make it into the kernel in a timely fashion - my last attempt at
> improving the FEC driver was dogged with conflicting changes and I
> gave up with it in the end.  I ended up spending a full cycle
> rebasing, re-testing, and re-evaluating their performance only to find
> that I'd missed the merge window again, and other conflicting changes
> got merged which meant that I had to start from the beginning again.
> 

That's sad. I recall reading your notes on that patch series and it was
a model for how to structure and document a patch set.

I hadn't noticed that you abandoned it and it's frustrating that the
merge process prevented your efforts from being used.

I'm also disheartened to hear your frustration about getting things
pushed up-stream and the entire Linux community should take note.

>> I'm not sure the cost (or the details) of Eric's proposed fix of allocating
>> and copying the header to another skb.
> 
> I had a quick look at this, and although Eric's idea may be a good
> idea, it doesn't contain enough details for me to be able to
> implement it - eg, I've no idea how to attach the 128-byte skb to the
> beginning of a previously allocated skb containing the rest of the
> packet.  I've just looked through linux/skbuff.h and I can't see
> anything that takes two sk_buff's that would do the job.
> 
> However, I don't think that's necessary in this case, because the
> iMX6 FEC supports the 16-bit alignment of the packet, if only it was
> enabled in hardware and the driver caters for it.
> 

Right. If the hardware supports placing things at a suitable address,
that's the right approach.

I'll try to review your earlier patch set and at least find a way to address
the alignment issues.

I'm a bit booked until LinuxCon but will try to get something out soon.

Regards,


Eric
