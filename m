From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Sep 2009 19:38:47 +0100
Subject: [PATCH] arm: new W macro to WORD_ACCESS
In-Reply-To: <20090916175812.GA18993@Chamillionaire.breakpoint.cc>
References: <200909161601.35662.elendil@planet.nl>
	<20090916175812.GA18993@Chamillionaire.breakpoint.cc>
Message-ID: <20090916183847.GA16457@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 07:58:12PM +0200, Sebastian Andrzej Siewior wrote:
> leads to a build error because the crypto/cast6.c defines a function
> which is named W.

W has nothing to do with the access size, so this change makes it _really_
confusing.  What it's about is telling the compiler to use the ARM 32-bit
version of the instruction coding when building for Thumb2 (which
can intermix Thumb and ARM instruction sets.)

So the macro needs to be renamed... NAK on this patch as it stands.
