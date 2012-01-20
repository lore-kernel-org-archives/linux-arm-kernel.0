From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 20 Jan 2012 17:48:31 -0500 (EST)
Subject: [PATCH v2 11/13] ARM: only include mach/irqs.h for !SPARSE_IRQ
In-Reply-To: <4F19DB35.9060707@gmail.com>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
 <1327091591-27125-12-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1201201608400.19587@xanadu.home> <4F19DB35.9060707@gmail.com>
Message-ID: <alpine.LFD.2.02.1201201744130.19587@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jan 2012, Rob Herring wrote:

> On 01/20/2012 03:11 PM, Nicolas Pitre wrote:
> > On Fri, 20 Jan 2012, Rob Herring wrote:
> > 
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> Make mach/irqs.h optional for SPARSE_IRQ. With this change irqs.h can be
> >> removed by converting platforms over to sparse irq.
> >>
> >> This intentionally breaks platforms that enable SPARSE_IRQ.
> > 
> > I don't get what you mean here.  The above seems contradictory.
> > 
> 
> You're right. The intro explains things more clearly.

The intro won't be part of the git history, so please make sure 
individual commit logs are sensible on their own.

> This breaks platforms (at boot time) that don't select SPARSE_IRQ, but 
> let users enable it in their config. I don't understand why sparse irq 
> is a user visible config option. We could move HAVE_SPARSE_IRQ down to 
> each platform that selects SPARSE_IRQ and prevent enabling, but I 
> think allowing it to break is good encouragement for others to fix 
> those platforms. I'm open to other ideas.

SPARSE_IRQ shouldn't be a user configurable option.  There is just no 
point for a user configuring a kernel to be able to change this.


Nicolas




> 
> Rob
> 
