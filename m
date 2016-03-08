From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Mar 2016 16:03:21 +0700
Subject: [PATCH 2/2] pinctrl: sunxi: Change mux setting on PI irq pins
In-Reply-To: <bd99b2fb93c4c7da52ceb70a43dafded76fff974.1456698862.git.henry@nitronetworks.nl>
References: <cover.1456698862.git.henry@nitronetworks.nl>
 <bd99b2fb93c4c7da52ceb70a43dafded76fff974.1456698862.git.henry@nitronetworks.nl>
Message-ID: <CACRpkdZN8KcD_WUL_UDHZT5N6Q--SpHb+GEr52+GEAanBU+rWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 6:13 AM, Henry Paulissen <henry@nitronetworks.nl> wrote:

> While I was testing irq's on the cubietruck I found a couple of
> not working irq pins. Further diving into the problem it opened
> up a mess called "manual".
>
> This so called manual (A20 user manual v1.3 dated 2014-10-10) says:
>
> Pin overview:
>     Page 237:       EINT26 is on mux 5.
>     Page 288:       EINT26 is on mux 6.
>
> The manual is so contradicting that further tests had to be made
> to see which of the 2 statements where correct.
>
> This patch is based on actual outcome of these tests and not what
> the manual says.
>
> Test procedure used:
>
> Connect a 1 pulse per second (GPS) line to the pin.
>
> echo pin### > /sys/class/gpio/export
> echo in > /sys/class/gpio/gpio###/direction
> echo rising > /sys/class/gpio/gpio###/edge
>
> Check /proc/interrupts if a irq was attached and if irq's where
> received.
>
> Hardware used:
> Henry Paulissen: Cubietruck
> Andere Przywara: BananaPi M1
>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Henry Paulissen <henry@nitronetworks.nl>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
