From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2015 18:38:43 +0000
Subject: SDHCI long sleep with interrupts off
In-Reply-To: <20151217132229.1c699f69@archvile>
References: <20151217112814.6250a3b9@archvile>
 <1450350190.3163.93.camel@pengutronix.de>
 <20151217122053.036daf37@archvile>
 <1450351655.3163.97.camel@pengutronix.de>
 <CAPDyKFosBeyP3YYXz-1uyiqoaLuMQj3+ojzpt1-QY7JU9epggw@mail.gmail.com>
 <20151217132229.1c699f69@archvile>
Message-ID: <20151218183843.GP8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 01:22:29PM +0100, David Jander wrote:
> Ok, this sounds like a good way to go. Unfortunately it also sounds like a
> major endeavor, for which good knowledge of the SDHCI standard is necessary.

That's not entirely true.

Anyone who is really good at programming can fix this: it's a matter of
making changes via a series of code transformations which allow you to
reach a goal.

As far as I can see, there's two solutions to SDHCI:

1. We chuck the existing crappy driver away and start over.
2. We change the existing driver to improve it, which requires the
   transformation approach.

When I say "transformation", it's about making just one change at a time,
such as creating a new function which contains shared code, and then
arranging for it to be called.

The series I did (starting at da91a8f9c0f5) is most likely done via
this method - when modifying a complex driver, I think it's the only
way to make changes safely.  The approach has many advantages, the
most important is that the changes should look obvious and trivial,
even though the sum of the changes may be complex.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
