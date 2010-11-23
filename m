From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Nov 2010 19:15:58 +0000
Subject: [PATCH] ARM: io: Fix namespace conflicts.
In-Reply-To: <20101123140116.GP4693@pengutronix.de>
References: <1286967121-5888-1-git-send-email-charu@ti.com>
	<20101123140116.GP4693@pengutronix.de>
Message-ID: <20101123191558.GB26510@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 03:01:17PM +0100, Uwe Kleine-K?nig wrote:
> I wonder if it's not better to make these static inlines instead.  Then
> no naming conflicts can occur.  And maybe we'd catch some more strange
> things because p gets a proper type.
> 
> I don't know how this influences gcc though.

See my email about how code changes affect the optimization of completely
unrelated functions.  Someone pointed out that the problem has been
reported on x86, and GCC people say that it's intentional.

That makes it almost impossible to evaluate whether making these inline
functions is a net benefit or net loss as there is too much noise from
such a change.
