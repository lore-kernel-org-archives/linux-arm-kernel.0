From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 01 May 2014 01:06:34 +0200
Subject: [PATCH v4 5/8] mfd: db8500-prcmu: Use cpufreq_for_each_entry
 macro for iteration
In-Reply-To: <4646665.ZmnOyyFeHY@vostro.rjw.lan>
References: <534DB213.7080802@semaphore.gr> <20140422112717.GA21613@lee--X1>
 <4646665.ZmnOyyFeHY@vostro.rjw.lan>
Message-ID: <1853484.NiSvS4ksI8@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 22, 2014 01:49:31 PM Rafael J. Wysocki wrote:
> On Tuesday, April 22, 2014 12:27:17 PM Lee Jones wrote:
> > On Tue, 22 Apr 2014, Rafael J. Wysocki wrote:
> > 
> > > On Tuesday, April 22, 2014 08:15:41 AM Lee Jones wrote:
> > > > > The cpufreq core now supports the cpufreq_for_each_entry macro helper
> > > > > for iteration over the cpufreq_frequency_table, so use it.
> > > > > 
> > > > > It should have no functional changes.
> > > > 
> > > > > Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> > > > > ---
> > > > 
> > > > It would be good to have a changelog which describes the differences
> > > > between the versions, so we can keep track.
> > > > 
> > > > >  drivers/mfd/db8500-prcmu.c | 19 ++++++++-----------
> > > > >  1 file changed, 8 insertions(+), 11 deletions(-)
> > > > 
> > > > So it looks like I already applied v2 of this patch to my tree. What
> > > > changed in v3 and v4? Should I remove that patch from MFD and apply
> > > > this one instead?
> > > 
> > > The reason why v4 was sent is because I asked for it.
> > > 
> > > And if you applied [5/8] without [1/8], it won't work, because the macro is
> > > introduced by that patch.
> > 
> > That's right, which is why I mailed you about it:
> > 
> >   > > > Applied untested by me.
> >   > >
> >   > > Wouldn't build. Let it go via Rafael.
> >   >
> >   > Rafael, would you mind creating a branch from this patch set that we
> >   > can both pull from please?
> > 
> > > If that's the case, please drop [5/8] and let me handle the entire series.
> > 
> > I'm happy for you to apply the series and send me a pull-request for
> > either a) the entire series or b) just the patches which touch MFD and
> > any subsequent decencies. Or I can apply them and send you one.
> 
> OK, I'll create a separate branch with those patches and will let you know
> where it is.

This material is on the cpufreq-macros branch of the linux-pm.git tree now, so

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cpufreq-macros

will be safe to pull from going forward.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
