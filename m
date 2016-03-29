From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 28 Mar 2016 18:27:42 -0700
Subject: [PATCH v2 3/5] dt-bindings: phy: bindings document for common
 Broadcom SATA3 PHY driver
In-Reply-To: <1459140510-5317-4-git-send-email-anup.patel@broadcom.com>
References: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
 <1459140510-5317-4-git-send-email-anup.patel@broadcom.com>
Message-ID: <56F9DA0E.5040608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/03/2016 21:48, Anup Patel a ?crit :
>  Required properties:
>  - compatible: should be one or more of
>       "brcm,bcm7425-sata-phy"
>       "brcm,bcm7445-sata-phy"
> +     "brcm,iproc-ns2-sata-phy"
>       "brcm,phy-sata3"
>  - address-cells: should be 1
>  - size-cells: should be 0
> -- reg: register range for the PHY PCB interface
> -- reg-names: should be "phy"
> +- reg: register ranges for the PHY PCB interface
> +- reg-names: should be "phy" and "phy-ctrl"
> +     The "phy-ctrl" registers are only required for
> +     "brcm,iproc-ns2-sata-phy".

I objected to adding another register during the internal review, which,
in the case of the STB chips is dealt with at the AHCI controller level
as was requested when Brian got the driver sent, but if that is the only
point here, then let's get your patches merged as-is.

The rest of the changes look fine so:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
--
Florian
