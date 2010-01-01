From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jan 2010 20:46:05 +0000
Subject: [PATCH] Valid relocation symbol for FLAT format on ARM
In-Reply-To: <20091230184929.GB22469@shareable.org>
References: <52886e760912300830n2234e01bm2e300828141d226@mail.gmail.com>
	<20091230184929.GB22469@shareable.org>
Message-ID: <20100101204605.GH16220@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2009 at 06:49:29PM +0000, Jamie Lokier wrote:
> ps. Russell, proof that someone is using no-MMU ARM? :-)
> I'll get back to your earlier mail on that subject when I have more
> time, btw.

Two users, at Christmas no less.  I suspect they're only playing with
uclinux because they're bored over the holiday season. ;)

Really though, if uclinux on ARM is being used, it needs more visible
activity to ensure that it gets tested.  What was merged from Hyok's
efforts is only half the story - just the core code.  AFAIK, everything
else went in the circular filing cabinet.

Catalin did some work to bring one of the ARM boards up with a uclinux
kernel, and some of those patches were merged, but without any configs.

This in turn means is that we don't have any uclinux defconfigs, so we
don't have kautobuild running any uclinux builds - which effectively means
we have zero build coverage on uclinux.  We don't know when it breaks,
etc.

Consequently, it hardly ever gets looked at, and has probably been
rotting away since it was originally merged.

That's what the real problem is - it's not enough to have code merged
and then have a mostly silent user base.
