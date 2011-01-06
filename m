From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jan 2011 18:03:45 +0000
Subject: Current OMAP build failures
In-Reply-To: <20110106174950.GU7771@atomide.com>
References: <20110106110336.GC31708@n2100.arm.linux.org.uk>
	<878vyyx8s4.fsf@ti.com>
	<20110106171019.GF1198@n2100.arm.linux.org.uk>
	<20110106174950.GU7771@atomide.com>
Message-ID: <20110106180345.GG1198@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 06, 2011 at 09:49:51AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110106 09:09]:
> > On Thu, Jan 06, 2011 at 09:05:15AM -0800, Kevin Hilman wrote:
> > > Hi Russell,
> > > 
> > > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > > 
> > > > I've observed the following issues while building 2.6.37 + my devel
> > > > branch.  I don't believe any of them to be due to anything in my tree,
> > > > so would be in 2.6.37 as well.
> > > 
> > > What defconfig are you using for these builds?
> > 
> > I couldn't say offhand because they're built from configs created a while
> > back.  I tend to just re-run the build with appropriate O= arguments to
> > test things.
> > 
> > I can send the defconfigs if it'd help.
> 
> I have the following patch queued up as commit be40f7a3d7b53c1a44e11b376b4a395d6b91f58d
> which should fix the compile error you're seeing. This seems to be related
> to some option in the .config that's not happening with any of the
> defconfigs.

That'll be because I have:

CONFIG_I2C_OMAP=y

in my config, whereas most OMAP1 defconfigs don't have it enabled with
the exception of omap_h2_1610_defconfig.
