From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Mar 2012 14:20:40 +0100
Subject: [PATCH v3] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <20120330131509.GE22981@n2100.arm.linux.org.uk>
References: <1323766966-30502-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20111219071350.GH4962@S2100-06.ap.freescale.net>
 <4EEEE40C.3000200@bluegiga.com>
 <20111219091916.GJ4962@S2100-06.ap.freescale.net>
 <20111219091322.GD14542@n2100.arm.linux.org.uk>
 <20120104135204.GA14741@S2100-06.ap.freescale.net>
 <20120104211800.GF11810@n2100.arm.linux.org.uk>
 <20120105113106.GR11810@n2100.arm.linux.org.uk>
 <20120330131320.GH3254@S2101-09.ap.freescale.net>
 <20120330131509.GE22981@n2100.arm.linux.org.uk>
Message-ID: <20120330132040.GF22981@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 02:15:10PM +0100, Russell King - ARM Linux wrote:
> On Fri, Mar 30, 2012 at 09:13:24PM +0800, Shawn Guo wrote:
> > On Thu, Jan 05, 2012 at 11:31:06AM +0000, Russell King - ARM Linux wrote:
> > > On Wed, Jan 04, 2012 at 09:18:00PM +0000, Russell King - ARM Linux wrote:
> > > > On Wed, Jan 04, 2012 at 09:52:05PM +0800, Shawn Guo wrote:
> > > > > On Mon, Dec 19, 2011 at 09:13:22AM +0000, Russell King - ARM Linux wrote:
> > > > > > No.  It will be automatically removed from any update as long as it does
> > > > > > not conform to the requirements - that is, in this case, the strings
> > > > > > being out of sync indentified in the message to which you replied to.
> > > > > > 
> > > > > > Someone needs to tell me what the correct entry is supposed to look like.
> > > > > > 
> > > > > Hi Russell,
> > > > > 
> > > > > Any chance to have APX4DEVKIT included in your patch 'ARM: Update
> > > > > mach-types' for 3.3?
> > > > 
> > > > As it appears when I run the update script, the answer is yes.  I'll
> > > > update the commit in the next couple of days (I want to reduce the
> > > > number of times I re-merge the tree now that I've a git-rerere immune
> > > > conflict to deal with.)
> > > 
> > > I'll change that - as 3.2 was released last night.  I'm not going to
> > > update mach-types now as that would be suicide - updating it will
> > > mean a bunch of entries will be deleted, and we don't know whether that
> > > will cause build failures.
> > > 
> > > So... not this side of the merge window.
> > 
> > Hi Russell,
> > 
> > I thought you will send a mach-types update during v3.4 merge window,
> > so I merged APX4DEVKIT board file and it's now on mainline (not enabled
> > in mxs_defconfig though).  But I have not seen mach-types update yet
> > while the merge window is almost done.  Do you still plan to send an
> > update or plan to stop updating mach-types?
> 
> Well, it seems I've been missing having that branch in linux-next for
> almost the entire previous cycle.  It would be utterly irresponsible
> to now commit that into mainline because of the -now- huge number of
> platform IDs that it deletes.
> 
> I assume, therefore, that you don't keep an eye on what's in linux-next.

You've actually asked around the same time in the cycle as you asked last
time, and I gave more or less the same reply back then.  Nothing's really
changed.  There is no way in hell that I'm committing any kind of
mach-types update _during_ a merge window.

The only time that I'd consider doing that is _outside_ of a merge window
in preparation for the _next_ merge window, and having it sit in linux-next
for a decent amount of time so that people can see it coming, and deal with
the implications of that update.  I'd say a minimum of a month in linux-next
is required to avoid problems with people on vacations and the like.
