From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Jun 2017 10:19:49 +0100
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <20170621083907.y3gadsmsoufa5niv@piout.net>
References: <20170620213507.urobmtg34vzubrdq@piout.net>
 <alpine.DEB.2.20.1706202343120.2157@nanos>
 <20170621075152.GA15996@amd>
 <20170621083907.y3gadsmsoufa5niv@piout.net>
Message-ID: <20170621091948.GP4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 10:39:07AM +0200, Alexandre Belloni wrote:
> On 21/06/2017 at 09:51:52 +0200, Pavel Machek wrote:
> > If someone uses different threshold, well, there will be
> > confusion. But only for users that have their rtc set to the past,
> > which is quite unusual.
> > 
> 
> Or not, having an RTC set in the past is actually quite common. I'd find
> it weird to have a new device boot and be set to a date in the future.

... and that basically means you can't use hardware that stores RTC
time as a 32-bit number of seconds past 2106.

> Also note that the threshold or offset thing may seem like a good idea
> but fails with many RTCs because of how they handle leap years.

Not for the case being discussed.  A 32-bit counter of seconds knows
nothing about leap years - all that is handled by the conversion
functions.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
