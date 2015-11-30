From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 07:23:53 -0800
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <201511300115.12478@pali>
References: <20150713131902.GH26485@atomide.com>
 <20151129180939.GE30871@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1511291902100.22569@knanqh.ubzr>
 <201511300115.12478@pali>
Message-ID: <20151130152352.GY2517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [151129 16:16]:
> On Monday 30 November 2015 01:09:17 Nicolas Pitre wrote:
> > On Sun, 29 Nov 2015, Russell King - ARM Linux wrote:
> > > On Sat, Nov 28, 2015 at 12:34:23PM -0500, Nicolas Pitre wrote:
> > > > Good. And Arnd likes the idea too. So we might be converging at
> > > > last which is a good thing.
> > > 
> > > I disagree with the idea that there is convergence.  There might be
> > > convergence towards an idea, but... Here's a mail extract, from
> > > July 7th, from earlier in this very thread:
> > > 
> > > Pali:
> > > > Me:
> > > > > Are the ATAGs at a fixed address on the N900?
> > > > 
> > > > Yes, in board-rx51.c is:
> > > > 
> > > > .atag_offset    = 0x100
> > > > 
> > > > and Nokia Bootloader (proprietary) store them to that address.
> > > > 
> > > > > Can that be handled in
> > > > > some kind of legacy file for the N900 which calls save_atags()
> > > > > on it, so we don't end up introducing yet more stuff that we
> > > > > have to maintain into the distant future?  If not, what about
> > > > > copying a known working atag structure into a legacy file for
> > > > > the N900?
> > > > 
> > > > I already asked question if it is possible to read ATAGs from DT
> > > > booted kernel. And somebody (do not remember who) wrote to ML,
> > > > that it is not possible and it can be done in that uncompress
> > > > code.
> > 
> > Who is that somebody? If ever it happened to be me then objection is
> > withdrawn. Otherwise that somebody should come forth and speak up
> > again.
> > 
> 
> ... do not remember ... this discussion were in more email threads and 
> takes more then one year... sorry but my memory is not excellent

Yes this certainly seems like the best solution. I think we got into
the atags-to-dt track as some of the atags are already being translated.

In this case there's no need to translate them AFAIK. You can just
parse them and have them available for the user space. So as long as
nothing trashes the atags at the atag_offset, you should be able to
call a function to parse them in the n900 specific init_machine.

Regards,

Tony
