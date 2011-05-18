From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 May 2011 23:57:49 +0100
Subject: [PATCH 1/1] ARM: thumb: Have the machine name indicate
	operation in thumb mode.
In-Reply-To: <alpine.LFD.2.00.1105181845540.14430@xanadu.home>
References: <20110513195316.9AD0940CD1@eskimo.mtv.corp.google.com>
	<BANLkTikhRuk2ZfYjriTcP7oFdbr7h1oP5g@mail.gmail.com>
	<20110514100232.GC30539@n2100.arm.linux.org.uk>
	<20110516121657.GA7715@arm.com>
	<alpine.LFD.2.00.1105161008320.14430@xanadu.home>
	<20110516144311.GC7715@arm.com>
	<BANLkTik0LL+dFCo_H-YhF+BUOXyP7MAKzA@mail.gmail.com>
	<alpine.LFD.2.00.1105181803090.14430@xanadu.home>
	<20110518223319.GB21384@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1105181845540.14430@xanadu.home>
Message-ID: <20110518225749.GF21384@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 06:49:16PM -0400, Nicolas Pitre wrote:
> On Wed, 18 May 2011, Russell King - ARM Linux wrote:
> > We already have a way of adding stuff for bug tracking purposes.  The
> > "Internal error" line is perpended with 'PREEMPT' or 'SMP' depending
> > on what build options were enabled.  We just need to do the same with
> > T2.  IOW, something like this:
> [...]
> 
> This is indeed useful if the kernel oopses.  However this doesn't help 
> for those cases where the kernel doesn't crash but still exhibits 
> unexpected behaviors.  Having the thumbness of the kernel also displayed 
> in dmesg and uname -a would also be good to have.

In which case I think we'll have to talk to kbuild people to get
mkcompile_h modified.  Also maybe asking what other architectures
do for this kind of problem may be a good idea - especially before
we start abusing and hacking stuff like the hardware name.
