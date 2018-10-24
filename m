From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 24 Oct 2018 01:47:57 -0700
Subject: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
In-Reply-To: <ffb2e431-95a2-b5fc-34ee-432e101379a4@amlogic.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
 <153988282130.5275.17528969137837015544@swboyd.mtv.corp.google.com>
 <ffb2e431-95a2-b5fc-34ee-432e101379a4@amlogic.com>
Message-ID: <154037087711.53599.12246779227164118041@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jianxin Pan (2018-10-23 23:29:24)
> On 2018/10/19 1:13, Stephen Boyd wrote:
> > Quoting Jianxin Pan (2018-10-17 22:07:25)
> [...]
> >> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> >> new file mode 100644
> >> index 0000000..5555e3f
> >> --- /dev/null
> >> +++ b/drivers/clk/meson/mmc-clkc.c
> >> @@ -0,0 +1,296 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Amlogic Meson MMC Sub Clock Controller Driver
> >> + *
> >> + * Copyright (c) 2017 Baylibre SAS.
> >> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> >> + *
> >> + * Copyright (c) 2018 Amlogic, inc.
> >> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> >> + */
> >> +
> >> +#include <linux/clk.h>
> > 
> > clk-provider.h instead of clk.h?>
> Maybe we need to keep clk.h
> devm_clk_get() is called in mmc_clkc_register_mux() to get parent in from DTS.
> I'm sorry to miss this in previous reply.

OK. But also include clk-provider.h if provider APIs are being used
here.
