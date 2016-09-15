From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Sep 2016 16:47:36 +0100
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <1473954000.4035.5.camel@nexus-software.ie>
References: <20160914173625.GB15356@leverpostej>
 <20160914180754.GA16053@kroah.com>
 <20160914182952.GA21615@kroah.com>
 <1473932133.10230.25.camel@nexus-software.ie>
 <20160915101330.GB6718@leverpostej>
 <1473935756.10230.42.camel@nexus-software.ie>
 <20160915112029.GC6718@leverpostej>
 <1473940088.10230.65.camel@nexus-software.ie>
 <20160915124601.GA9316@leverpostej>
 <1473954000.4035.5.camel@nexus-software.ie>
Message-ID: <20160915154736.GA19214@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 04:40:00PM +0100, Bryan O'Donoghue wrote:
> On Thu, 2016-09-15 at 13:46 +0100, Mark Rutland wrote:
> > On Thu, Sep 15, 2016 at 12:48:08PM +0100, Bryan O'Donoghue wrote:
> > > On Thu, 2016-09-15 at 12:20 +0100, Mark Rutland wrote:
> > > > For example, you have absolutely no guarantee as to what backs
> > > > get_cycles(). Despite this, the code assumes that get_cycles() is
> > > > backed by something running at the frequency described in a
> > > > "google,greybus-frame-time-counter" node.
> > > > 
> > > > Even if this *happens* to match what some piece of arch code
> > > > provides
> > > > today on some platform, it is in no way *guaranteed*.
> > > That's the point though, if you declare "google,greybus-frame-time-
> > > counter" in your platform code - then you can use 'get_cycles()' in
> > > this manner
> > To be clear, *some* properties (and perhaps additional nodes) may
> > need
> > to be in the DT, in order to capture the hardware property or
> > relationship that you are reliant upon.
> 
> Sure but on the relevant platform we know?
> 
> 1. get_cycles() is derived from an architectured MMIO timer
> 2. What is clocking that timer
> 
> So any platform that declares that property must be aware of what its
> doing.

I can't say this any more explicitly:

****************************************************
* The DT *cannot* know anything about get_cycles() *
****************************************************

It's no more complex than that.

Thanks,
Mark.
