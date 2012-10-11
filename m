From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Thu, 11 Oct 2012 12:49:34 +0200
Subject: alignment faults in 3.6
In-Reply-To: <20121011103257.GO4625@n2100.arm.linux.org.uk>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <506ED18C.3010009@gmail.com> <20121005140556.GQ4625@n2100.arm.linux.org.uk>
 <506EEFBB.3060705@gmail.com> <507619FA.6080001@jonmasters.org>
 <yw1xtxu1pwtv.fsf@unicorn.mansr.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7038@saturn3.aculab.com>
 <yw1xpq4ppcju.fsf@unicorn.mansr.com>
 <1349949638.21172.8445.camel@edumazet-glaptop>
 <1349950926.21172.8521.camel@edumazet-glaptop>
 <20121011103257.GO4625@n2100.arm.linux.org.uk>
Message-ID: <1349952574.21172.8604.camel@edumazet-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-11 at 11:32 +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 11, 2012 at 12:22:06PM +0200, Eric Dumazet wrote:
> > I took a look, and I dont see why/how gcc could use a ldm instruction
> > 
> > Doing so assumed the alignment of the structure was 8 bytes, but its
> > not.
> > 
> > Networking stack mandates that IP headers are aligned on 4 bytes
> > boundaries, not 8 bytes.
> 
> Err, no.  ldm is "load multiple" not "load double".  It loads multiple
> 32-bit registers, and its requirement for non-faulting behaviour is for
> the pointer to be 4 byte aligned.  However, "load double" requires 8
> byte alignment.

So if you have an alignment fault, thats because IP header is not
aligned on 4 bytes ?

If so a driver is buggy and must be fixed.

Please send us full stack trace
