From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Mar 2014 14:26:07 -0700
Subject: [PATCH 3/7] ARM: zynq: Hang iomapped slcr address on device_node
In-Reply-To: <ae4583176ee5c9d8a8a2d53c000b86711eb66287.1389018985.git.michal.simek@xilinx.com>
References: <cover.1389018985.git.michal.simek@xilinx.com>
 <ae4583176ee5c9d8a8a2d53c000b86711eb66287.1389018985.git.michal.simek@xilinx.com>
Message-ID: <CAOesGMjzNWXs26T2ZxGi=ASk2ETk0P5re-QdfwGT6O8M=5tDkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 6, 2014 at 6:36 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>
> For later usage by zynq clk driver.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  arch/arm/mach-zynq/slcr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
> index 9746de7..2891dcf 100644
> --- a/arch/arm/mach-zynq/slcr.c
> +++ b/arch/arm/mach-zynq/slcr.c
> @@ -121,6 +121,8 @@ int __init zynq_early_slcr_init(void)
>                 BUG();
>         }
>
> +       np->data = (__force void *)zynq_slcr_base;


This is quite unusual, we normally remap again if needed. Is there a
reason you can't just have the driver request the resource and map it
like most other ones do?


-Olof
