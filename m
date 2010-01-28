From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 28 Jan 2010 07:11:22 +0100
Subject: spitz (arm pda): time no longer ok after resume
In-Reply-To: <20100127180010.GA22660@n2100.arm.linux.org.uk>
References: <20100127171308.GA24875@ucw.cz>
	<20100127180010.GA22660@n2100.arm.linux.org.uk>
Message-ID: <20100128061121.GA15937@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2010-01-27 18:00:10, Russell King - ARM Linux wrote:
> On Wed, Jan 27, 2010 at 06:13:08PM +0100, Pavel Machek wrote:
> > It seems that spitz has problems with time after resume; time while it
> > was sleeping is not accounted. This seems to be regression in
> > 2.6.33-rc5.
> 
> No rtc configured/loaded?

I did make oldconfig and it worked before... strange.

.config:
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set

It looks you are right, pxa-rtc.o was not there. Sorry.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
