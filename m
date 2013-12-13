From: mporter@linaro.org (Matt Porter)
Date: Fri, 13 Dec 2013 09:23:41 -0500
Subject: [PATCH v2 4/6] ARM: brcmstb: add misc. DT bindings for
 brcm,brcmstb
In-Reply-To: <1385511748-27869-5-git-send-email-marc.ceeeee@gmail.com>
References: <1385511748-27869-1-git-send-email-marc.ceeeee@gmail.com>
 <1385511748-27869-5-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <20131213142341.GB23499@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 04:22:26PM -0800, Marc Carino wrote:
> Document the bindings that the Broadcom STB platform needs
> for proper bootup.
> 
> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/arm/brcm-brcmstb.txt       |   72 ++++++++++++++++++++
>  1 files changed, 72 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
> new file mode 100644
> index 0000000..2f3cd50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
> @@ -0,0 +1,72 @@
> +Broadcom STB platforms Device Tree Bindings
> +-------------------------------------------
> +Boards with Broadcom Brahma15-based BCM7xxx SOC shall have the following
> +properties.

Does Brahma15 identify the ARM-based members of the BCM7xxx family? I
ask since it's a little confusing knowing that there's some MIPs-based
BCM7xxx SoCs and this binding is specific to the ARM versions.  Could the
ARM-based members be enumerated explicitly by part number? e.g. BCM7445,
etc.

> +
> +Required root node properties:
> +    - compatible = "brcm,brcmstb";

Along the same lines...Isn't this a little too generic for a compatible
string? If BCM7445 were the first in this family wouldn't brcm,bcm7445
be more appropriate given the compatible string naming guidelines?

-Matt
