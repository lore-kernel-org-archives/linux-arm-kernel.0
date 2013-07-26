From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Jul 2013 23:38:29 +0100
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130726222809.GB19469@glitch>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net> <51F29BFE.8000202@broadcom.com>
 <20130726171153.GN29916@titan.lakedaemon.net> <51F2AF2D.1000300@broadcom.com>
 <20130726184702.GW24642@n2100.arm.linux.org.uk>
 <51F2C94F.6020405@broadcom.com>
 <20130726193908.GX24642@n2100.arm.linux.org.uk>
 <20130726222809.GB19469@glitch>
Message-ID: <20130726223829.GY24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 12:28:09AM +0200, Domenico Andreoli wrote:
> I've got the point but didn't fully understand why would be so wrong to
> walk one more subdir even if nothing is going to be built.

Consider what would happen if we decended the 61 mach- subdirectories
on every build run when only one was really required.  Even though
kbuild tries to be fast, there's still a non-zero amount of time
involved with finding out there's nothing to be done - and you
will still end up generating a built-in.o file even though there's
no other objects, which will then also be included in the final
link - again, adding to the work which has to be done.
