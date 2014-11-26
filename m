From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 26 Nov 2014 20:22:03 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141126191027.GM2817@atomide.com>
References: <20141027200008.GR2560@atomide.com> <201411261957.08860@pali>
 <20141126191027.GM2817@atomide.com>
Message-ID: <201411262022.03338@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 20:10:28 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [141126 10:59]:
> > On Wednesday 26 November 2014 19:19:35 Tony Lindgren wrote:
> > > Maybe Pali can try to restart that discussion? To me it
> > > seems the /proc/cpuinfo should be the same as it's a user
> > > interface. Sorry forgot the details of the previous
> > > discussion..
> > 
> > Yes, two days ago I again wrote emails about this problem...
> > 
> > E.g. one of them, see: https://lkml.org/lkml/2014/11/24/774
> > 
> > > And with which app was that? Sorry I forgot..
> > 
> > More applications/libraries for N900 which running on Maemo
> > 5 system. Some of them are Nokia proprietary, some of them
> > are open source and some are mine.
> > 
> > Basically problem is that non DT boot provides this info in
> > /proc/cpuinfo:
> > 
> > Hardware        : Nokia RX-51 board
> > Revision        : 0012
> > 
> > New DT boot provides this:
> > 
> > Hardware        : Generic OMAP3 (Flattened Device Tree)
> > Revision        : 0000
> 
> Oh you can easily fix that by adding a n900 specific
> DT_MACHINE_START entry to mach-omap2/board-generic.c.
> 

I would like to see some solution which does not depend on 
distributing addition patch which will not be in mainline 
kernel...

For this problem I proposed patch (which was rejected): 
https://lkml.org/lkml/2014/6/18/853

Basically Hardware is used to check if application is running on 
Nokia N900 or not. Also entry from Hardware is appended to Web 
browser user agent and some internet services using it as 
identifier (N900 device).

> The revision entry you can populate too in pdata-quirks.c,
> or maybe add something generic to populate it based on the
> cmdline or a dts entry as I believe that comes from the
> legacy ATAGs. I think that's just the system_rev or some
> other *_rev global in the kernel.
> 
> Regards,
> 
> Tony

Revision comes from bootloader (via ATAG) and it is HW revision 
of N900 device. It cannot be hardcoded into kernel or DTS as it 
it depends on HW.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/f8e4ee02/attachment.sig>
