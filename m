From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 21 Jun 2017 11:41:46 +0200
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <20170621091948.GP4902@n2100.armlinux.org.uk>
References: <20170620213507.urobmtg34vzubrdq@piout.net>
 <alpine.DEB.2.20.1706202343120.2157@nanos>
 <20170621075152.GA15996@amd>
 <20170621083907.y3gadsmsoufa5niv@piout.net>
 <20170621091948.GP4902@n2100.armlinux.org.uk>
Message-ID: <20170621094146.ebq5hxuvtmfdgekz@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/2017 at 10:19:49 +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 21, 2017 at 10:39:07AM +0200, Alexandre Belloni wrote:
> > On 21/06/2017 at 09:51:52 +0200, Pavel Machek wrote:
> > > If someone uses different threshold, well, there will be
> > > confusion. But only for users that have their rtc set to the past,
> > > which is quite unusual.
> > > 
> > 
> > Or not, having an RTC set in the past is actually quite common. I'd find
> > it weird to have a new device boot and be set to a date in the future.
> 
> ... and that basically means you can't use hardware that stores RTC
> time as a 32-bit number of seconds past 2106.
> 

And I guess it will not matter much for us anyway ;)

> > Also note that the threshold or offset thing may seem like a good idea
> > but fails with many RTCs because of how they handle leap years.
> 
> Not for the case being discussed.  A 32-bit counter of seconds knows
> nothing about leap years - all that is handled by the conversion
> functions.
> 

Well, the patch series touches some RTCs that are not using 32 bit
counter so I though I might as well raise the issue now.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
