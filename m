From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 28 Apr 2015 10:51:49 +0530
Subject: [PATCH 1/3 v4] dt/bindings: Add binding for the BCM2835 mailbox
 driver
In-Reply-To: <1430173644-19099-2-git-send-email-eric@anholt.net>
References: <1430173644-19099-1-git-send-email-eric@anholt.net>
 <1430173644-19099-2-git-send-email-eric@anholt.net>
Message-ID: <CABb+yY0JX0G2E5UNaNbtzG7GFY8Xi3wnLK+h8Pmf0uf6NrfzcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 3:57 AM, Eric Anholt <eric@anholt.net> wrote:
> From: Lubomir Rintel <lkundrak@v3.sk>
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
>
> v2: Split into a separate patch for submitting to the devicetree list.
>     Consistently start node docs with a capital letter. device's
>     address in the example shouldn't have "0x". Drop machine-specific
>     interrupt numbers from the docs.  (changes by anholt).
>
> v3: Move the file to just bcm2835-mbox.txt, clean up formatting
>     (changes by anholt, from review by Lee Jones).
>
> v4: Move file back by consensus from various Broadcom platform
>     maintainers (changes by anholt, acked by Lee Jones).
>
>  .../devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
>
> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
> new file mode 100644
> index 0000000..0bb2b9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
> @@ -0,0 +1,19 @@
> +Broadcom BCM2835 VideoCore mailbox IPC
> +
> +Required properties:
> +
> +- compatible:  Should be "brcm,bcm2835-mbox"
> +- reg:         Specifies base physical address and size of the registers
> +- interrupts:  The interrupt number
> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +- #mbox-cells: Specifies the number of cells needed to encode a mailbox
> +                 channel. The value shall be 1
>
Probably also specify what that one-cell value would stand for.

> +
> +Example:
> +
> +mailbox: mailbox at 7e00b800 {
> +       compatible = "brcm,bcm2835-mbox";
> +       reg = <0x7e00b880 0x40>;
> +       interrupts = <0 1>;
> +       #mbox-cells = <1>;
> +};
Usually it comes with an example user node as well.
