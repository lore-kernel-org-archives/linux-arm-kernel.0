From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 23 Feb 2015 20:44:36 -0800
Subject: [PATCH v3 08/13] mtd: st_spi_fsm: Update the JEDEC probe to
 handle extended READIDs
In-Reply-To: <20150210090433.GE8020@x1>
References: <1418644760-18773-1-git-send-email-lee.jones@linaro.org>
 <1418644760-18773-9-git-send-email-lee.jones@linaro.org>
 <20150113050715.GQ9759@ld-irv-0074> <20150121130204.GC22024@x1>
 <20150206021129.GB18140@ld-irv-0074> <20150210090433.GE8020@x1>
Message-ID: <20150224044436.GF18140@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 05:04:33PM +0800, Lee Jones wrote:
> On Thu, 05 Feb 2015, Brian Norris wrote:
> > On Wed, Jan 21, 2015 at 01:02:04PM +0000, Lee Jones wrote:
> > > On Mon, 12 Jan 2015, Brian Norris wrote:
> > > > On Mon, Dec 15, 2014 at 11:59:15AM +0000, Lee Jones wrote:
> > > > > +#define RDID(...) __VA_ARGS__  /* Dummy macro to protect array argument. */
> > > > 
> > > > What? What needs "protected"?
> > > 
> > > You're asking me questions I can't answer I'm afraid and Angus has now
> > > left the building.  I guess he thinks __VA_ARGS__ will prevent some
> > > kind of overflow?
> > 
> > If you don't understand your own code, how can I be expected to maintain
> > it? This one's pretty trivial and harmless, but an accumulation of
> > answers like this don't exactly put me in a good mood.
> 
> I have never written a line of code that I didn't understand and I
> think you are quite aware that this has never been my 'own code'.

Stop deflecting. I don't care that you didn't write this code. If you're
asking me to apply this upstream, then you own it. Or else, hire another
expert who is willing to own your drivers.

> With regards to the previous accumulation of 'answers like this'; I
> have never been, nor have any desire to be an expert on Memory
> Technology Devices.  I was asked to upstream ST's NAND and NOR drivers
> with support of the local expert and author; however, for reasons not
> under neither of our controls, he has now left the company.  With him
> went all of the historical reasoning for all for the questions you've
> asked.  This is not my domain and have found it pretty tough to keep
> up with all of your demands, both on this and the NAND driver but I
> have been pretty subservient and keep up with them I have.  I am not
> privy to any of the author's thoughts or reasons for any decisions
> taken.  I can only hope that his comments might have some meaning to a
> like minded 'expert' such as yourself.  If you don't know something,
> then the chances are slight that I will be able to answer your query.

Well, I think we have a fundamentally different view of what upstream
development means, then. My job is not to worry about your company's
internal problems. My job is not to worry about your company's
development schedules. My job is not to be your on-call MTD expert.

My job is to make sure that upstream MTD contains relatively clean,
maintainable code, and to accept patches that generally improve the
codebase (i.e., bug fixes, refactoring, feature improvements).

Recall that at least one prominent kernel developer has suggested that
it's actually not in a maintainer's interests to accept random
contributors' code. The contributor's job is to give the maintainer no
reason to reject his or her code. When you repeatedly claim to not
understand the code you're sending me, that sets off warning bells that
make it significantly harder to handle your code.

Perhaps we'd all be better off if I simply removed your driver from
upstream, and you can convince your company to hire an MTD expert to
handle your upstreaming efforts.

> > FWIW, I expect the comment has nothing to do with the __VA_ARGS__; it's
> > just commenting that he has placed a macro around the array just in case
> > somebody needs/wants to rearrange formats later. That way, we don't
> > necessarily have to rewrite the whole table, but can just change the
> > macros.
> > 
> > So the __VA_ARGS__ is just there to make the compiler happy (it thinks
> > an array argument to a macro actually looks like more than one
> > argument), and the comment is only mildly descriptive of its purpose.
> 
> I was present Passing Variable Arguments 101, so I'm aware of what
> __VA_ARGS__ and "..." do at a functional level.

But this is not a '101' use case, exactly. It's there because of the
peculiarities of macros, it seems. And don't pretend to understand when
you clearly did not when I first asked. (And to be clear: I did not
understand either. That's why I asked.)

> So it looks like you had a better idea of what Angus was trying to
> achieve than I do.  Perhaps your question should have been more
> specific.  I guess it's just the comment that you are unhappy with.  I
> can remove it if it makes you happy.

No, the comment wasn't the problem, exactly. I was a bit confused, and I
wrongly assumed that you understood what you're sending me. Apparently
that was too much to assume.

Brian
