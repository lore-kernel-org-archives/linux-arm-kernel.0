From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Jan 2018 08:29:17 +0100
Subject: [PATCH] ARM: dts: nomadik: add interrupt-parent for clcd
In-Reply-To: <20180115163719.1736753-1-arnd@arndb.de>
References: <20180115163719.1736753-1-arnd@arndb.de>
Message-ID: <CACRpkdYCu57Y0KZGt9c7iM6nwe7qCxK+PcPC5God-rnOoHFt4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 5:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The clcd device is lacking an interrupt-parent property, which makes
> the interrupt unusable and shows up as a warning with the latest
> dtc version:
>
> arch/arm/boot/dts/ste-nomadik-s8815.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd at 10120000
> arch/arm/boot/dts/ste-nomadik-nhk15.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd at 10120000
>
> I looked up the old board files and found that this interrupt has
> the same irqchip as all the other on-chip device, it just needs one
> extra line.
>
> Fixes: 17470b7da11c ("ARM: dts: add the CLCD LCD display to the NHK15")
> Cc: stable at vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Sorry for not getting to fixing this myself quickly enough.

Yours,
Linus Walleij
