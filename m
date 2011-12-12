From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 12 Dec 2011 16:40:06 +0000
Subject: [PATCH v3 2/2] ARM: SMP: Refactor Kconfig to be more maintainable
In-Reply-To: <20111212155912.GB20178@n2100.arm.linux.org.uk>
References: <1323690426-6267-1-git-send-email-dave.martin@linaro.org>
 <1323690426-6267-3-git-send-email-dave.martin@linaro.org>
 <20111212141001.GZ14542@n2100.arm.linux.org.uk>
 <20111212150405.GB2296@linaro.org>
 <20111212155912.GB20178@n2100.arm.linux.org.uk>
Message-ID: <20111212164006.GE2296@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 03:59:12PM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 12, 2011 at 03:04:05PM +0000, Dave Martin wrote:

[...]

> > Duh.  Sorry about that -- will fix and repost.
> > 
> > 
> > Do you have a preference about where to insert new items where the list
> > is not already in alphabetical order?
> 
> What I've done in the past is roughly to ignore anything which isn't
> alphabetical from the top, and place it within that subset.  I
> simetimes change that (if there's a group of HAVE_xxx which is already
> sorted, I add it within that sub-group.)
> 
> In other words, try to sensibly place it so the addition itself is
> alphabetically between two other options which are already so sorted.

OK; I've attempted to do this where I can.

Where it's possible to chop a jumbled list somewhere in the middle such
that the added option sorts strictly after everything in the first
chunk and strictly before everything in the second chunk, I've done that,
so:

	A
	G
	F
+	I
	Z
	P
	W

...which I believe satisfies your criterion.

Where this is not possible, I ignore the smallest amount of items
possible at either end of the list such that the above works, so in:

	A
	G
	F
+	I
	Z
	P
	W
	H
	Z

... I ignore the final H and Z.  The only way to be in order with
respect to those would be to put I far away from its correct position,
which would be undesirable.

This stragety should mean that nothing ever needs to move across the
newly added item, unless the list is already significantly out of order
(in which case there's no perfect solution except for sorting the list).

Cheers
---Dave
