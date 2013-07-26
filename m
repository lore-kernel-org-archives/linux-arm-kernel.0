From: cavokz@gmail.com (Domenico Andreoli)
Date: Sat, 27 Jul 2013 01:30:18 +0200
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130726223829.GY24642@n2100.arm.linux.org.uk>
References: <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net>
 <51F29BFE.8000202@broadcom.com>
 <20130726171153.GN29916@titan.lakedaemon.net>
 <51F2AF2D.1000300@broadcom.com>
 <20130726184702.GW24642@n2100.arm.linux.org.uk>
 <51F2C94F.6020405@broadcom.com>
 <20130726193908.GX24642@n2100.arm.linux.org.uk>
 <20130726222809.GB19469@glitch>
 <20130726223829.GY24642@n2100.arm.linux.org.uk>
Message-ID: <20130726233018.GB6953@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 11:38:29PM +0100, Russell King - ARM Linux wrote:
> On Sat, Jul 27, 2013 at 12:28:09AM +0200, Domenico Andreoli wrote:
> > I've got the point but didn't fully understand why would be so wrong to
> > walk one more subdir even if nothing is going to be built.
> 
> Consider what would happen if we decended the 61 mach- subdirectories
> on every build run when only one was really required.  Even though
> kbuild tries to be fast, there's still a non-zero amount of time
> involved with finding out there's nothing to be done - and you
> will still end up generating a built-in.o file even though there's
> no other objects, which will then also be included in the final
> link - again, adding to the work which has to be done.

crystal clear. thanks.

Domenico
