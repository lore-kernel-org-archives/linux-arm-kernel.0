From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jul 2015 11:49:26 +0200
Subject: [PATCH v2 2/2] pinctrl: driver for Conexant Digicolor CX92755 pin
 mapping
In-Reply-To: <28c81769f3ed3e4c24ce00bbe2773009259ba3fe.1430823310.git.baruch@tkos.co.il>
References: <eaf294961247ac7c105156d6fae6d7389a4c0dfc.1430823310.git.baruch@tkos.co.il>
 <28c81769f3ed3e4c24ce00bbe2773009259ba3fe.1430823310.git.baruch@tkos.co.il>
Message-ID: <CACRpkdbvW8KWiLCfGUvqCeyxznBiSrOFgSCPSyF9=c_pLENwyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 5, 2015 at 12:55 PM, Baruch Siach <baruch@tkos.co.il> wrote:

> This adds pinctrl and gpio driver to the CX92755 SoC "General Purpose Pin
> Mapping" hardware block. The CX92755 is one SoC from the Conexant Digicolor
> series. Pin mapping hardware supports configuring pins as either GPIO, or up to
> 3 other "client select" functions. This driver adds support for pin muxing
> using the generic device tree binding, and a basic gpiolib driver for the GPIO
> functionality.
>
> This driver does not currently support GPIO interrupts, and pad configuration.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2:
>    * Address review comments for Linus Walleij:
>      - Add a pointer to pinctrl_desc in struct dc_pinmap
>      - Drop the now redundant pinctrl_pin_desc field
>      - Adapt dc_get_group_{name,pins} to these changes, and add a comment
>        explaining the 1-to-1 pin-groups relation
>    * Staticise dc_pmxops
>    * Protect the GP_CLIENTSEL clct parameter with parenthesis

This v2 patch applied.

Sorry for fat delays. It's a nice driver and looks good.

Yours,
Linus Walleij
