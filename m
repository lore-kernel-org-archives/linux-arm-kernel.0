From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jun 2012 19:41:48 +0100
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <alpine.LFD.2.02.1206111430300.23555@xanadu.home>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
 <20120611182640.GC18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111430300.23555@xanadu.home>
Message-ID: <20120611184148.GD18267@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 02:40:24PM -0400, Nicolas Pitre wrote:
> On Mon, 11 Jun 2012, Russell King - ARM Linux wrote:
> 
> > On Mon, Jun 11, 2012 at 01:18:28PM -0400, Nicolas Pitre wrote:
> > > And that message certainly has to go as it may be triggered multiple 
> > > times per second in some use cases here.
> > 
> > That, I interpret, as an attempt to use CPU hotplugging for power
> > saving.
> > 
> > No.  Do not do that.  Under any circumstances.  Not only is the CPU
> > hotplugging code racy in places, it also totally destroys the ability
> > to have threads bound to CPUs, or even interrupts to CPUs.
> 
> [ more comments ommitted ]
> 
> Russell, let me suggest you take the time to read this:
> 
> 	http://lwn.net/Articles/481055/
> 
> then let's restart this conversation if you please.

Same comments apply for exactly the reasons I stated.
