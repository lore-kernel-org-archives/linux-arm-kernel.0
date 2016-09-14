From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 17:56:47 +0200
Subject: [GIT PULL] Integrator cleanups and DTS
In-Reply-To: <CACRpkdYBB0rw3uQZnmpsuc_=mf5Ra-HmbRfdm6aT0kn9rn41Lg@mail.gmail.com>
References: <CACRpkdYBB0rw3uQZnmpsuc_=mf5Ra-HmbRfdm6aT0kn9rn41Lg@mail.gmail.com>
Message-ID: <3954604.JGQyd7kqGb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 31, 2016 9:44:55 AM CEST Linus Walleij wrote:
> Hi ARM SoC people,
> 
> this is a request to pull a combined cleanup and DTS changes batch
> for the Integrators.
> 
> Since I have commits such as "move CLCD display to DTS" that is
> a single functional change deleting stuff from the boardfile and adding
> the same to the DTS, it is a combination of DTS and boardfile patches.
> All with the goal to cut down on boardfile code and move to device tree.
> 
> The changes require the corresponding changes from the video/fbdev
> and clk subsystems to come in, but these are orthogonal and depend
> solely on the DTS things coming in place. As the DTS repository is
> "kind of external" I am deliverately relaxed about synchronizing changes
> here and just optimistically assume they will come in during the merge
> window and start working.
> 
> There are no compile-time dependencies on fbdev or clk, just runtime,
> with the DT changes. This cleanup can be merged totally orthogonally,
> and when ARM SoC, fbdev and clk are all merged in the merge window,
> the result will compile and boot nicely.
> 
> I don't expect any conflicting changes to the Integrator in this merge
> window, neither to board files nor DTS.
> 

I've put this into next/late since it's not just dts changes. I considered
putting it into next/cleanup, but then again it's also not just cleanups.

Given the dependency on the fbdev and clk trees, next/late seems appropriate
anyway, thanks!

	Arnd
