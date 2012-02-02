From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 Feb 2012 22:25:40 +0800
Subject: [PATCH v2 6/9] ARM: mx31ads: add audmux device
In-Reply-To: <20120202135805.GB3015@richard-laptop>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202085521.GB9773@S2101-09.ap.freescale.net>
 <20120202091132.GD9773@S2101-09.ap.freescale.net>
 <20120202092427.GB32403@b20223-02.ap.freescale.net>
 <20120202130901.GE9773@S2101-09.ap.freescale.net>
 <20120202135805.GB3015@richard-laptop>
Message-ID: <20120202142539.GH9773@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 09:58:07PM +0800, Richard Zhao wrote:
> On Thu, Feb 02, 2012 at 09:09:03PM +0800, Shawn Guo wrote:
> > On Thu, Feb 02, 2012 at 05:24:28PM +0800, Richard Zhao wrote:
> > > On Thu, Feb 02, 2012 at 05:11:34PM +0800, Shawn Guo wrote:
> > > > On Thu, Feb 02, 2012 at 04:55:23PM +0800, Shawn Guo wrote:
> > > > > On Thu, Feb 02, 2012 at 10:12:05AM +0800, Richard Zhao wrote:
> > > > > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > > > > ---
> > > > > >  arch/arm/mach-imx/mach-mx31ads.c      |   10 ++++++++++
> > > > > >  arch/arm/plat-mxc/include/mach/mx31.h |    1 +
> > > > > >  2 files changed, 11 insertions(+), 0 deletions(-)
> > > > > > 
> > > > > Hmm, let's see who are actually using mxc_audmux_v2_configure_port().
> > > > > 
> > > > > $ git grep -n mxc_audmux_v2_configure_port arch/arm/
> > > > > arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:246:     mxc_audmux_v2_configure_port(0,
> > > > > arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:254:     mxc_audmux_v2_configure_port(4,
> > > > > arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:257:     mxc_audmux_v2_configure_port(0,
> > > > > arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:265:     mxc_audmux_v2_configure_port(3,
> > > > > arch/arm/mach-imx/mach-pcm043.c:365:    mxc_audmux_v2_configure_port(3,
> > > > > arch/arm/mach-imx/mach-pcm043.c:371:    mxc_audmux_v2_configure_port(0,
> > > I didn't grep arch/arm. where is pc043 asoc machine file?
> > 
> > It seems to be sound/soc/imx/phycore-ac97.c.
> You see, we're not famaliar with the boards.

It does not need to be familiar with the board to find that out.  I'm
not familiar with the board either, but I gave the answer.

> > 
> > > > > 
> > > > As we are moving audmux into sound/soc/imx, it makes less sense to
> > > > still keep these calls in board files.
> > > It don't corrupt git bisect. We don't have to include it in this patch.
> > 
> > It's logically part of this series.
> I don't know much about the above boards and I can not test either. I think I
> have to leave it to other volunteers. I mainly focus on audmux itself.

Since you get there, you should be the one cleaning that up.  You will
need to touch those board files anyway, since you need to add audmux
device for those boards.  So no hardware for testing is not an excuse.
For those boards, all you need to do are:

 * Change and compile-test the code
 * Cc board maintainers when submitting the patch

We will wait for board maintainers to respond for a reasonable period
of time.  If we do not get any response during the time, we will send
patch upstream anyway.

-- 
Regards,
Shawn
