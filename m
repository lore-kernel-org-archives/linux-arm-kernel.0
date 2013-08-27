From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 Aug 2013 18:04:31 -0400
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <20130827235533.2cc85d33@skate>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827163939.24636d80@skate> <20130827151136.GA10084@localhost>
 <20130827152535.GG19598@titan.lakedaemon.net>
 <20130827191337.GA2339@localhost> <521D063F.4040404@gmail.com>
 <20130827210248.GA19625@obsidianresearch.com>
 <20130827214121.GI19598@titan.lakedaemon.net>
 <20130827235533.2cc85d33@skate>
Message-ID: <20130827220431.GJ19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 11:55:33PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 27 Aug 2013 17:41:21 -0400, Jason Cooper wrote:
> > On Tue, Aug 27, 2013 at 03:02:48PM -0600, Jason Gunthorpe wrote:
> > > Since this is so complex, maybe it is OK to abandon support for non-DT
> > > boards in the WDT driver? Watchdog is not critical functionality, so
> > > nobody should be critically impacted. Boards would have to migrate
> > > to DT to get WDT back?
> > 
> > I'm not 100% opposed to this.  We need to give it careful thought, but
> > it may be a viable solution since we are at the "convert old boards to
> > DT" stage anyhow.  If we had ten more drivers and 6 release cycles in
> > front of us, I'd say no.
> 
> While we're close to full DT for mach-kirkwood and mach-dove, we're
> pretty far from that for mach-orion5x and mach-mv78xx0, and I believe
> both are using the orion_wdt driver.

I understand that they both *can* use it.  Do any distro's actually use
it in default configurations?  Do any users actually load it and kick
the dog in their main loop?

I don't have the answers to those questions, but I'd be surprised if it
was more than a few specialty users.

Another thought:  If there are users in the above scenario, could they
swap out for the kernel's software watchdog?  Assuming they can't
upgrade to DT...

</pokes self> Once pxa-impedance-matcher can edit the dtb, those users
would have a means to upgrade to a DT enabled kernel without bootloader
modifications...  I really gotta get back to that. :)

thx,

Jason.
