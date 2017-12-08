From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Fri, 8 Dec 2017 14:43:16 +0100
Subject: [PATCH net-next v4 1/2] net: add support for Cavium PTP
 coprocessor
In-Reply-To: <20171208103442.19354-2-aleksey.makarov@cavium.com>
References: <20171208103442.19354-1-aleksey.makarov@cavium.com>
 <20171208103442.19354-2-aleksey.makarov@cavium.com>
Message-ID: <CAOFm3uFMzz-pYhEXOWFi7RGgBb6+d5LoJCtcsF0cY=-3kCO6xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Aleksey, Dear Radoslaw,

On Fri, Dec 8, 2017 at 11:34 AM, Aleksey Makarov
<aleksey.makarov@cavium.com> wrote:
> From: Radoslaw Biernacki <rad@semihalf.com>
>
> This patch adds support for the Precision Time Protocol
> Clocks and Timestamping hardware found on Cavium ThunderX
> processors.
>
> Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
[]
> --- /dev/null
> +++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
> @@ -0,0 +1,334 @@
> +/*
> + * cavium_ptp.c - PTP 1588 clock on Cavium hardware
> + *
> + * Copyright (c) 2003-2015, 2017 Cavium, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.


Have you considered using the new SPDX ids instead of this fine legalese? e.g.:

// SPDX-License-Identifier: GPL-2.0

This is much shorter and neater (unless you are a legalese lover of
course!)... Check also Thomas doc patches and Linus comments on why he
prefers the C++ comment style for these.

And even better, what about this more compact form? I am a big fan of the
C++ style comments for these (and so is Linus):

// SPDX-License-Identifier: GPL-2.0
// Copyright (c) 2003-2015, 2017 Cavium, Inc.
// cavium_ptp.c - PTP 1588 clock on Cavium hardware


> + *
> + * This file may also be available under a different license from Cavium.
> + * Contact Cavium, Inc. for more information
> + */

I am not so sure that the kernel source tree is the right place for
commercial advertisement... I mean, this is a fine statement to put on
your company web site, but who reads this code: you and I.... do we
care seriously about this? Anyone who uses your hardware would likely
have some other kind of arrangements with your company anyway, making
this sentence moot in all cases. Therefore I tend to think this is
just a noisy distraction from your otherwise fine code contributions:
It does not come out to me as kernically-correct ;)

So can you consider removing this fine marketing statement from this
and other Cavium past, present and future contributions? That would be
much appreciated! (and while you are at it, using SPDX ids throughout
would give you good karma extra points)

PS: Now, if this "different license" of yours is a fine BSD or MIT,
you could use instead this SPDX shorthand to the same effect without
turning the kernel code into a billboard:

// SPDX-License-Identifier: (GPL-2.0 OR MIT)

-- 
Cordially
Philippe Ombredanne, your ad-sensitive licensing scruffy
