From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Fri, 29 Oct 2010 14:17:07 +0300
Subject: [RFC PATCH 1/2] Gemini: create platform device for ethernet in
	Raidsonic IB-4220B
In-Reply-To: <181be0f834f3670249d3c8d7ba1462dab1ece2c1.1288321597.git.mirq-linux@rere.qmqm.pl>
References: <cover.1288321597.git.mirq-linux@rere.qmqm.pl>
	<181be0f834f3670249d3c8d7ba1462dab1ece2c1.1288321597.git.mirq-linux@rere.qmqm.pl>
Message-ID: <AANLkTik+r8r-pywpFYfwrZX2bTjgAVd1rwvoTi7ttq3B@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/29 Micha? Miros?aw <mirq-linux@rere.qmqm.pl>:
> This is cherry-picked from:
>
> git://git.berlios.de/gemini-board ib4220
>
> Code by Paulius Zaleckas <paulius.zaleckas@gmail.com>
> and Janos Laube <janos.dev@gmail.com>.
>
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> ---
>
> ?arch/arm/mach-gemini/board-nas4220b.c ? ?| ? 53 ++++++++++++++++++++++++++++++
> ?arch/arm/mach-gemini/common.h ? ? ? ? ? ?| ? ?2 +
> ?arch/arm/mach-gemini/devices.c ? ? ? ? ? | ? 52 +++++++++++++++++++++++++++++
> ?arch/arm/mach-gemini/include/mach/gmac.h | ? 21 ++++++++++++
> ?4 files changed, 128 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-gemini/include/mach/gmac.h
>
[...]
> diff --git a/arch/arm/mach-gemini/include/mach/gmac.h b/arch/arm/mach-gemini/include/mach/gmac.h
> new file mode 100644
> index 0000000..c6eeacc
> --- /dev/null
> +++ b/arch/arm/mach-gemini/include/mach/gmac.h
> @@ -0,0 +1,21 @@
> +/*
> + * Gemini GMAC specific defines
> + *
> + * Copyright (C) 2008, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>

This e-mail is dead. Please change it to gmail one.

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#ifndef __MACH_GMAC_H__
> +#define __MACH_GMAC_H__
> +
> +#include <linux/phy.h>
> +
> +struct gemini_gmac_platform_data {
> + ? ? ? char *bus_id[2]; /* NULL means that this port is not used */
> + ? ? ? phy_interface_t interface[2];
> +};
> +
> +#endif /* __MACH_GMAC_H__ */
> --
> 1.7.1
>
>
