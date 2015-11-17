From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Nov 2015 15:34:52 +0100
Subject: [PATCH] pinctrl: fix qcom ssbi drivers for 64-bit compilation
In-Reply-To: <5235862.Gokjxf5QH1@wuerfel>
References: <5235862.Gokjxf5QH1@wuerfel>
Message-ID: <CACRpkdYekZ69TQbewCnr63R2qbPfuVF6gTMfpZQj07ppGsTb8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 5:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> When building pinctrl-ssbi-gpio and pinctrl-ssbi-mpp for ARM64, we get
> a compile warning about invalid types:
>
> drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c: In function 'pm8xxx_gpio_probe':
> drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c:675:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c: In function 'pm8xxx_mpp_probe':
> drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c:766:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>
> This changes the code so we cast the pointer to 'unsigned long', which
> is the right thing to do here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied for fixes with Bj?rn's review tag.

Yours,
Linus Walleij
