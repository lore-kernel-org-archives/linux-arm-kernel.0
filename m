From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Mar 2012 16:20:37 +0100
Subject: ARM11MPcore: tlb_ops_need_broadcast causes deadlock
In-Reply-To: <20120325215535.GB3147@n2100.arm.linux.org.uk>
References: <274124B9C6907D4B8CE985903EAA19E91B2D579066@SI-MBX06.de.bosch.com>
 <20120323173055.GC16225@mudshark.cambridge.arm.com>
 <loom.20120325T135816-592@post.gmane.org>
 <20120325130912.GF5611@n2100.arm.linux.org.uk>
 <4F6F624D.8060409@mac.com>
 <20120325191556.GA3147@n2100.arm.linux.org.uk>
 <4F6F7E99.1020500@mac.com>
 <20120325215535.GB3147@n2100.arm.linux.org.uk>
Message-ID: <20120326152037.GK2475@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hmm, I somehow got dropped from this, but I'll pick it back up here.

On Sun, Mar 25, 2012 at 10:55:35PM +0100, Russell King - ARM Linux wrote:
> On Sun, Mar 25, 2012 at 10:22:49PM +0200, Peter Waechtler wrote:
> > And again I don't understand the abort handler: why do we get a page  
> > fault on
> > a young page then? grrh
> 
> Permissions?  Userspace trying to write to the page when it isn't marked
> writable and dirty?
> 
> >> Moreover, what about the case where we actually remove the page?
> > I don't claim that this is the only way to deadlock - but this is the  
> > case we encounter.
> 
> No, but you're arguing that we drop the TLB flush for your specific case.
> I'm telling you that's pointless if there's other cases as well which
> we'll deadlock.
> 
> But that's neither here nor there because you haven't fully explained
> what the problem is yet..

Yes, I'm inclined to agree with Russell here. Things don't add up and
without further information there's not a lot we can do.

Peter - are you able to reproduce and investigate this problem or was it a
one-off observation? If you can figure out what really goes on inside CPU B
in your example, then we may be able to look into this further. A good first
step might be to work out what triggers the initial data abort and look at
the state of the world at that point.

Will
