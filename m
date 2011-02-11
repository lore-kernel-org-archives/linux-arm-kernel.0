From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Feb 2011 17:37:04 +0530
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <20110211115853.GC23404@n2100.arm.linux.org.uk>
References: <20110206191117.GA17808@n2100.arm.linux.org.uk><E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk><20110207120103.GC31929@n2100.arm.linux.org.uk><20110207121052.GD31929@n2100.arm.linux.org.uk><AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com><20110207133457.GE31929@n2100.arm.linux.org.uk><AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com><20110207141734.GG31929@n2100.arm.linux.org.uk><AANLkTimCtaSZ=CHT5snWZ496_bi4sH=0LU7vJ-Jfh=dP@mail.gmail.com>
	<20110211115853.GC23404@n2100.arm.linux.org.uk>
Message-ID: <998315b4ab88b66cc0e32e73d10a0015@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Russell King -
> ARM Linux
> Sent: Friday, February 11, 2011 5:29 PM
> To: Colin Cross; Santosh Shilimkar; Kukjin Kim
> Cc: saeed bishara; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume
> support
>
> On Wed, Feb 09, 2011 at 07:15:25PM -0800, Colin Cross wrote:
> > The diagnostic register also needs to be saved to keep the errata
> bits
> > set in __v7_setup.
>
> Saving I've no problem with.  Restoring gets hairy with kernels
> running
> in non-secure mode, as we can't just write the register - we don't
> know
> whether we are running in secure or non-secure mode.  A write to the
> register in NS mode will crash.
>
> Santosh: is the diagnostic register on OMAP4 re-initialized by the
> secure code on OMAP?
>
There is a Monitor secure API, needs to be called from non-secure
software to set this diagnostic registers in resume path.

Regards,
Santosh
