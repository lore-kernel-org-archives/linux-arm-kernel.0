From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2017 17:37:48 +0000
Subject: [PATCH 0/3] Extend rtc-armada38x support for Armada 7K/8K
In-Reply-To: <20170216173348.GT27312@n2100.armlinux.org.uk>
References: <20170216153136.27009-1-gregory.clement@free-electrons.com>
 <20170216173348.GT27312@n2100.armlinux.org.uk>
Message-ID: <20170216173748.GU27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 05:33:48PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 16, 2017 at 04:31:33PM +0100, Gregory CLEMENT wrote:
> > The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. However
> > the SOC integration differs in 2 points:
> >      - MBUS bridge timing initialization
> >      - IRQ configuration at SoC level
> > 
> > This patch set extends the driver support to these SoCs family.
> 
> I've just tried merging this into my kernel, and...
> 
> root at mcbin:~# date
> Thu Feb 16 17:33:00 GMT 2017
> root at mcbin:~# hwclock -uw
> root at mcbin:~# hwclock
> Sun 07 Feb 2106 01:49:51 GMT  -10.010475 seconds
> root at mcbin:~# hwclock
> Sun 07 Feb 2106 01:49:51 GMT  -10.010458 seconds
> 
> I guess it needs the same hack that Armada38x needs - "date reset" twice
> in uboot?

Hmm, even with that sorted:

root at mcbin:~# hwclock
Thu 16 Feb 2017 17:35:50 GMT  -0.786571 seconds
root at mcbin:~# hwclock
Thu 16 Feb 2017 17:35:51 GMT  -1.347541 seconds
root at mcbin:~# hwclock
Thu 16 Feb 2017 17:35:52 GMT  -1.889295 seconds
root at mcbin:~# hwclock
Thu 16 Feb 2017 17:35:53 GMT  -1.787338 seconds
root at mcbin:~# hwclock
Thu 16 Feb 2017 17:35:54 GMT  -1.444397 seconds
root at mcbin:~# hwclock
Thu 16 Feb 2017 17:35:55 GMT  -1.419772 seconds
root at mcbin:~# hwclock
Thu 16 Feb 2017 17:35:58 GMT  -2.555282 seconds
root at mcbin:~# hwclock
Thu 16 Feb 2017 17:36:09 GMT  -0.515289 seconds
root at mcbin:~# hwclock
Thu 16 Feb 2017 17:36:11 GMT  -1.773030 seconds
root at mcbin:~#

I think this RTC is a random number generator.  It's certainly not
a reliable indication of time.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
