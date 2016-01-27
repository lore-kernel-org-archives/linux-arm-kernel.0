From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Jan 2016 15:04:56 +0100
Subject: [PATCH] pinctrl: freescale: imx: implement gpio_disable_free for
 Vybrid
In-Reply-To: <1452279030-5459-1-git-send-email-stefan@agner.ch>
References: <1452279030-5459-1-git-send-email-stefan@agner.ch>
Message-ID: <CACRpkdZ0oneKhFmug9k+zGP2Y0dncwHTEoQ35-ccQ=3MqQzSqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 8, 2016 at 7:50 PM, Stefan Agner <stefan@agner.ch> wrote:

> The Freescale Vybrid SoC has GPIO capabilities as part of the
> IOMUXC. To enable GPIO's, the gpio_request_enable callback has
> been implemented, however the corsponding gpio_disable_free
> callback is missing. So far, disabling (unexporting) a GPIO left
> the pin in its last state.
>
> Implement a proper gpio_disable_free function which clears the
> three enable bits which influence the state (IBE, OBE and PUE).
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Patch applied.

Yours,
Linus Walleij
