From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Dec 2016 07:40:30 -0800
Subject: [PATCH] arm: dt: Initialize boot_command_line from
 CONFIG_CMDLINE in case DT does not provide /chosen/bootargs
In-Reply-To: <1b779429-8ce4-a49b-38e4-573b28a7c05f@osg.samsung.com>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
 <201612161332.36406@pali>
 <5c56e769-76be-295e-b655-8431dde35370@osg.samsung.com>
 <201612161348.35917@pali>
 <1b779429-8ce4-a49b-38e4-573b28a7c05f@osg.samsung.com>
Message-ID: <20161216154029.GF4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@osg.samsung.com> [161216 04:54]:
> On 12/16/2016 09:48 AM, Pali Roh?r wrote:
> >>> saying that it cause problems which need to be properly fixed. And
> >>> if fixing them is harder and will take more time, then correct
> >>> option is to revert 008a2ebcd677 due to breaking support for more
> >>> devices.
> >>
> >> If you think that others boards may have the same issue, then you
> >> could add an empty chosen node to omap3.dtsi. As I said I think that
> >> in practice this will only be needed for the machines using NOLO but
> >> you are right that in theory you could boot them using other
> >> bootloaders and having an empty node doesn't cause any harm anyway.
> > 
> > Should not be it part of any arm board? IIRC ATAG support is (or was) 
> > not omap3 specified.
> >
> 
> Yes, but you were talking about commit 008a2ebcd677 which only removed
> skeleton.dtsi usage for OMAP3 boards. The same can be done for other
> SoCs in its top level dtsi for the SoC family of course.

Yeah probaby best to add the empty chosen node to the ones that had
skeleton.dtsi removed.

And I think the code should print a warning if no chosen node is
found?

Regards,

Tony
