From: davidb@codeaurora.org (David Brown)
Date: Thu, 12 Aug 2010 13:48:11 -0700
Subject: [RFC] the right way to use gpiolib hooks to automate power
	management?
In-Reply-To: <20100812182744.GC31982@n2100.arm.linux.org.uk>
References: <4C6423C1.9060509@codeaurora.org>
	<20100812182744.GC31982@n2100.arm.linux.org.uk>
Message-ID: <20100812204811.GA31315@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 07:27:44PM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 12, 2010 at 09:39:29AM -0700, Gregory Bean wrote:
> > We have a written a software driver which reference-counts these gpio
> > lines (via a put()/get() api), putting them in their "high-power" active
> > configurations when they're in use, and dropping them down into a
> > high-impedance low-power setting when they're not.
> 
> Beware.  What you're suggesting can lead to an increase in power
> consumption rather than the reduction you're looking for.

That probably just got a little obscured, since I think Greg is more
concerned with the mechanism in software.  Our gpio's are generally
configured in "low power" to be high-impedance with a pull-up or
pull-down, depending on what it is hooked to.  They can be configured
in most of the ways that would make sense to do so.

It may be the case, though, that what this "low power" mode is might
need to also be configurable, since it likely depends on how the pin
is connected.

David
