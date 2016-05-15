From: tytso@mit.edu (Theodore Ts'o)
Date: Sat, 14 May 2016 22:43:27 -0400
Subject: Unclear BSD licensing (headers, MODULE_LICENSE, versions)
In-Reply-To: <CACna6ryZS1Q8=kBMMePAE_A377OReaYJdx8azZBrqG2jG+eMJg@mail.gmail.com>
References: <CACna6ryZS1Q8=kBMMePAE_A377OReaYJdx8azZBrqG2jG+eMJg@mail.gmail.com>
Message-ID: <20160515024327.GB7799@thunk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 15, 2016 at 12:44:35AM +0200, Rafa? Mi?ecki wrote:
> 
> I recently received a hint that it would be nice/expected to have DTS
> files licensed under BSD. I had no experience with BSD, so I started
> looking at this and the way kernel parts use it.

There is a lot of sloppiness in some of the driver code.
Unfortunately, fixing it is something that really has to be done by
the copyright holder, or whoever submitted the kernel in the first
place and who has clear knowledge of what the copyright holder had
intended.

There is also a fairly wide range of seriousness of the various
defects you've listed.  On one extreme, although it's true that some
license, such as the ClearBSD license has <Organization> in its
template, when the original code file you've referenced has in its header:

 * Copyright 2004-2012 Analog Devices Inc.
 * Licensed under the Clear BSD license.

....tt's pretty obvious that Organization should be "Analog Devices Inc".

In other cases, it's pretty clear that someone copied the drivers from
some out-of-tree distribution (e.g., "see kernel-base/COPYING...") and
where finding the original distribution and then adding the Copyright
permission statement is a pretty easy thing to do.  (And in case where
a third party can easily show proof that the intent of the copyright
holder is clearly expressed, that third party probably is able to
submit a patch to fix up the source file.

> I'm wondering how we could improve this situation. I got 2 main ideas:
> 
> 1) Extend MODULE_LICENSE
> We could add new acceptable entries specifying BSD version. We could
> try to improve checkpatch.pl to look for a full license in a header
> (it seems to be required as it has to provide <organization>). Maybe
> we could figure out (with some lawyers?) how to treat sources using
> "Dual BSD/GPL" mentioning GPL only (without BSD) in their header.

I'm not a fan of this approach.  MODULE_LICENSE puts a hint about the
copyright license of a module where it can be found by the module
loader.  This is useful to enforce things like GPL_SYMBOL_EXPORT, but
I don't think we should try to make MODULE_LICESE to be more than
that.

> 2) Get clear rules on how to write a header
> If you find extending MODULE_LICENSE a bad idea, maybe we can simply
> help people write proper headers. Explain the problem, provide
> examples, maybe add some check in checkpatch.pl.

Adding more text about how to add a proper copyright notice and
license permission statement to the SubmittingDrivers file seems like
a good idea.

I doubt we can make checkpatch.pl smart enough to handle this
situation cleanly.

Cheers,

						- Ted
