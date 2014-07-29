From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jul 2014 23:35:43 +0100
Subject: [GIT PULL v2] nommu fixes for 3.17-rc1
In-Reply-To: <20140722074246.GA28538@pengutronix.de>
References: <20140630144355.GH14781@pengutronix.de>
 <20140701094159.GM14781@pengutronix.de>
 <20140711073054.GI11056@pengutronix.de>
 <20140722074246.GA28538@pengutronix.de>
Message-ID: <20140729223543.GF30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 09:42:46AM +0200, Uwe Kleine-K?nig wrote:
> Hi Russell,
> 
> On Fri, Jul 11, 2014 at 09:30:54AM +0200, Uwe Kleine-K?nig wrote:
> > On Tue, Jul 01, 2014 at 11:41:59AM +0200, Uwe Kleine-K?nig wrote:
> > > I updated my tag to pull to not include the commit that drops ARM740T,
> > > ARM940T and ARM946E-S because of Arnd's concerns. Also the two cleanups
> > > that depended on this one are dropped.
> > > 
> > > (As before) I picked -rc3 as base because 1c2f87c22566..6980c3e2514e~ is
> > > broken on nommu. 
> > > 
> > > The following changes since commit 4c834452aad01531db949414f94f817a86348d59:
> > > 
> > >   Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.pengutronix.de/git/ukl/linux.git tags/nommu-for-rmk
> > > 
> > > for you to fetch changes up to 83de911cf897a4317147dd9cb379378c2c4abf4c:
> > > 
> > >   ARM: make user_addr_max more robust (2014-07-01 11:12:09 +0200)
> > > 
> > > ----------------------------------------------------------------
> > > Two different fixes for the same problem making some ARM nommu configurations
> > > not boot since 3.6-rc1. The problem is that user_addr_max returned the biggest
> > > available RAM address which makes some copy_from_user variants fail to read
> > > from XIP memory.
> > > 
> > > Even in the presence of one of the two fixes the other still makes sense, so
> > > both patches are included here.
> > > 
> > > This problem was the last one preventing efm32 boot to a prompt with mainline.
> > You neither commented nor pulled this request (at least I didn't find it
> > in your repository). Is it still on your radar?
> I'd really like to have this in 3.17. Any chances? Would you prefer to
> get these patches into your patch tracker?

Hmm, the key thing for pull requests that you want me to pull is to send
them to linux+pull at ... rather than plain linux at ... for the simple reason
that most people are incapable of addressing their emails correctly.

It is very difficult to sort out which messages that contain "GIT PULL"
are meant for me - especially when people put me in the To: field of
all sorts of random emails with very little thought.  Because of that
behaviour, which has recently spread to replies by various mailers too,
I no longer take any notice of which header field my email address
appears in any message.

The actions of various people and various email programs which don't
understand the meaning of To: and Cc: has made this much harder than
it otherwise needs to be, so now we need to invent new ways to work
around that "bug" in many humans on this planet.

Based on your subject line, I'm queuing this for the merge window.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
