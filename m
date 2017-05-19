From: joel@jms.id.au (Joel Stanley)
Date: Fri, 19 May 2017 13:15:37 +0800
Subject: [PATCH 2/8 v2] clocksource/drivers/fttmr010: Merge FTTMR010 DT
 bindings
In-Reply-To: <20170518201705.28790-2-linus.walleij@linaro.org>
References: <20170518201705.28790-1-linus.walleij@linaro.org>
 <20170518201705.28790-2-linus.walleij@linaro.org>
Message-ID: <CACPK8Xcns4mV5GvXSD=gG6tO+6_6vEiU80Joan23_kJf1njkkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 4:16 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This merges the Moxa and FTTMR010 device tree bindings into the
> Faraday binding document to avoid confusion.
>
> The FTTMR010 is the IP block used by these SoCs, in vanilla
> or modified variant.
>
> The Aspeed variant is modified such that it is no longer fully
> register-compatible with FTTMR010 so for this reason it is not
> listed with two compatible strings, instead just one.
>
> Cc: Joel Stanley <joel@jms.id.au>
> Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
> ChangeLog v1->v2:
> - Added Jonas' Tested-by, no functional changes.
> ---
>  .../devicetree/bindings/timer/faraday,fttmr010.txt    |  4 +++-
>  .../devicetree/bindings/timer/moxa,moxart-timer.txt   | 19 -------------------
>  2 files changed, 3 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
>
> diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
> index b73ca6cd07f8..6e18bd662ccb 100644
> --- a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
> +++ b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
> @@ -7,7 +7,9 @@ Required properties:
>
>  - compatible : Must be one of
>    "faraday,fttmr010"
> -  "cortina,gemini-timer"
> +  "cortina,gemini-timer", "faraday,fttmr010"
> +  "moxa,moxart-timer", "faraday,fttmr010"
> +  "aspeed,ast2400-timer"

The same bindings apply for the ast2500.

Cheers,

Joel


>  - reg : Should contain registers location and length
>  - interrupts : Should contain the three timer interrupts usually with
>    flags for falling edge
> diff --git a/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt b/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
> deleted file mode 100644
> index e207c11630af..000000000000
> --- a/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -MOXA ART timer
> -
> -Required properties:
> -
> -- compatible : Must be one of:
> -       - "moxa,moxart-timer"
> -       - "aspeed,ast2400-timer"
> -- reg : Should contain registers location and length
> -- interrupts : Should contain the timer interrupt number
> -- clocks : Should contain phandle for the clock that drives the counter
> -
> -Example:
> -
> -       timer: timer at 98400000 {
> -               compatible = "moxa,moxart-timer";
> -               reg = <0x98400000 0x42>;
> -               interrupts = <19 1>;
> -               clocks = <&coreclk>;
> -       };
> --
> 2.9.3
>
