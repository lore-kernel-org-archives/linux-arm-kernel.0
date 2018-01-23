From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 23 Jan 2018 23:55:31 +0800
Subject: [PATCH v3 00/16] add support for AXP813 ADC and battery power
 supply
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v669fXk45X5oKTRXcRSqmOK8GkexGJ747E0S9t0ZdkV9_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 6:33 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The AXP813 PMIC is relatively close to the already supported AXP20X and
> AXP22X. It provides three different power outputs: battery, AC and USB, and
> measures a few different things: temperature, power supply status, current
> current and voltage supplied, maximum current limit, battery capacity, min
> and max voltage limits.
>
> One of its two GPIOs can be used as an ADC.
>
> There are a few differences with AXP20X/AXP22X PMICs though:
>   - a different constant charge current formula,
>   - battery temperature, GPIO0 and battery voltages are the only voltages
>   measurable,
>   - all data are stored on 12 bits (AXP20X/AXP22X had one type of data that
>   was stored on 13 bits),
>   - different scales and offsets,
>   - a different ADC rate formula and register,
>
> This patch series adds support for the PMIC's ADC and battery power supply
> in the existing drivers.
>
> Make the axp20x MFD automatically probe the ADC driver, add the battery
> power supply node in axp81x node and enable it for the TBS A711 since it
> has a soldered battery.
>
> I suggest patches:
>   - 4,5,8,14,15,16 go through Maxime and Chen-Yu's tree,
>   - 1,2,3,7 go through Jonathan's tree,
>   - 6,9,13 go through Lee's tree,
>   - 10,11,12 go through Sebastian's tree,

I think I've reviewed or acked all the patches that haven't been merged.
The different drivers are bound together through the device tree, so the
various patches are safe to go through their respective trees, as Quentin
suggested.

Thanks!
ChenYu
