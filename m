From: robh@kernel.org (Rob Herring)
Date: Wed, 6 Apr 2016 10:12:09 -0500
Subject: [PATCH 4/5] devicetree: leds: Introduce "panic-blink" optional
 property
In-Reply-To: <1459801326-5541-5-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1459801326-5541-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1459801326-5541-5-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <CAL_JsqLF-cMtGERnZ0wO_GUkhsf23LQhOm6PwwKAa5evSkOHDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 4, 2016 at 3:22 PM, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> It's desirable to specify which LEDs are to be blinked on a kernel
> panic. Therefore, introduce a devicetree boolean property to mark
> which LEDs should be treated this way.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  Documentation/devicetree/bindings/leds/common.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index 68419843e32f..dd409df9203a 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -37,6 +37,8 @@ Optional properties for child nodes:
>                       property is mandatory for the LEDs in the non-flash modes
>                       (e.g. torch or indicator).
>
> +- panic-blink : Mark this LED to be used by the panic LED trigger.
> +

We already have a way to specify LED triggers. Why can't that be used?

Rob
