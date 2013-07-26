From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Jul 2013 20:39:08 +0100
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <51F2C94F.6020405@broadcom.com>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net> <51F29BFE.8000202@broadcom.com>
 <20130726171153.GN29916@titan.lakedaemon.net> <51F2AF2D.1000300@broadcom.com>
 <20130726184702.GW24642@n2100.arm.linux.org.uk>
 <51F2C94F.6020405@broadcom.com>
Message-ID: <20130726193908.GX24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 12:09:03PM -0700, Christian Daudt wrote:
> On 13-07-26 11:47 AM, Russell King - ARM Linux wrote:
>> On Fri, Jul 26, 2013 at 10:17:33AM -0700, Christian Daudt wrote:
>>> Because ARCH_BCM is meant to be used for a number of SoC families. We've
>>> started upstreaming one (the BCM281XX) but have 2 more internally that
>>> we're working towards upstreaming. And in the future our plan is to keep
>>> the Broadcom Mobile SoCs all building under this single ARCH_BCM
>>> configuration as multiplatform code building a single zImage for them.
>> 1. We're moving to a single zImage for everything.  Not just Broadcom.
>> There's no need for Broadcom stuff to be treated any differently.
>> Participate in the single zImage project and you will get that benefit
>> without these games.
> I don't follow what is the game being played.

I don't really mind what you do, but when you start talking about having
any ARM build always descend into mach-bcm, then something is very wrong
with how you're going about it - you don't see anyone else needing that
in the tree, not even OMAP.

I don't really care if your intention is to decend into mach-bcm and then
do nothing - that's not the point.  The point is we shouldn't even
decend into mach-bcm if there's nothing to be built there.
