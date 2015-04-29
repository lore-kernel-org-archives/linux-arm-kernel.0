From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Apr 2015 09:57:06 +0100
Subject: Bug#782364: linux-image-3.16.0-4-armmp: please configure drivers
 for both Cubox i4pro real time clocks
In-Reply-To: <1428710930.29665.17.camel@decadent.org.uk>
References: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
 <1428710930.29665.17.camel@decadent.org.uk>
Message-ID: <20150429085705.GG12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 11, 2015 at 01:08:50AM +0100, Ben Hutchings wrote:
> If this RTC is not battery backed, it seems like it ought to be disabled
> in this board's device tree.

It's not that simple.

On the lower-end models, the on-SoC RTC is the only RTC there is.  If
it were disabled, there would be no RTC available at all, so there
would be no preservation of time-of-day across reboots.

On the Pro models, the battery backed RTC is fitted.  However, the
battery backed RTC has no wakeup facility.

Only the on-SoC RTC has that ability, so in order to perform time-based
wakeup, the on-SoC RTC needs to be synchronised with the current ToD
and its alarm set.

Not having the on-SoC RTC enabled means that there is no ToD based
wakeup possible.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
