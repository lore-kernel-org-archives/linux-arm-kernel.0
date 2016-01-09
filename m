From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 8 Jan 2016 21:05:21 -0800
Subject: ION DTS changes for HiKey in -next
In-Reply-To: <20160108135552.GE3097@leverpostej>
References: <20160107173744.GJ6588@sirena.org.uk>
 <20160108050214.GD30293@kroah.com>
 <20160108124439.GL6588@sirena.org.uk>
 <20160108135552.GE3097@leverpostej>
Message-ID: <20160109050521.GB4489@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 01:55:52PM +0000, Mark Rutland wrote:
> On Fri, Jan 08, 2016 at 12:44:39PM +0000, Mark Brown wrote:
> > On Thu, Jan 07, 2016 at 09:02:14PM -0800, Greg Kroah-Hartman wrote:
> > > On Thu, Jan 07, 2016 at 05:37:44PM +0000, Mark Brown wrote:
> > 
> > > > I was just looking at DTs in -next and noticed that there is a patch
> > > > 59dfafd03fc (arm64: dts: Add dts files to enable ION on Hi6220 SoC)
> > > > which adds at DT doing something for ION.  Are we sure this should be
> > > > going into the main production DT?  The bindings haven't been reviewed
> > > > as far as I can tell, the matching driver is only in staging and hasn't
> > > > been posted upstream.
> > 
> > > Isn't "staging" upstream enough for this?  :)
> > 
> > I wouldn't have thought so, DTs are supposed to be an ABI so we want
> > proper review and having had a quick glance this doesn't look like it's
> > a hardware description so it's not clear to me it should be in DT at all.
> 
> Indeed.
> 
> The driver and the binding before that don't really belong either,
> I would have NAK'd those on devicetree at vger.kernel.org, though it
> appears I either missed them or they never made it to that list.
> 
> From my PoV there should not be a platform-specific ION binding. If we
> need one at all, people should work on the proposed generic binding [1]
> or figure out how to do this with the existing reserved-memory bindings.

Ok, I've now reverted that commit, thanks for letting me know.

greg k-h
