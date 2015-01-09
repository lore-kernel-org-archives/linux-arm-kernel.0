From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jan 2015 11:12:16 +0100
Subject: [PATCH 1/4] pinctrl: Broadcom Cygnus pinctrl device tree binding
In-Reply-To: <1417131990-17954-2-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1417131990-17954-1-git-send-email-rjui@broadcom.com>
 <1417131990-17954-2-git-send-email-rjui@broadcom.com>
Message-ID: <CACRpkdb5pNMbXmWGjrGpAYNLLwv6pWWOJQy0C6BLetNcStFM6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 12:46 AM, Ray Jui <rjui@broadcom.com> wrote:

> Device tree binding documentation for Broadcom Cygnus pinctrl driver
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  .../bindings/pinctrl/brcm,cygnus-pinctrl.txt       |   92 ++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinctrl.txt
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinctrl.txt
> new file mode 100644
> index 0000000..86e4579
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinctrl.txt
> @@ -0,0 +1,92 @@
> +Broadcom Cygnus Pin Controller
> +
> +The Cygnus pin controller supports setting the alternate functions of groups
> +of pins. Pinmux configuration on individual pins is not supported by the
> +Cygnus A0 SoC.
> +
> +Required properties:
> +
> +- compatible:
> +    Must be "brcm,cygnus-pinctrl"
> +
> +- reg:
> +    Define the base and range of the I/O address space that contain the Cygnus
> +pin control registers

The following is subnodes. Indicate clearly in the binding that these are
*not* properties of the main node, but individual subnodes.

> +- brcm,groups:
> +    This can be strings of one or more group names. This defines the group(s)
> +that one wants to configure
> +
> +- brcm,function:
> +    This is the alternate function that one wants to configure to. Valid
> +alternate functions are "alt1", "alt2", "alt3", "alt4"

NAK. We have standardized bindings for groups and functions,
and there are pending patches from S?ren Brinkmann adding
this to the pinctrl DT parsing core.

Just use "groups" and "function" and refer to
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

Then "alt1", "alt2" etc are non-functional names of functions.
Use the real function names, like "spi0" or so. This
alt-business seems to be just a shortcut to make it
simple, don't do that.

Then you use e.g. "spi0" as a group name. I prefer you
call that "spi0_grp" or something to say it is a group of
pins associated with spi0, as spi0 is actually the
function.

If unsure of the definitions of group and function, refer
to Documentation/pinctrl.txt

Yours,
Linus Walleij
