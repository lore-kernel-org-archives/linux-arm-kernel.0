From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 27 Dec 2013 00:18:30 +0100
Subject: [PATCH 2/2] ARM: tegra: paz00: Add LVDS support to device tree
In-Reply-To: <12640298.egJ6YnqTYx@ax5200p>
References: <f03a644deb858f10affb7b039f9982bac81b02c9.1387656959.git.marvin24@gmx.de>
 <1519363.agF5fhqzYs@ax5200p> <12640298.egJ6YnqTYx@ax5200p>
Message-ID: <4478357.8zXrzzag7Z@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 December 2013 14:52:10 Marc Dietrich wrote:
> On Saturday 21 December 2013 23:11:58 Marc Dietrich wrote:
> > Sorry, Stephen, I mistyped your email address in the first post.
> > 
> > On Saturday 21 December 2013 21:38:13 Marc Dietrich wrote:
> > > Add backlight and panel nodes for the PAZ00 TFT LCD panel.
> > > 
> > > Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> > > ---
> > > This should enable everything needed. Unfortunately, in my tests it only
> > > switches on the backlight, but the display controller blocks in some
> > > infinit loop, so we get no output (and no working system). I post it
> > > here
> > > in case I missed something obvious...
> 
> Some users reported that it works when using uboot (yeah, shame on me that I
> still use fastboot on my dev machine), so I did a bit more research. It
> indeed works when using uboot, even when the display setup is disabled
> there. So my guess is that maybe some clock isn't setup by fastboot which
> is done by uboot.

ok, to bring this self-conversation to an end, the cpu blocks at a memory 
barrier right after 
	value = tegra_dc_readl(rgb->dc, DC_CMD_DISPLAY_COMMAND);
in tegra_output_rgb_disable (rgb.c).
