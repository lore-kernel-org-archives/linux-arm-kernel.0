From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Mon, 25 Oct 2010 11:04:57 +0530
Subject: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
	read/write
In-Reply-To: <1287964909.5674.22.camel@macbook.infradead.org>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	<1285063280-4057-10-git-send-email-manjugk@ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C014F74831E@dlee02.ent.ti.com>
	<20101007185630.GA26435@n2100.arm.linux.org.uk>
	<4CAE2475.4090607@ti.com>
	<1287964909.5674.22.camel@macbook.infradead.org>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBDDEFAA@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

> -----Original Message-----
> From: David Woodhouse [mailto:dwmw2 at infradead.org] 
> Sent: Monday, October 25, 2010 5:32 AM
> To: Menon, Nishanth
> Cc: Russell King - ARM Linux; G, Manjunath Kondaiah; 
> linux-omap at vger.kernel.org; linux-mtd at lists.infradead.org; 
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 09/10] OMAP2/3: Convert write/read 
> functions to raw read/write
> 
> On Thu, 2010-10-07 at 14:50 -0500, Nishanth Menon wrote:
> > my comment being that by moving {read,write}[wlb] to __raw versions 
> > dont solve the real issue of namespace here. fix should be in 
> > arch/arm/include/asm/io.h IMHO. so that there are no 
> overlaps as this.
> 
> Indeed. This patch is complete nonsense.

nonsense? There are two types of fixes proposed to fix these sparse warnings.
1. with this patch
2. fixing in io.h
https://patchwork.kernel.org/patch/250171/

1st option is already merged with 2.6.37 merge window.

If 2 get accepted, all __raw_read/write will get replaced with readl/writel.

Apart from those two, do you have any other alternate idea to fix these sparse warnings?

-Manjunath
