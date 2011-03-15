From: James.Bottomley@suse.de (James Bottomley)
Date: Tue, 15 Mar 2011 10:25:51 -0400
Subject: [Security] [PATCH 00/20] world-writable files in sysfs and debugfs
In-Reply-To: <20110315141859.GA19442@kroah.com>
References: <cover.1296818921.git.segoon@openwall.com>
	<AANLkTikE-A=Fe-yRrN0opWwJGQ0f4uOzkyB3XCcEUrFE@mail.gmail.com>
	<1300155965.5665.15.camel@mulgrave.site>
	<20110315030956.GA2234@kroah.com>
	<1300189828.4017.2.camel@mulgrave.site>
	<20110315141859.GA19442@kroah.com>
Message-ID: <1300199151.7744.12.camel@mulgrave.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-03-15 at 07:18 -0700, Greg KH wrote:
> On Tue, Mar 15, 2011 at 07:50:28AM -0400, James Bottomley wrote:
> > On Mon, 2011-03-14 at 20:09 -0700, Greg KH wrote:
> > > There are no capability checks on sysfs files right now, so these all
> > > need to be fixed.
> > 
> > That statement is true but irrelevant, isn't it?  There can't be
> > capabilities within sysfs files because the system that does them has no
> > idea what the capabilities would be.  If there were capabilities checks,
> > they'd have to be in the implementing routines.
> 
> Ah, you are correct, sorry for the misunderstanding.
> 
> > I think the questions are twofold:
> > 
> >      1. Did anyone actually check for capabilities before assuming world
> >         writeable files were wrong?
> 
> I do not think so as the majority (i.e. all the ones that I looked at)
> did no such checks.

OK, as long as someone checked, I'm happy.

> >      2. Even if there aren't any capabilities checks in the implementing
> >         routines, should there be (are we going the separated
> >         capabilities route vs the monolithic root route)?
> 
> I think the general consensus is that we go the monolithic root route
> for sysfs files in that we do not allow them to be world writable.
> 
> Do you have any exceptions that you know of that do these checks?

Heh, I didn't call our security vacillations a dizzying ride for
nothing.  I know the goal once was to try to run a distro without root
daemons (which is what required the capabilities stuff).  I'm actually
trying to avoid the issue ... I just want to make sure that people who
care aren't all moving in different directions.

James
