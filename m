From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 14:20:48 +0000
Subject: Orion Pull request
In-Reply-To: <20120724081732.GR18778@lunn.ch>
References: <20120724081732.GR18778@lunn.ch>
Message-ID: <201207251420.48634.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 July 2012, Andrew Lunn wrote:
> I know this is very late, the main pull request direction Linus has
> been made, etc. Its been an interesting learning experience for me,
> jumping in to take over from Jason.
> 
> Please note, there are a few patches between the v3.5-rc7 and the
> first patch to be pulled. These patches have been accepted by the I2C
> maintainer & SPI maintainer, so should not be pulled.
> 
> I also have no pgp keys in place, so there is no signed tag. I will
> remedy this for next time.
> 
> If you can pull this great. Otherwise, it can wait for 3.7.
> 

Hi Andrew,

I'm looking at the series now, I was making sure to get other stuff
out of the way first for the patches that are now upstream.

I would like to pull at least some of the patches, but I think you
are missing some background on the process actually works.

Most importantly, you should not submit identical patches with
different commit IDs to different maintainers. As you explain,
your branch contains SPI and I2c patches that were applied to
other trees already and that are now upstream. If I pull your branch,
we will end up with a git history that has the same change twice,
which is confusing and causes troubles for bisection and for
dependency tracking. I'm not sure if the fact that they have been
applied to the other branches now means that something is broken
(that should never happen either), but if that is the case, I will
definitely apply the bug fixes that are needed to repair the
situation.

Another important point is that we use "topic branches" in the arm-soc
tree, so you should try to separate bug fixes, cleanups, DT conversions,
new DT files, etc all into their own branch. The "ARM: Kirkwood:
Ensure runit clock always ticks", "mach-dove: Fixup ge00 initialisation"
"ARM: Orion: fix driver probe error handling with respect to clk"
and "ARM: Kirkwood: Replace mrvl with marvell" patches definitely
fall into the "bugfix" category here, so I definitely want them.
You can send me bug fixes at any time and they will get submitted
into the latest development branch, during and after the merge window.
If a bug fix is also relevant for older kernels, please add the line
"Cc: stable at vger.kernel.org", which triggers the process of getting
the patch included into the stable kernel releases (v3.0.x, v3.4.x,
v3.5.x at this time).

Please split the other patches into branches according to what
they do, and make sure that each branch is based on an -rc release
rather than a random point in the git history or patches that
are not upstream. We can then decide which ones to still send
for v3.6 and which branches to delay for v3.7.

As a minor comment, your one-line change descriptions are not
all formatted the same way, you use "ARM: kirkwood",
"mach-kirkwood:" and "kirkwood:" intermixed. Please use just
the first one.

If you have more questions, feel free to also contact us on IRC
(on #armlinux in irc.freenode.net).

	Arnd
