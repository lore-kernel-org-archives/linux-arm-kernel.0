From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Mar 2013 22:42:39 +0100 (CET)
Subject: [PATCH v3 0/9] refactoring for mask_cache
In-Reply-To: <5149F48D.3030706@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com><20130319100352.GB2419@localhost><20130319110620.GO13280@titan.lakedaemon.net><51484793.5020102@keymile.com><20130319114430.GP13280@titan.lakedaemon.net>
 <20130319115615.GR13280@titan.lakedaemon.net> <5149F48D.3030706@keymile.com>
Message-ID: <alpine.LFD.2.02.1303202222340.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Mar 2013, Gerlando Falauto wrote:
> On 03/19/2013 12:56 PM, Jason Cooper wrote:
> > On Tue, Mar 19, 2013 at 07:44:31AM -0400, Jason Cooper wrote:
> > > Those commit IDs are going to change once LinusW (I presume) applies
> > > them to his tree, so he'll have to edit each commit message to point the
> > > the correct commit.
> > > 
> > > LinusW, do you want me to handle this?
> > 
> > Never mind, coffee underflow to /dev/brain.  One drawback to mutt, can't
> > view thread while typing messages...
> 
> 1) I had no idea who LinusW is, I assume Linus Walleij who should be the
> maintainer of linux-gpio. And linux-gpio should have nothing to do with this
> discussion... so I should assume you never mentioned him, right?

Jason had a brain hickup as he told. So please ignore that part :)
 
> 2) About the SOB part... most of this is inspired by Simon's original (single)
> patch and Holger's reworking. Should they be given credit or not? If yes, how?
> If I don't get an answer I would just assume no and I'll take all the blame
> and credit all by myself. :-)

Yes, you can give them credit. There are only a few official
"....-by:" tags, but you can chose from the inofficial ones:

Suggested-by:
Originally-by:
Original-patch-by:
Requested-by:
Original-idea-by:
Based-on-patch-by:

That's an incomplete list of already in-use tags, but one of those is
probably sufficient.
 
> 3) Jason, did you mean you would pull it to
> http://git.infradead.org/users/jcooper/linux.git? Shall I change the SOB lines
> and resubmit? Or should I submit it somewhere else instead?

That needs to go through my tree, really. And please just post it to
LKML with the relevant people CC'ed.

> 4) About submitting to -stable, I guess it wouldn't make any sense until it
> gets included upstream

Right. Though I'm a bit concerned about the amount of change
involved. So it's simpler to do:

Cc: <stable@vger.kernel.org> # simple resolution will be sent in reply

Then let the people who have this problem reply on that patch series
with a simple revert of that generic_chip() conversion commit
concering their particular subarchitecture instead of forcing a
nightmare of complex (and maybe untested) changes onto stable.

Thanks,

	tglx
