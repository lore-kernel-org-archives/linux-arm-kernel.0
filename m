From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 15 Jan 2013 12:24:53 +0100 (CET)
Subject: [PATCHv2 1/4] clockevents: Add generic timer broadcast
 receiver
In-Reply-To: <20130114153612.GF7990@e106331-lin.cambridge.arm.com>
References: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
 <1357742770-15028-2-git-send-email-mark.rutland@arm.com>
 <alpine.LFD.2.02.1301141204421.7475@ionos>
 <20130114112951.GC7990@e106331-lin.cambridge.arm.com>
 <alpine.LFD.2.02.1301141247020.7475@ionos>
 <20130114121247.GD7990@e106331-lin.cambridge.arm.com>
 <alpine.LFD.2.02.1301141318460.7475@ionos>
 <20130114153612.GF7990@e106331-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1301151224300.7475@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Jan 2013, Mark Rutland wrote:
> On Mon, Jan 14, 2013 at 02:17:26PM +0000, Thomas Gleixner wrote:
> > > I thought this previously also [1], but I couldn't find any path such that a
> > > tick_cpu_device would have an evtdev without an event_handler. We always set the
> > > handler before setting evtdev, and alway wipe evtdev before wiping the handler.
> > > 
> > > Have I missed something?
> > 
> > That's an x86 specific issue. Though we could try and make that
> > functionality completely generic.
> 
> Just to check: is the evt->event_handler check necessary?

For x86 yes. See the comment.

Thanks,

	tglx
