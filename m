From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 23 Jul 2013 11:36:28 +0200
Subject: [PATCH, re-send] Always trap on BUG()
In-Reply-To: <51E47924.9030005@zytor.com>
References: <201307051738.35930.arnd@arndb.de>
 <20130715151612.9499c2b2ad40e88d183a4600@linux-foundation.org>
 <20130715222755.GY24642@n2100.arm.linux.org.uk>
 <51E47924.9030005@zytor.com>
Message-ID: <20130723093628.GC19786@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> On 07/15/2013 03:27 PM, Russell King - ARM Linux wrote:
> > On Mon, Jul 15, 2013 at 03:16:12PM -0700, Andrew Morton wrote:
> >> I've been thinking for a while that CONFIG_BUG=n is a pretty dumb thing
> >> to do, and that maintaining it (and trying to fix the warnings it
> >> produces) aren't worth the effort and that we should remove the whole
> >> thing.  Perhaps your patch changes that calculus, dunno.  Please discuss.
> > 
> > This isn't about introducing "CONFIG_BUG=n" - this is about making a
> > kernel with CONFIG_BUG=n build without producing tonnes and tonnes of
> > warnings, as it does today.  It makes building randconfig pretty
> > useless to find what could be more important warnings.
> > 
> 
> Well, there are three alternatives here, right:
> 
> 1. We can use unreachable(), which means that the compiler can assume it
> never happens.

AFAICS this is dangerous as it loses warnings and moves execution into 
la-la-land without any obvious sign at the C level.

> 2. We can trap without metadata.

This is what the patch does.

> 3. We can trap with metadata (current CONFIG_BUG=y).

That is still kept with the patch.

> I am *guessing* this does 2, but it isn't clear.

Yes, that's what it does - and I think it's the best of all worlds:

Acked-by: Ingo Molnar <mingo@kernel.org>

(the crazies can keep a separate patch to remove even more of BUG() to win 
a K or two.)

Thanks,

	Ingo
