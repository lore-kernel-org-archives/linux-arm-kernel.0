From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 12 Feb 2011 23:29:29 +0530
Subject: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
	cause data corruption
In-Reply-To: <AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com><1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com>
Message-ID: <13596bec9184b117d6a1d02da8e017bf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Andrei Warkentin [mailto:andreiw at motorola.com]
> Sent: Saturday, February 12, 2011 11:20 PM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; khilman at ti.com; tony at atomide.com;
> linux-arm-kernel at lists.infradead.org; Catalin Marinas
> Subject: Re: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
> operation can cause data corruption
>
[....]

>
> Can these PL310 errata fixes be made more generic? PL310 is present
> in
> non-OMAP platforms too, which lack the TI hypervisor. And these
> platforms might have the same PL310 rev, and suffer the same
> glitches.
> While ideally there is some kind of hypervisor_ops to modify the
> protected register, at the very least there should be the generic
> debug_write handling the  "I  can write all PL310 regs" case. If
> you're interested I have a patch someplace that tried to do this,
> hopefully I can still find it.

They are kind of generic. If you look at it, the only change
Which is arch specific is the implementation of "debug_writel" function.
Today this code is not in generic PL310 code, but
OMAP specific.

May be we can make this as exported function pointer, which
arch's can populate.

Will that work for you ?

Regards,
Santosh
