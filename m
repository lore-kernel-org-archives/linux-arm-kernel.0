From: rric@kernel.org (Robert Richter)
Date: Fri, 1 Aug 2014 12:25:35 +0200
Subject: [PATCH 2/5] arm64, thunder: Add initial dts for Cavium Thunder SoC
In-Reply-To: <20140730154626.GD20162@leverpostej>
References: <1406732794-20920-1-git-send-email-rric@kernel.org>
 <1406732794-20920-3-git-send-email-rric@kernel.org>
 <20140730154626.GD20162@leverpostej>
Message-ID: <20140801102535.GX4703@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On 30.07.14 16:46:26, Mark Rutland wrote:

> > diff --git a/arch/arm64/boot/dts/thunder-88xx.dts b/arch/arm64/boot/dts/thunder-88xx.dts
> > new file mode 100644
> > index 000000000000..4cf20ac9138b
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/thunder-88xx.dts
> > @@ -0,0 +1,387 @@
> > +/*
> > + * Cavium Thunder DTS file
> > + *
> > + * Copyright (C) 2013, Cavium Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + */
> > +/dts-v1/;
> > +
> > +/* Reserving first 12MB of DDR for firmware */
> > +/memreserve/ 0x00000000 0x00c00000;
> 
> What exactly is this memreserve intended to protect at runtime?
> 
> The only item of runtime firmware I see in use below is PSCI on the
> secure side.
> 
> How is the kernel booted on this platform? UEFI?

We checked this and it seems we don't need memreserve. Mem is either
not visible to the kernel (ATF) or it is marked reserved by firmware
(UEFI). At the moment we don't see any other use cases. We will remove
this memreserve.

Thanks,

-Robert
