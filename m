From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Dec 2010 23:37:19 +0100
Subject: [PATCH 1/7] msm: io: I/O register definitions for MSM8960
In-Reply-To: <20101215220317.GA22394@huya.qualcomm.com>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<201012151740.24933.arnd@arndb.de>
	<20101215220317.GA22394@huya.qualcomm.com>
Message-ID: <201012152337.19475.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 December 2010, David Brown wrote:
> 
> On Wed, Dec 15, 2010 at 05:40:24PM +0100, Arnd Bergmann wrote:
> 
> > My point was really that they should not be exclusive, even if they
> > are rather different. If the code is structured in a more modular
> > way, you can turn all MSM/QSD options from the "Qualcomm MSM SoC Type"
> > choice into separate "bool" config options. You probably don't want
> > to do that now for all the existing ones, but I would suggest you
> > try not add more to the pile ;-).
> 
> It's kind of hard to do too much of this, though, until ARM kernels
> can be relocated.  They mostly all live at different base addresses
> (and 8960 might also move).  Throw CPU differences into the mix and it
> gets messier.
> 
> I'm not saying it isn't solvable, but there are a lot of things that
> need to be done to get there.

Yes, I understand that it's hard for many reasons, but my impression
is that there is a general agreement on the idea. As I said, I don't
expect you to fix it all at once, but it shouldn't be too hard
to take care when adding new code.

We already have infrastructure that deals with different CPU cores
in one kernel binary, at least from v5 to v7, and some platforms
like omap and realview can already be built for a variety of very
different machines without such problems.

	Arnd
