From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 09 Aug 2011 11:07:42 -0400
Subject: [Ksummit-2011-discuss] experience with the new arm-soc
	workflow (Was: Re: ARM Maintainers workshop at Kernel Summit) 2011
In-Reply-To: <20110807041124.GA6410@huya.qualcomm.com>
References: <CACxGe6u3jrhnmL=QwCevm5ybgtGqdOzmGZpfve02M12e9v6pNQ@mail.gmail.com>
	<CAOesGMhgd9Grs7JErJ1pTY4fD_taX_YSpeKx_QS21dp2UN=vMQ@mail.gmail.com>
	<20110806212932.GT31521@pengutronix.de>
	<alpine.LFD.2.00.1108061742490.20358@xanadu.home>
	<CAHXqBF+BAdNo3NB9gk0o_aTHUxyQRHw_AvM5ok9zn2yk4NsRZw@mail.gmail.com>
	<20110807041124.GA6410@huya.qualcomm.com>
Message-ID: <1312902462.18583.254.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-08-06 at 21:11 -0700, David Brown wrote:
> On Sun, Aug 07, 2011 at 12:13:48AM +0200, Micha? Miros?aw wrote:
> 
> > I, as another contributor, share Uwe's point of view. The problem with
> > cleanups vs features is that either usually depends on the other.
> > Fixes are a different beasts and they usually go in asynchronously
> > (and quicker) to development changes. The split fixes/development
> > works well in networking area (net and net-next trees).
> 
> Maybe we are thinking about two different kinds of cleanups.  Cleanups
> that would be closely associated with a new feature do make sense to
> me to keep together.  This is the kind of thing where code is cleaned
> up in order to make it easier/cleaner to add the new code.  I don't
> think this makes sense to have in another branch.
> 
> But, there is also a lot of code going on now that is just cleaning
> things up, and it makes sense for this to be in a separate branch.
> 

This isn't too different than what the RT patch does (or did). There was
lots of clean ups that went into mainline that had and ulterior motive
(pave the way for -rt).

Where a clean up goes should be more about why the clean up is
happening. If it is just a clean up for the sake of cleaning up, then a
separate branch is suitable. But if a clean up is there to pave the way
for new features, then that clean up should be with the features it
allows to provide.

-- Steve
