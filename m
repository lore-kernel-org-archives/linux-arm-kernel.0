From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 1 Feb 2010 22:11:02 +0100
Subject: [PATCH 2/2] ftrace: re-enable dynamic ftrace for ARM
In-Reply-To: <20100201165318.GA1846@debian>
References: <1264959196-5175-1-git-send-email-rabin@rab.in>
	<1264959196-5175-2-git-send-email-rabin@rab.in>
	<20100201102843.GA31714@pengutronix.de>
	<20100201165318.GA1846@debian>
Message-ID: <20100201211101.GB26532@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Feb 01, 2010 at 10:23:19PM +0530, Rabin Vincent wrote:
> On Mon, Feb 01, 2010 at 11:28:43AM +0100, Uwe Kleine-K?nig wrote:
> > On Sun, Jan 31, 2010 at 11:03:16PM +0530, Rabin Vincent wrote:
> > > This adds mcount recording and updates dynamic ftrace for ARM to work
> > > with the new ftrace dyamic tracing implementation.
> [...]
> > Wouldn't it be nice to patch out the instruction pushing lr to the
> > stack (in the gnu case)?  Should work, shouldn't it.
> 
> It would and it should, but the main reasons I didn't do that were:
> 
>   - Thumb-2 support needs the LR to be in place, since even -mapcs-frame
>     does not seem to give us an APCS frame there.   The LR would also
>     be needed if GCC gains the ability to build without frame pointers
>     with -pg.
> 
>   - I'm not sure we would gain much performance by patching it out, and
>     I'd really like to avoid patching more than what is really necessary
>     and to keep the code as similar as possible to the other arches.
That's OK for me.  Then the only thing that would be nice would be some
more documentation.  E.g. how looks the function prologue in the two
cases, which of these instruction is patched?

This doesn't need to be a stopper for your patch, it's on my long term
todo list already to add some documentation to the (non-dynamic) ftrace
on arm.  I wouldn't mind to add the documentation myself, but not now.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
