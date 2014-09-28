From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 28 Sep 2014 11:37:05 -0700
Subject: [PATCH 1/4] dt-bindings: Add a clocks property to the
 simple-framebuffer binding
In-Reply-To: <1411908218-20947-1-git-send-email-hdegoede@redhat.com>
References: <1411908218-20947-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAPtuhThAgUThzdHAnWydDeM8unV=fjT88PH3Ww6h5_ezeGEOYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 28, 2014 at 5:43 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> A simple-framebuffer node represents a framebuffer setup by the firmware /
> bootloader. Such a framebuffer may have a number of clocks in use, add a
> property to communicate this to the OS.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mike Turquette <mturquette@linaro.org>
or
Reviewed-by: Mike Turquette <mturquette@linaro.org>

I don't know what is the right thing with these binding definitions...

Also I have one suggestion below:

> ---
>  Documentation/devicetree/bindings/video/simple-framebuffer.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> index 70c26f3..e75478e 100644
> --- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> @@ -14,6 +14,9 @@ Required properties:
>    - r5g6b5 (16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b).
>    - a8b8g8r8 (32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r).
>
> +Optional properties:
> +- clocks : List of clocks used by the framebuffer
> +
>  Example:
>
>         framebuffer {

It might be nice to add the clocks property to the example. Something like:

clocks = <&osc 1>, <&ref 0>;

Regards,
Mike

> --
> 2.1.0
>
