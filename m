From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 22:29:53 +0100
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux, atags" entry
In-Reply-To: <20151125210310.GT2517@atomide.com>
References: <20150713131902.GH26485@atomide.com> <17134653.86P3dFyQKK@wuerfel>
 <20151125210310.GT2517@atomide.com>
Message-ID: <3245119.krc4KB3uae@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 13:03:10 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [151125 11:50]:
> > On Wednesday 25 November 2015 10:16:44 Tony Lindgren wrote:
> > > At least I don't have better solutions in mind.
> > 
> > I would be happier if we could restrict this as much as possible to the
> > boards that need it, as an opt-in. That way it doesn't become an ABI
> > for people that don't already rely in this information. How about
> > adding a check the code adds the linux,atags property to do it
> > only for a whitelist of board numbers?
> 
> Or populate /proc/atags only for the ones that need it from machine
> specific init_early?

That would also address my main concern about /proc/atags, but still
leave the atags in /proc/device-tree/chosen/linux,atags, and it would
be bad if someone who currently uses /proc/atags changes their code
to use the other file instead of finding a proper solution.

	Arnd
