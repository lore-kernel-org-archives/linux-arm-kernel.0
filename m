From: redhatter@gentoo.org (Stuart Longland)
Date: Tue, 18 May 2010 17:51:09 +1000
Subject: i.MX27 Clock sources
Message-ID: <20100518075109.GC1749@www.longlandclan.yi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
	Firstly, I'm new to this list, so hopefully this is not offtopic
-- if it is, I'm happy to be redirected.  I'm working on a device based
on the Freescale i.MX27 MCU; specifically, a Ka-Ro TX27-4030 module.
I'm using Ka-Ro's Linux kernel; although I'm looking into whether a port
of their patches to the current Linux kernel is feasible -- but that's
another story.

	For our application, it is necessary to interface this device to
a Texas Instruments TLV320AIC3204 CODEC.  The i.MX27 provides the clock
via SSI3_CLK, and communicates using I?S and I?C.  I understand that the
clock divider for the SSIs is driven from either MPLL or SPLL; but what
I'm not certain on is where those are configured in the Linux kernel, or
what the implications are for tinkering with these.

	Ideally I'd like to adjust MPLL/SPLL and/or the SSI clocks so
that the clock rate is some multiple of the I?S bit rate.  So far I can
get it close; but not close enough.  Does anyone have any pointers as to
where I can look in the Linux kernel for this information?

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
