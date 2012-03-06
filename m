From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 5 Mar 2012 21:13:15 -0700 (MST)
Subject: [PATCHv4 1/6] ARM: OMAP3 PM: correct enable/disable of daisy io
 chain
In-Reply-To: <4F558A42.1020503@ti.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com>
 <1330701475-22576-2-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1203051953580.6649@utopia.booyaka.com>
 <4F558A42.1020503@ti.com>
Message-ID: <alpine.DEB.2.00.1203052103440.6649@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra

(thanks for adding in Nilesh, added him again here)

On Tue, 6 Mar 2012, Rajendra Nayak wrote:

> Yes, thats my understanding too, again based on taking to people like
> Nilesh, because the documentation just doesn't mention this clearly.
> The 4430 TRM is a tad bit better like you said.
> 
> I guess your confusion of IO wakeups working with EN_IO_CHAIN set to '0'
> is also probably coming from the fact that the bit itself is called
> *EN_IO_CHAIN* which is a completely *wrong* name for the bit, as
> compared to what it does.
> That bit is actually used to send a WUCLK pulse through the chain, so
> you set it to '1' and wait for it to propagate through the chain, then
> you set it to '0' and again wait for it to propagate through.

Okay.  So to confirm: EN_IO_CHAIN doesn't enable a continuous clock, it 
just controls the WUCLKIN line directly?

> The control to enable/disable is at 2 levels, a global switch which is
> 'EN_IO' in case of OMAP3 and the one at the individual pad level.

Do you happen to know what EN_IO/GLOBAL_WUEN does?  For example, if it's 
0, will the I/O chain not latch in wakeup events occuring on the pads?  
Or does it just cause the PRCM to ignore any PRCM wakeups coming from the 
I/O chain?  (Or something else, heh)

> You can also read this thread which has some more explanation based on
> my understanding of how this works
> http://www.spinics.net/lists/linux-serial/msg04480.html

I've been reading that post; it's been quite helpful.


- Paul
