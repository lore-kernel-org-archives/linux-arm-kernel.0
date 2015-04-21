From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 21 Apr 2015 08:31:25 -0600
Subject: [PATCH 13/13] coresight: document the bindings for the ATCLK
In-Reply-To: <1429534746-3068-13-git-send-email-linus.walleij@linaro.org>
References: <1429534746-3068-1-git-send-email-linus.walleij@linaro.org>
 <1429534746-3068-13-git-send-email-linus.walleij@linaro.org>
Message-ID: <CANLsYkyDMy2fdYeA6u-8D5fCxOX74YoN5CvD1WXwaUOD9JwvXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 April 2015 at 06:59, Linus Walleij <linus.walleij@linaro.org> wrote:
> Put in a blurb in the device tree bindings indicating that
> coresight blocks may have an optional ATCLK.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index 88602b75418e..8711c1065479 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -21,11 +21,14 @@ its hardware characteristcs.
>         * reg: physical base address and length of the register
>           set(s) of the component.
>
> -       * clocks: the clock associated to this component.
> -
> -       * clock-names: the name of the clock as referenced by the code.
> -         Since we are using the AMBA framework, the name should be
> -         "apb_pclk".
> +       * clocks: the clocks associated to this component.
> +
> +       * clock-names: the name of the clocks referenced by the code.
> +         Since we are using the AMBA framework, the name of the clock
> +         providing the interconnect should be "apb_pclk", and some
> +         coresight blocks also have an additional clock "atclk", which
> +         clocks the core of that coresight component. The latter clock
> +         is optional.
>
>         * port or ports: The representation of the component's port
>           layout using the generic DT graph presentation found in
> --
> 1.9.3
>

I'm good with that but it's probably worthy to include the DT brigade
on this, at the very least to let them know of the changes...
