From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Nov 2016 17:58:42 +0800
Subject: [BUG] pinctrl: sunxi: sunxi-pinctrl fail to load with
 CONFIG_DEBUG_TEST_DRIVER_REMOVE
In-Reply-To: <20161107095612.ih5ns24m2qiwujy5@lukather>
References: <20161107081832.GA23580@Red>
 <CAGb2v65MHBUwWzcqwPYDtFNxgGnMECUMjHdZNOv6YPP4HVzwTw@mail.gmail.com>
 <20161107095612.ih5ns24m2qiwujy5@lukather>
Message-ID: <CAGb2v657vYjJcO5EmSw2veuxUfDpps-oDysi1GKggx5VsHwSyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 7, 2016 at 5:56 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Nov 07, 2016 at 05:48:43PM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Mon, Nov 7, 2016 at 4:18 PM, LABBE Corentin
>> <clabbe.montjoie@gmail.com> wrote:
>> > Hello
>> >
>> > With CONFIG_DEBUG_TEST_DRIVER_REMOVE=y pinctrl-sunxi fail to load on the second try.
>> >
>> > [    3.900061] sun8i-h3-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
>> > [    3.916251] gpio gpiochip1: GPIO integer space overlap, cannot add chip
>> > [    3.923016] gpiochip_add_data: GPIOs 0..223 (1c20800.pinctrl) failed to register
>> > [    3.931099] sun8i-h3-pinctrl: probe of 1c20800.pinctrl failed with error -16
>> > [    3.944709] sun8i-h3-r-pinctrl 1f02c00.pinctrl: initialized sunXi PIO driver
>> > [    3.960796] gpio gpiochip2: GPIO integer space overlap, cannot add chip
>> > [    3.967594] gpiochip_add_data: GPIOs 352..383 (1f02c00.pinctrl) failed to register
>> > [    3.975633] sun8i-h3-r-pinctrl: probe of 1f02c00.pinctrl failed with error -16
>> >
>> > Without it, all subsequent drivers fail to load.
>> > Tested on Orange PI PC board.
>>
>> I don't think the pinctrl drivers were designed to be removed.
>> And I thought the lack of a .remove callback in the driver blocks
>> the core from removing the device? Maybe I remember wrong...
>
> Using a builtin_platform_driver should be enough to prevent it to be
> removed.

Labbe, can you test it again on linux-next? Or at least with this patch

    0c8c6ba00cbf pinctrl: sunxi: make bool drivers explicitly non-modular

from linux-pinctrl applied. This should fix it.

ChenYu
