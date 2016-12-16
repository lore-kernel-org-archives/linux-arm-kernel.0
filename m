From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 16 Dec 2016 17:13:46 +0100
Subject: [PATCH] arm: dt: Initialize boot_command_line from CONFIG_CMDLINE
 in case DT does not provide /chosen/bootargs
In-Reply-To: <20161216154029.GF4920@atomide.com>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
 <1b779429-8ce4-a49b-38e4-573b28a7c05f@osg.samsung.com>
 <20161216154029.GF4920@atomide.com>
Message-ID: <201612161713.46770@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 December 2016 16:40:30 Tony Lindgren wrote:
> * Javier Martinez Canillas <javier@osg.samsung.com> [161216 04:54]:
> > On 12/16/2016 09:48 AM, Pali Roh?r wrote:
> > >>> saying that it cause problems which need to be properly fixed.
> > >>> And if fixing them is harder and will take more time, then
> > >>> correct option is to revert 008a2ebcd677 due to breaking
> > >>> support for more devices.
> > >> 
> > >> If you think that others boards may have the same issue, then
> > >> you could add an empty chosen node to omap3.dtsi. As I said I
> > >> think that in practice this will only be needed for the
> > >> machines using NOLO but you are right that in theory you could
> > >> boot them using other bootloaders and having an empty node
> > >> doesn't cause any harm anyway.
> > > 
> > > Should not be it part of any arm board? IIRC ATAG support is (or
> > > was) not omap3 specified.
> > 
> > Yes, but you were talking about commit 008a2ebcd677 which only
> > removed skeleton.dtsi usage for OMAP3 boards. The same can be done
> > for other SoCs in its top level dtsi for the SoC family of course.
> 
> Yeah probaby best to add the empty chosen node to the ones that had
> skeleton.dtsi removed.

Ok. But still I think that it should be added globally to all arm board 
which can be booted by ATAG bootloader.

> And I think the code should print a warning if no chosen node is
> found?

Which code? Decompressor? Yes, it should but I do not know if at that 
time is (serial) console usable...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161216/997b8f16/attachment-0001.sig>
