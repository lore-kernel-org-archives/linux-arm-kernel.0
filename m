From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 May 2015 15:31:37 +0200
Subject: [PATCH v2] pinctrl: imx: Allow parsing DT without function nodes
In-Reply-To: <1428675758-15335-1-git-send-email-mpa@pengutronix.de>
References: <1428675758-15335-1-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdYaCvzCm02one+ghD0ZVLi7TBbnBvMzfjMUnJvKR0s-8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 4:22 PM, Markus Pargmann <mpa@pengutronix.de> wrote:

> The old format to define pinctrl settings for imx in DT has two
> hierarchy levels. The first level are function device nodes. The second
> level are pingroups which contain a property fsl,pins. The original
> intention was to define all pin functions in a single dtsi file and just
> reference the correct ones in the board files.
> This idea was rejected some time ago leading to the current design to
> have all the pinfunctions defined in the board files. So we don't need
> the function device nodes anymore.
>
> This patch changes the pinctrl driver to accept devicetrees which do not
> have the first hierarchy level, function device nodes. For example
> karo-tx25 already has such a devicetree. Old devicetrees are still
> parsed and supported.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Patch applied with Uwe's and Shawn's ACKs.

Yours,
Linus Walleij
