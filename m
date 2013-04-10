From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Apr 2013 20:06:03 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410190052.GC18196@blackmetal.musicnaut.iki.fi>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304101307280.17375@syhkavp.arg>
 <20130410190052.GC18196@blackmetal.musicnaut.iki.fi>
Message-ID: <20130410190603.GL14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 10:00:52PM +0300, Aaro Koskinen wrote:
> Menuconfig mentions under "Floating point emulation" that "At least one
> emulation must be selected". But if I compile my OS with EABI userspace
> soft-float I guess I won't actually need to select any emulation,
> or have I missed something? (I just checked my configs, and at least
> on Kirkwood/openrd I have been already running without any emulation,
> so I guess the help text is wrong?)

Well, it's that way to stop us being flooded with "why does my kernel
stop after mounting the rootfs" questions.  Maybe that can be changed
now, it depends whether we're absolutely certain that there's no FPA
instructions in any binary being run on EABI-only userspaces.

Given that such instructions will still be emulated if they're
encountered, I think we need to have another option to at least report
an error via the kernel message log should a FPA instruction be trapped.
