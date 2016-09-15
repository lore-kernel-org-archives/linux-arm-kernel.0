From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Sep 2016 13:46:02 +0100
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <1473940088.10230.65.camel@nexus-software.ie>
References: <20160914100949.GA6179@kroah.com>
 <20160914173625.GB15356@leverpostej>
 <20160914180754.GA16053@kroah.com>
 <20160914182952.GA21615@kroah.com>
 <1473932133.10230.25.camel@nexus-software.ie>
 <20160915101330.GB6718@leverpostej>
 <1473935756.10230.42.camel@nexus-software.ie>
 <20160915112029.GC6718@leverpostej>
 <1473940088.10230.65.camel@nexus-software.ie>
Message-ID: <20160915124601.GA9316@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 12:48:08PM +0100, Bryan O'Donoghue wrote:
> On Thu, 2016-09-15 at 12:20 +0100, Mark Rutland wrote:
> > For example, you have absolutely no guarantee as to what backs
> > get_cycles(). Despite this, the code assumes that get_cycles() is
> > backed by something running at the frequency described in a
> > "google,greybus-frame-time-counter" node.
> > 
> > Even if this *happens* to match what some piece of arch code provides
> > today on some platform, it is in no way *guaranteed*.
> 
> That's the point though, if you declare "google,greybus-frame-time-
> counter" in your platform code - then you can use 'get_cycles()' in
> this manner

To be clear, *some* properties (and perhaps additional nodes) may need
to be in the DT, in order to capture the hardware property or
relationship that you are reliant upon.

However, the DT cannot possibly know anything about get_cycles(), as
get_cycles() is a kernel implementation details that's subject to
arbitrary change at any point in time, independent of the DT.

The "google,greybus-frame-time-counter" node, as it stands, does not
capture any relevant hardware detail, and does not belong in the DT.

> > Without a higher-level view of what you're trying to achieve, it's
> > not clear to me whether get_cycles() is the right interface.
> 
> I appreciate that.

Until that's clarified, we won't make any progress here.

Thanks,
Mark.
