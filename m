From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Jun 2012 15:56:50 -0400 (EDT)
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <20120611192003.GE18267@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
 <20120611182640.GC18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111430300.23555@xanadu.home>
 <20120611184148.GD18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111458310.23555@xanadu.home>
 <20120611192003.GE18267@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1206111535100.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2012, Russell King - ARM Linux wrote:

> On Mon, Jun 11, 2012 at 03:11:05PM -0400, Nicolas Pitre wrote:
> > On Mon, 11 Jun 2012, Russell King - ARM Linux wrote:
> > 
> > > Same comments apply for exactly the reasons I stated.
> > 
> > No they don't.  They can't. The generic kernel code doesn't know what is 
> > happening behind the scene and may not even care if at the low level a 
> > complete CPU replacement happened.  Trust me, I happen to know one thing 
> > or two about those issues you mentioned and the code I'm working on will 
> > be posted in due course.
> 
> Stop being bitchy.  Look, the information I have on bigLittle is limited
> to what has been discussed, and what is in the specs.  That's it.  I don't
> know what the hell you're doing with this.  I'm not a part of that effort.

My intention is not to bitch.  I merely want to give you a heads up on a 
legitimate usage for multiple IPIs which are currently using SGI #1 and 
for which the kernel is generating unwanted warnings.  The actual SGI 
number is unimportant as long as it can be defined as no-op in the 
handle_IPI() context.

> I'm totally out of the loop (as seems to be per bloody normal with ARM Ltd.)

In this case this is a Linaro project, not ARM Ltd.  If you are 
interested by the details before they become public, we can discuss this 
offline.

> So please don't expect me to know what you're working on, or how your code
> works.  I don't.  I don't have that information.

I would expect that you know me well enough to trust me when I tell you 
that my code works.  Or at least give me the benefit of the doubt.


Nicolas
