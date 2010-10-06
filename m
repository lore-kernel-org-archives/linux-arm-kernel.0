From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 6 Oct 2010 10:42:30 +0530
Subject: [PATCH 6/6] ARM: l2x0: Optimise the range based operations
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFEA29@dbde02.ent.ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
	<1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
	<1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
	<1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
	<1283846243-11600-5-git-send-email-santosh.shilimkar@ti.com>
	<1283846243-11600-6-git-send-email-santosh.shilimkar@ti.com>
	<1283846243-11600-7-git-send-email-santosh.shilimkar@ti.com>
	<20101004212250.GD25241@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFEA29@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CF13239@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Tuesday, October 05, 2010 10:25 AM
> To: Russell King - ARM Linux
> Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
> tglx at linutronix.de; linux-omap at vger.kernel.org
> Subject: RE: [PATCH 6/6] ARM: l2x0: Optimise the range based operations
> 
[....]

> > mmcblk0: error -5 transferring data, sector 1, nr 7, card status 0x900
> > end_request: I/O error, dev mmcblk0, sector 1
> > Buffer I/O error on device mmcblk0, logical block 0
> > port 1 high speed
> >
> > -5 is -EIO, which is a FIFO overrun error, so somehow these changes are
> > causing the CPU or bus accesses to be slower.
> I don't see the problem on OMAP MMC.
> May be some how additional check is making these operations
> touch slower which lead to the under run.
> 
> Will have a look at it again. May for this merge window you can
> drop 'Optimise the range based operations' and 'Determine cache size'
> patches.
> 
The Pl310 cache way size given in KB and 'Determine cache size' missed
to include that. Have updated the git tree with refreshed patch. Here is
the updated patch.. 

----------------------
