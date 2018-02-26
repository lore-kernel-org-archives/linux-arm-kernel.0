From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Feb 2018 21:42:02 +0100
Subject: [PATCH] ARM: dts: Set D-Link DNS-313 SATA to muxmode 0
In-Reply-To: <20180225130814.26515-1-linus.walleij@linaro.org>
References: <20180225130814.26515-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a3-jvmRF1HoRqBcik0HcQ1xd4bXFXzhoREnVyV9eevGAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 25, 2018 at 2:08 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This stops the driver from trying to probe the ATA slave
> interface. The vendor code enables the slave interface
> but the driver in the vendor tree does not make use of
> it.
>
> Setting it to muxmode 0 disables the slave interface:
> the hardware only has the master interface connected
> to the one harddrive slot anyways.
>
> Without this change booting takes excessive time, so it
> is very annoying to end users.
>
> Fixes: dd5c0561db75 ("ARM: dts: Add basic devicetree for D-Link DNS-313")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this for fixes for v4.16.

Applied, thanks!

      Arnd
