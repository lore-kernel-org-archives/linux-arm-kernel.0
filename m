From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Dec 2016 16:27:22 +0000
Subject: [PATCH] arm: dt: Initialize boot_command_line from
 CONFIG_CMDLINE in case DT does not provide /chosen/bootargs
In-Reply-To: <201612161713.46770@pali>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
 <1b779429-8ce4-a49b-38e4-573b28a7c05f@osg.samsung.com>
 <20161216154029.GF4920@atomide.com> <201612161713.46770@pali>
Message-ID: <20161216162722.GN14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 05:13:46PM +0100, Pali Roh?r wrote:
> On Friday 16 December 2016 16:40:30 Tony Lindgren wrote:
> > * Javier Martinez Canillas <javier@osg.samsung.com> [161216 04:54]:
> > > On 12/16/2016 09:48 AM, Pali Roh?r wrote:
> > > >>> saying that it cause problems which need to be properly fixed.
> > > >>> And if fixing them is harder and will take more time, then
> > > >>> correct option is to revert 008a2ebcd677 due to breaking
> > > >>> support for more devices.
> > > >> 
> > > >> If you think that others boards may have the same issue, then
> > > >> you could add an empty chosen node to omap3.dtsi. As I said I
> > > >> think that in practice this will only be needed for the
> > > >> machines using NOLO but you are right that in theory you could
> > > >> boot them using other bootloaders and having an empty node
> > > >> doesn't cause any harm anyway.
> > > > 
> > > > Should not be it part of any arm board? IIRC ATAG support is (or
> > > > was) not omap3 specified.
> > > 
> > > Yes, but you were talking about commit 008a2ebcd677 which only
> > > removed skeleton.dtsi usage for OMAP3 boards. The same can be done
> > > for other SoCs in its top level dtsi for the SoC family of course.
> > 
> > Yeah probaby best to add the empty chosen node to the ones that had
> > skeleton.dtsi removed.
> 
> Ok. But still I think that it should be added globally to all arm board 
> which can be booted by ATAG bootloader.

+1

> > And I think the code should print a warning if no chosen node is
> > found?
> 
> Which code? Decompressor? Yes, it should but I do not know if at that 
> time is (serial) console usable...

It isn't in multiplatform situations.  Best if the kernel prints it,
because then it can be logged.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
