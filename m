From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 27 Jul 2018 09:45:51 -0700
Subject: [PATCH v3 2/2] clk: meson: add sub MMC clock controller driver
In-Reply-To: <153270970080.48062.18399022907046343950@swboyd.mtv.corp.google.com>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
 <20180712211244.11428-3-yixun.lan@amlogic.com>
 <153261840298.48062.2497103873681297587@swboyd.mtv.corp.google.com>
 <f52d2511-bab7-2c39-cea7-8702e27d2ef8@amlogic.com>
 <153270970080.48062.18399022907046343950@swboyd.mtv.corp.google.com>
Message-ID: <153270995155.48062.4302847978258086624@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2018-07-27 09:41:40)
> Quoting Yixun Lan (2018-07-27 07:52:23)
> > HI Stephen:
> > 
> > On 07/26/2018 11:20 PM, Stephen Boyd wrote:
> > > Quoting Yixun Lan (2018-07-12 14:12:44)
> > >> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> > >> new file mode 100644
> > >> index 000000000000..36c4c7cd69a6
> > >> --- /dev/null
> > >> +++ b/drivers/clk/meson/mmc-clkc.c
> > >> @@ -0,0 +1,367 @@
> > >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > >> +/*
> > >> + * Amlogic Meson MMC Sub Clock Controller Driver
> > >> + *
> > >> + * Copyright (c) 2017 Baylibre SAS.
> > >> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> > >> + *
> > >> + * Copyright (c) 2018 Amlogic, inc.
> > >> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> > >> + */
> > >> +
> > >> +#include <linux/clk.h>
> > > 
> > > Is this include used?
> > > 
> > this is needed by clk_get_rate()
> > see drivers/clk/meson/mmc-clkc.c:204
> 
> Hmm ok. That's unfortunate.

You should be able to read the hardware to figure out the clk frequency?
This may be a sign that the phase clk_ops are bad and should be passing
in the frequency of the parent clk to the op so that phase can be
calculated. Jerome?
