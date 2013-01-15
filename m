From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Jan 2013 12:00:12 +0000
Subject: [PATCHv2 1/4] clockevents: Add generic timer broadcast receiver
In-Reply-To: <alpine.LFD.2.02.1301151224300.7475@ionos>
References: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
 <1357742770-15028-2-git-send-email-mark.rutland@arm.com>
 <alpine.LFD.2.02.1301141204421.7475@ionos>
 <20130114112951.GC7990@e106331-lin.cambridge.arm.com>
 <alpine.LFD.2.02.1301141247020.7475@ionos>
 <20130114121247.GD7990@e106331-lin.cambridge.arm.com>
 <alpine.LFD.2.02.1301141318460.7475@ionos>
 <20130114153612.GF7990@e106331-lin.cambridge.arm.com>
 <alpine.LFD.2.02.1301151224300.7475@ionos>
Message-ID: <20130115120012.GA23333@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 11:24:53AM +0000, Thomas Gleixner wrote:
> On Mon, 14 Jan 2013, Mark Rutland wrote:
> > On Mon, Jan 14, 2013 at 02:17:26PM +0000, Thomas Gleixner wrote:
> > > > I thought this previously also [1], but I couldn't find any path such that a
> > > > tick_cpu_device would have an evtdev without an event_handler. We always set the
> > > > handler before setting evtdev, and alway wipe evtdev before wiping the handler.
> > > > 
> > > > Have I missed something?
> > > 
> > > That's an x86 specific issue. Though we could try and make that
> > > functionality completely generic.
> > 
> > Just to check: is the evt->event_handler check necessary?
> 
> For x86 yes. See the comment.

Ah, sorry. I misunderstood on my initial reading.

I've posted a version with the evt->event_handler check restored, and the
tick_receive_broadcast stub removed when !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST:

https://lkml.org/lkml/2013/1/14/276

The generic clockevents patches (based on v3.8-rc3) can also be found at
git://linux-arm.org/linux-mr.git tags/timer-broadcast-v3-core

> Thanks,
> 
> 	tglx
> 

Thanks,
Mark.
