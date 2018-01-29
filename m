From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Jan 2018 11:31:15 -0600
Subject: [PATCH 4/4] clk: imx: add clock driver for i.MX8MQ CCM
In-Reply-To: <20180117182950.26460-4-l.stach@pengutronix.de>
References: <20180117182950.26460-1-l.stach@pengutronix.de>
 <20180117182950.26460-4-l.stach@pengutronix.de>
Message-ID: <20180129173115.hy6dmnj2m2mdyznp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 07:29:50PM +0100, Lucas Stach wrote:
> Add driver for the Clock Control Module found on i.MX8MQ.
> 
> This is largely based on the downstream driver from Anson Huang and
> Bai Ping at NXP, with only some small adaptions to mainline from me.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/clk/imx/Makefile                 |   1 +
>  drivers/clk/imx/clk-imx8mq.c             | 861 +++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h                    |  43 ++
>  include/dt-bindings/clock/imx8mq-clock.h | 632 +++++++++++++++++++++++
>  4 files changed, 1537 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imx8mq.c
>  create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

> diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings/clock/imx8mq-clock.h
> new file mode 100644
> index 000000000000..9932b52452cb
> --- /dev/null
> +++ b/include/dt-bindings/clock/imx8mq-clock.h
> @@ -0,0 +1,632 @@
> +/*
> + * Copyright 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017 NXP
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Use SPDX tag.
