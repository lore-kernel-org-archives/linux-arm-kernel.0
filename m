From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Aug 2012 12:04:32 -0700
Subject: [PATCH 4/4] [RFC] ARM: treewide: manually change more
 mach-*/*.h includes
In-Reply-To: <20120824203622.GB1303@atomide.com>
References: <201208221253.07278.arnd@arndb.de>
 <20120822214323.GA12255@n2100.arm.linux.org.uk>
 <201208231135.11688.arnd@arndb.de>
 <201208231726.11293.arnd@arndb.de>
 <20120824203622.GB1303@atomide.com>
Message-ID: <20120830190431.GU1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120824 13:37]:
> * Arnd Bergmann <arnd@arndb.de> [120823 10:27]:
> > On Thursday 23 August 2012, Arnd Bergmann wrote:
> > > On Wednesday 22 August 2012, Russell King - ARM Linux wrote:
> > > > In any case, what we should be doing here as well is moving the headers
> > > > included by drivers for platform data out of the arch/arm/mach/ subtrees
> > > > and into include/linux/platform_data.  That will substantially reduce the
> > > > amount of mach/ headers to deal with.
> > > 
> > > I've just looked at the {mach,plat}/*.h files that get included in ARM
> > > specific drivers. Out of the 342 header files that get used in this way,
> > > I found 93 that are practically just platform data, and a few that
> > > are platform_data mixed with something else.
> > > 
> > > How about I move all the pure platform data definition files now and
> > > rebase the other patches on top of that. Here is a list of suggested
> > > file names in include/linux/platform_data/:
> > 
> > I've just scripted this and am running my build testsuite over it now.
> > 
> > Please let me know what you think about it.
> > 
> > 	Arnd
> > 
> > The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:
> > 
> >   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git 
> 
> I'd like to run some checks on this, but branch name missing here for
> pulling a branch in for testing..

FYI, after talking with Arnd this is the testing/platform-data branch
in the arm soc tree. Seems to build and work fine on omaps:

Tested-by: Tony Lindgren <tony@atomide.com>

Arnd, can you please provide a stable branch to use as a base of
other related header changes?

Regards,

Tony
