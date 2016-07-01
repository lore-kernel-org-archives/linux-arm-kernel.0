From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jul 2016 11:46:04 +0200
Subject: [PATCH 6/7] dt-bindings: net: bgmac: add bindings documentation
 for bgmac
In-Reply-To: <1467327554-22074-7-git-send-email-jon.mason@broadcom.com>
References: <1467327554-22074-1-git-send-email-jon.mason@broadcom.com>
 <1467327554-22074-7-git-send-email-jon.mason@broadcom.com>
Message-ID: <29091648.CIZSyGWL7u@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 30, 2016 6:59:13 PM CEST Jon Mason wrote:
> +
> +Required properties:
> + - compatible: "brcm,bgmac-nsp"
> + - reg:                Address and length of the GMAC registers,
> +               Address and length of the GMAC IDM registers
> + - reg-names:  Names of the registers.  Must have both "gmac_base" and
> +               "idm_base"
> + - interrupts: Interrupt number
> +


"brcm,bgmac-nsp" sounds a bit too general. As I understand, this is a family
of SoCs that might not all have the exact same implementation of this
ethernet device, as we can see from the long lookup table in bgmac_probe().

Please document the specific product numbers here that are publically
known already. Having the driver match just on "brcm,bgmac-nsp" as a fallback
is fine, so you can document that one as required for all users.

	Arnd
