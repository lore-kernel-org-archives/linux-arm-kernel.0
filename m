From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Dec 2011 21:03:32 +0000
Subject: [PATCH 1/3] ARM: msm: Remove MSM7x00 support
In-Reply-To: <1322772598.3704.33.camel@m0nster>
References: <1322752657.3704.2.camel@m0nster>
 <20111201181736.GA13182@huya.qualcomm.com> <1322764745.3704.9.camel@m0nster>
 <20111201192705.GA23641@huya.qualcomm.com> <1322767992.3704.13.camel@m0nster>
 <20111201194353.GA24293@huya.qualcomm.com>
 <20111201201950.GE9581@n2100.arm.linux.org.uk>
 <1322771147.3704.21.camel@m0nster>
 <20111201203506.GG9581@n2100.arm.linux.org.uk>
 <1322772598.3704.33.camel@m0nster>
Message-ID: <20111201210332.GI9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 12:49:58PM -0800, Daniel Walker wrote:
> On Thu, 2011-12-01 at 20:35 +0000, Russell King - ARM Linux wrote:
> > On Thu, Dec 01, 2011 at 12:25:47PM -0800, Daniel Walker wrote:
> > > On Thu, 2011-12-01 at 20:19 +0000, Russell King - ARM Linux wrote:
> > > > Now, the obvious question to ask now is this: as you sent your question,
> > > > and Daniel obviously objects, was Daniel one of your respondants?  If
> > > > not, then he carries some of the blame for this patch being created
> > > > in the first place by having missed the email/not replied/etc.
> > > > 
> > > 
> > > What if the people using the hardware aren't even on the list ? It's not
> > > their fault is it?
> > 
> > Did you notice I mentioned six months?
> 
> Yeah I did notice..
> 
> > The way to remove non-broken code is:
> > 1. to ask.  If no one responds, then
> > 2. submit a patch to put an entry in feature-removal-schedule.txt giving a
> >    description of what will be removed and when - and then flag it
> >    with a patch to remove it.  If no one responds to that, then
> > 3. the patch to remove it re-posted, and if no one objects it gets
> >    merged.
> > 
> > So, if people care about bits of code _and_ they're not on the relevant
> > subsystem mailing lists, they need to keep an eye on the feature removal
> > file - otherwise they're in for nasty surprises.
> 
> I agree with the steps, but I'm not sure David knows about (or would be
> following) those steps. Not to mention these devices are still readily
> available used .. I wouldn't expect anyone to even remotely ponder
> removing this code for at least another 10 years.. In order to even
> start the process above there has to be some good probability that no
> has the device or cares at all about the device..

Actually... no.  We've removed entire SoCs which have lost their
maintainers well under this '10 years'.

One of the key decisions for removing code is the cost of keeping it
in a buildable state when there's no one actively looking after it.
If it has a high cost it'll get deleted much earlier...
