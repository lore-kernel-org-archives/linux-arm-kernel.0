From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 28 Nov 2016 12:13:31 +0100
Subject: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
In-Reply-To: <8359307d-5f44-3db9-aae1-eb1fe8e1141d@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com>
 <3cd05a26-d340-476e-bab1-8be9d5446f47@marvell.com>
 <CAPDyKFrskyZvMwhmj8ioyaowU8GL5=d-6ipGQcmmig_a9E9AQQ@mail.gmail.com>
 <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com>
 <8359307d-5f44-3db9-aae1-eb1fe8e1141d@marvell.com>
Message-ID: <CAPDyKFo3ezYOywtSZ8GGQ1XK9KPsxCgQNbaiz45EVgbgtnUxjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>     As you suggest, I replace mmc_wait_for_cmd() with mmc_send_tuning(), to
>     send commands for testing current sampling point set in our host PHY.
>
>     According to my test result, it shows that mmc_send_tuning() can only support
>     tuning command (CMD21/CMD19).
>     As a result, we cannot use mmc_send_tuning() when card is in the speed modes
>     which doesn't support tuning, such as eMMC HS SDR, eMMC HS DRR and
>     SD SDR 12/SDR25/DDR50. Card will not response to tuning commands in those
>     speed modes.
>
>     Could you please provide suggestions for the speed mode in which tuning is
>     not available?
>

Normally the mmc host driver shouldn't have to care about what the
card supports, as that is the responsibility of the mmc core to
manage.

The host should only need to implement the ->execute_tuning() ops,
which gets called when the card supports tuning (CMD19/21). Does it
make sense?

Kind regards
Uffe
