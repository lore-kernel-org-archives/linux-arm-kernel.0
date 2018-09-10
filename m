From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Sep 2018 13:18:00 -0500
Subject: [PATCH v5 5/9] dt-bindings: ata: ahci-platform: document
 phy-supply
In-Reply-To: <20180903100201.23131-6-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
 <20180903100201.23131-6-clabbe.montjoie@gmail.com>
Message-ID: <20180910181800.GA9759@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2018 at 12:01:57PM +0200, Corentin Labbe wrote:
> This patch document the new optional phy-supply.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index f495774c8af9..45b451961612 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -31,6 +31,7 @@ Optional properties:
>  - clocks            : a list of phandle + clock specifier pairs
>  - resets            : a list of phandle + reset specifier pairs
>  - target-supply     : regulator for SATA target power
> +- phy-supply        : regulator for PHY power

This should be mutually exclusive with the phys property. If you have a 
phy node, then its supply belongs there.

>  - phys              : reference to the SATA PHY node
>  - phy-names         : must be "sata-phy"
>  - ahci-supply       : regulator for AHCI controller
> -- 
> 2.16.4
> 
