From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 13 Jul 2018 14:44:51 +0200
Subject: [PATCH v3 4/9] dt-bindings: ata: ahci-platform: document AHCI
 reset
In-Reply-To: <1531479786-4911-5-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
 <1531479786-4911-5-git-send-email-clabbe@baylibre.com>
Message-ID: <20180713124451.pwdp6lf6ql2s4hyz@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 11:03:01AM +0000, Corentin Labbe wrote:
> This patch document the new optional resets for ahci node.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index 5f362af2724c..a5281d7557e3 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -34,6 +34,8 @@ Optional properties:
>  - phys              : reference to the SATA PHY node
>  - phy-names         : must be "sata-phy"
>  - ahci-supply       : regulator for AHCI controller
> +- resets            : phandle to the reset line of AHCI controller
> +                      If set, must have a reset-names set as "ahci"

This isn't optional, it's required for the R40, and the other don't
need it.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180713/5154f9ce/attachment.sig>
