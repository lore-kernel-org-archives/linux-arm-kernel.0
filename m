From: khilman@ti.com (Kevin Hilman)
Date: Mon, 05 Mar 2012 12:00:16 -0800
Subject: [PATCH] omap3_beagle: Init only uart3 used for console
In-Reply-To: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
 (Govindraj R.'s message of "Mon, 5 Mar 2012 16:42:32 +0530")
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <87399mkecv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> On beagle some of uart mux lines are used for other
> purpose so init only uart3.

OK, but you should also be clear that this patch is effectively
disabling all UARTS (except UART3) by defatul, which I'm not sure all
Beagle users will be happy about.

> Uart2 rx line clashes with gpio_147 used for usb ehci
> phy reset. Initializing uart2 pad_mux lines can break
> ehci module on beagle xm.
> (gpio_147 is available on uart2_rx in mode4 reference 
> mux34xx.c -> uart2_rx.gpio_147)

As Koen mentioned, this conflict only exists on certain boards, so
you should be clear that this is just an example.

> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Robert Nelson <robertcnelson@gmail.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

[...]

> +
> +static inline void board_serial_init(void)

Should be __init

[...]

> +static inline void board_serial_init(void)

here too.

Kevin
