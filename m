From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 23 Feb 2010 12:49:30 +0530
Subject: [PATCH 1/9] omap3/4: uart: fix full-fifo write abort
In-Reply-To: <20100222230712.GB18786@atomide.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C417FA42@dbde02.ent.ti.com>
	<20100222213932.GW18786@atomide.com>
	<20100222230712.GB18786@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C42E1174@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Tuesday, February 23, 2010 4:37 AM
> To: Shilimkar, Santosh
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Woodruff, Richard; Ghorai,
> Sukumar
> Subject: Re: [PATCH 1/9] omap3/4: uart: fix full-fifo write abort
> 
> * Tony Lindgren <tony@atomide.com> [100222 13:35]:
> > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100218 21:22]:
> > > Bye the way just to add bit more clarity, this patch addresses TX
> > > hardware restriction in the new UART IP used on omap3630 and omap4430.
> > > First part of the fix for RX is already in mainline,
> > > Commit: "ce13d4716a276f4331d78ba28a5093a63822ab95"
> > >
> > > More details on this thread are here.
> > > http://www.mail-archive.com/linux-omap at vger.kernel.org/msg19447.html
> >
> > Thanks, I've updated the comments for this patch with the link above
> > and added the whole series into omap for-next.
> 
> Except patches 8 and 9 as they break compile for mach-omap1
> and need to be updated.
>
Patch 8 is alright and doesn't break omap1. Patch 7 and patch 9 needs update to fix
the mach-omap1 build issue by moving irqs-44xx.h header file to plat-omap directory.
Attached are updated 7 and 9.
Build tested for omap1 (omap_generic_1710_defconfig and omap_h2_1610_defconfig) and boot
tested with omap3_defconfig on omap4430sdp board.

Thanks!!

Regards,
Santosh


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0007-omap4-Add-auto-generated-irq-and-dma-headers.patch
Type: application/octet-stream
Size: 15322 bytes
Desc: 0007-omap4-Add-auto-generated-irq-and-dma-headers.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100223/018766ec/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0009-omap4-Use-irq-line-defines-from-irq-44xx.h.patch
Type: application/octet-stream
Size: 11266 bytes
Desc: 0009-omap4-Use-irq-line-defines-from-irq-44xx.h.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100223/018766ec/attachment-0003.obj>
