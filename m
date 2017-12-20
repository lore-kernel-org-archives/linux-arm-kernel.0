From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Dec 2017 08:44:39 +0100
Subject: [PATCH V2 9/9] ARM: dts: stm32: add initial support of
 stm32mp157c eval board
In-Reply-To: <1513610272-7824-10-git-send-email-ludovic.Barre@st.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
 <1513610272-7824-10-git-send-email-ludovic.Barre@st.com>
Message-ID: <CACRpkdZaEjdGB2k6HdPt1_E0jRXEimEUxT9NmMwMw7OiyeqGLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 4:17 PM, Ludovic Barre <ludovic.Barre@st.com> wrote:

> From: Ludovic Barre <ludovic.barre@st.com>
>
> Add support of stm32mp157c evaluation board (part number: STM32MP157C-EV1)
> split in 2 elements:
> -Daughter board (part number: STM32MP157C-ED1)
>  which includes CPU, memory and power supply
> -Mother board (part number: STM32MP157C-EM1)
>  which includes external peripherals (like display, camera,...)
>  and extension connectors.
>
> The daughter board can run alone, this is why the device tree files
> are split in two layers, for the complete evaluation board (ev1)
> and for the daughter board alone (ed1).
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
(...)
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts

Evaluation boards are important because they set a pattern that customers
will use.

Please consider to include nodes for all GPIO blocks used in this
evaluation board, and add:

gpio-line-names = "foo", "bar" ...;

See for example
arch/arm/boot/dts/bcm2835-rpi-a.dts
arch/arm/boot/dts/ste-snowball.dts

It's good to have because probably you guys have proper schematics and
know rail names of the stuff connected to those GPIO lines and so on,
so you can give the lines proper names.

It will be helpful for people using the reference design, especially with the
new character device, and also sets a pattern for people doing devices
based on the reference design and we really want to do that.

Yours,
Linus Walleij
