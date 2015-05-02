From: ijc@hellion.org.uk (Ian Campbell)
Date: Sat, 02 May 2015 17:01:04 +0100
Subject: Bug#782364: linux-image-3.16.0-4-armmp: please configure
 drivers for both Cubox i4pro real time clocks
In-Reply-To: <20150429085705.GG12732@n2100.arm.linux.org.uk>
References: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
 <1428710930.29665.17.camel@decadent.org.uk>
 <20150429085705.GG12732@n2100.arm.linux.org.uk>
Message-ID: <1430582464.15640.186.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-04-29 at 09:57 +0100, Russell King - ARM Linux wrote:
> On Sat, Apr 11, 2015 at 01:08:50AM +0100, Ben Hutchings wrote:
> > If this RTC is not battery backed, it seems like it ought to be disabled
> > in this board's device tree.
> 
> It's not that simple.
> 
> On the lower-end models, the on-SoC RTC is the only RTC there is.  If
> it were disabled, there would be no RTC available at all, so there
> would be no preservation of time-of-day across reboots.
> 
> On the Pro models, the battery backed RTC is fitted.  However, the
> battery backed RTC has no wakeup facility.
> 
> Only the on-SoC RTC has that ability, so in order to perform time-based
> wakeup, the on-SoC RTC needs to be synchronised with the current ToD
> and its alarm set.
> 
> Not having the on-SoC RTC enabled means that there is no ToD based
> wakeup possible.

So is your advice for a multi platform kernel supporting all Cubox
devices to just enable both and to sort out any syncing/naming etc in
userspace?

Thanks,
Ian.
