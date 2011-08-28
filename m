From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 28 Aug 2011 21:06:48 +0100
Subject: [PATCH] spi: Fix builderror in spi-pl022.c
In-Reply-To: <1314559619-19923-1-git-send-email-peterhuewe@gmx.de>
References: <E1Qvo1q-0000qv-TQ@rmk-PC.arm.linux.org.uk>
	<1314559619-19923-1-git-send-email-peterhuewe@gmx.de>
Message-ID: <20110828200648.GC13379@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2011 at 09:26:59PM +0200, Peter Huewe wrote:
> This patch fixes a build error, introduced by commit (67fc8b9f, "PM: add
> runtime PM support to core Primecell driver") which unfortunately was a little
> bit incomplete and did contain a typo (11 instead of 22).
> I'm not sure how this patch could have been tested back then, if it
> doesn't even compile ;)

Maybe it was tested on configs without CONFIG_SUSPEND enabled - which
is highly likely since my ARM development boards don't support S2RAM.

That's the problem with ifdef'ing code.  It makes it impossible to
ensure that it's properly tested.
