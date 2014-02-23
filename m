From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 23 Feb 2014 15:04:06 -0800
Subject: [GIT PULL] clk: mvebu: fixes for v3.14
In-Reply-To: <53048565.4080105@free-electrons.com>
References: <20140208173154.GL8533@titan.lakedaemon.net>
 <20140219054245.8345.72570@quantum> <53048565.4080105@free-electrons.com>
Message-ID: <20140223230406.22529.52931@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2014-02-19 02:20:21)
> On 19/02/2014 06:42, Mike Turquette wrote:
> > Quoting Jason Cooper (2014-02-08 09:31:54)
> >> Mike,
> >>
> >> Here's a round of fixes I've had in -next for several days.  It's not
> >> the ideal solution, but a short term one while we hash out a proper
> >> solution for v3.15+.
> > 
> > Taken into clk-fixes.
> 
> Hi Mike,
> 
> we will have the same kind of issue with Armada 375 and Armada38x.
> Are you going to take the patch "clk: respect the clock dependencies
> in of_clk_init"
> See the V2 here http://www.spinics.net/lists/arm-kernel/msg306442.html
> 
> My intent is not to put a pressure on you to take this patch, but as
> I explained Armada 375 and Armada38x will be in the same situation of
> the other mvebu were. The patch I mentioned is a solution to fix it
> and if it won't be merged, than we need an other solution. This alternate
> solution is easy to find, it will be the same as this patch set.

Hi Gregory,

The clock dependencies patch is not without controversy. I've looked
through V2 and it looks OK, but I need to think on it a bit more. I'll
make a call later this week, so you'll know what to do for Armada.

Either way I won't take that patch in as a fix for the current -rc's. It
will land in 3.15.

Regards,
Mike

> 
> 
> Thanks,
> 
> Gregory
> 
> 
> 
> > 
> > Thanks!
> > Mike
> > 
> >>
> >> thx,
> >>
> >> Jason.
> >>
> >> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> >>
> >>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.infradead.org/linux-mvebu.git tags/mvebu-clk-fixes-3.14
> >>
> >> for you to fetch changes up to 58d516ae95cbf7eed44f85a01cdfad41f17b4197:
> >>
> >>   clk: mvebu: kirkwood: maintain clock init order (2014-02-06 18:07:01 +0000)
> >>
> >> ----------------------------------------------------------------
> >> mvebu clock fixes for v3.14
> >>
> >>  - kirkwood, dove, armada-xp, armada-370
> >>     - force clock init order broken by sorting DT ocp nodes by address
> >>     - fixes boot failures on affected platforms
> >>
> >> ----------------------------------------------------------------
> >> Sebastian Hesselbarth (4):
> >>       clk: mvebu: armada-370: maintain clock init order
> >>       clk: mvebu: armada-xp: maintain clock init order
> >>       clk: mvebu: dove: maintain clock init order
> >>       clk: mvebu: kirkwood: maintain clock init order
> >>
> >>  drivers/clk/mvebu/armada-370.c | 21 ++++++++++-----------
> >>  drivers/clk/mvebu/armada-xp.c  | 20 +++++++++-----------
> >>  drivers/clk/mvebu/dove.c       | 19 +++++++++----------
> >>  drivers/clk/mvebu/kirkwood.c   | 34 ++++++++++++++++------------------
> >>  4 files changed, 44 insertions(+), 50 deletions(-)
> 
> 
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
