From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Nov 2016 17:48:43 +0800
Subject: [BUG] pinctrl: sunxi: sunxi-pinctrl fail to load with
 CONFIG_DEBUG_TEST_DRIVER_REMOVE
In-Reply-To: <20161107081832.GA23580@Red>
References: <20161107081832.GA23580@Red>
Message-ID: <CAGb2v65MHBUwWzcqwPYDtFNxgGnMECUMjHdZNOv6YPP4HVzwTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 7, 2016 at 4:18 PM, LABBE Corentin
<clabbe.montjoie@gmail.com> wrote:
> Hello
>
> With CONFIG_DEBUG_TEST_DRIVER_REMOVE=y pinctrl-sunxi fail to load on the second try.
>
> [    3.900061] sun8i-h3-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
> [    3.916251] gpio gpiochip1: GPIO integer space overlap, cannot add chip
> [    3.923016] gpiochip_add_data: GPIOs 0..223 (1c20800.pinctrl) failed to register
> [    3.931099] sun8i-h3-pinctrl: probe of 1c20800.pinctrl failed with error -16
> [    3.944709] sun8i-h3-r-pinctrl 1f02c00.pinctrl: initialized sunXi PIO driver
> [    3.960796] gpio gpiochip2: GPIO integer space overlap, cannot add chip
> [    3.967594] gpiochip_add_data: GPIOs 352..383 (1f02c00.pinctrl) failed to register
> [    3.975633] sun8i-h3-r-pinctrl: probe of 1f02c00.pinctrl failed with error -16
>
> Without it, all subsequent drivers fail to load.
> Tested on Orange PI PC board.

I don't think the pinctrl drivers were designed to be removed.
And I thought the lack of a .remove callback in the driver blocks
the core from removing the device? Maybe I remember wrong...

ChenYu

>
> Regards
