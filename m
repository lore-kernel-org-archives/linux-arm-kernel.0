From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Jul 2013 10:05:03 +0100
Subject: [PATCH] ARM: locks: remove opencoded #16 for ticket shift
In-Reply-To: <alpine.LFD.2.03.1307181350440.14924@syhkavp.arg>
References: <1373894879-30559-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1307170952580.14924@syhkavp.arg>
 <20130718172159.GC9837@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1307181350440.14924@syhkavp.arg>
Message-ID: <20130719090503.GB18139@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 06:53:06PM +0100, Nicolas Pitre wrote:
> On Thu, 18 Jul 2013, Will Deacon wrote:
> > There are two aspects to the ticket lock:
> > 
> >   1. The size of each ticket
> >   2. The location of the next ticket within the 32-bit lock word
> > 
> > TICKET_SHIFT actually defines (2) and could be 0 or 16, hence why I was
> > making this small cosmetic change.
> 
> Doesn't matter where the location of the next ticket is.  Whether it is 
> 0 or 16, for the above code to work, it *must* always perform a ror #16.  
> Hence tying the ror constant with TICKET_SHIFT is wrong.

You're right; we always need to refer to the higher ticket, rather than
`owner' or `next'. Patch dropped.

Cheers,

Will
