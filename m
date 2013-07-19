From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Jul 2013 15:27:18 +0100
Subject: [PATCH v4 02/17] sched_clock: Use seqcount instead of rolling
 our own
In-Reply-To: <alpine.LFD.2.03.1307191016010.14924@syhkavp.arg>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-3-git-send-email-sboyd@codeaurora.org>
 <20130719090328.GA18139@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1307191016010.14924@syhkavp.arg>
Message-ID: <20130719142718.GG24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 10:20:19AM -0400, Nicolas Pitre wrote:
> On Fri, 19 Jul 2013, Will Deacon wrote:
> 
> > Looks good to me. The current scheme would be very fiddly to extend to
> > 64-bit values on 32-bit architectures without cheap atomic doubleword
> > accesses.
> 
> You should have a look at include/linux/cnt32_to_63.h.
> This could be applied to pure software counters if the low part is 
> atomically increased.

But this can't be used for sched_clock().  That's exactly why I originally
had to rewrite that thing in the first place.
