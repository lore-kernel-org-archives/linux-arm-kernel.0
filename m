From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 26 Nov 2012 10:30:03 +0200
Subject: OMAP build now completely broken in latest arm-soc
In-Reply-To: <CAOesGMiv374Bhpt=Hu5o7E+eUGhX8R4w=1DLgxzzE6ieRUva=w@mail.gmail.com>
References: <20121125093704.GV3332@n2100.arm.linux.org.uk>
 <CAOesGMgvGxfghFbyki7aXE8dVbAA7QQP6nwBKhzHftngGRi0Tw@mail.gmail.com>
 <20121125140701.GW3332@n2100.arm.linux.org.uk>
 <CAOesGMiv374Bhpt=Hu5o7E+eUGhX8R4w=1DLgxzzE6ieRUva=w@mail.gmail.com>
Message-ID: <50B3288B.2080609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-26 08:00, Olof Johansson wrote:

> Tony, Tomi,
> 
> I've taken a stab at resolving these conflicts. They seem to come from
> the cleanups combined with fixes that went upstream, and it seems like
> we want to stick to the arm-soc versions for most of the conflicts.
> 
> I've pushed a merge of 3.7-rc7 into next/cleanup (and for-next) of
> arm-soc, can you please check and see if this is the correct
> resolution? As far as I can tell it is, but a double-check would be
> appreciated.
> 
> Conflicts were in:
> 
>         arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>         arch/arm/plat-omap/i2c.c
>         drivers/video/omap2/dss/dss.c
> 
> The hwmod data was trivial (include files). i2c was a little hairier,
> a revert in mainline -- I presumed we're still good with our arm-soc
> contents so I stuck close to what we had there. The DSS change seems
> to be done completely differently in mainline, i.e. the surrounding
> code is different to what we have in arm-soc today, and it looks like
> the bugfix (3630-specific stuff) is taken care of in the version we
> had. So I stuck to that.
> 
> But, please speak up ASAP if the above doesn't look correct, since we
> want to fix it up before we merge much on top.

The dss.c is resolved correctly.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/d14b7842/attachment.sig>
