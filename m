From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Jun 2012 04:28:34 -0700
Subject: [PATCH v3] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
In-Reply-To: <1336729242-16168-1-git-send-email-govindraj.raja@ti.com>
References: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com>
 <1336729242-16168-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <20120605112834.GO12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Govindraj.R <govindraj.raja@ti.com> [120511 02:45]:
> From: "Govindraj.R" <govindraj.raja@ti.com>
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
>  #else
> -static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
> +static void __init omap_serial_check_wakeup(struct omap_board_data *bdata
> +		struct omap_uart_state *uart) {}
>  #endif

There's a comma missing here that breaks CONFIG_OMAP_MUX is not set here   ^^^.
I've updated the patch to add it.

Tony
