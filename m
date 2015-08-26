From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Aug 2015 19:44:51 -0600
Subject: [PATCH v4 3/5] dt/bindings: bcm2835: add binding documentation
 for bcm2835-aux
In-Reply-To: <1440405608-3995-4-git-send-email-kernel@martin.sperl.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
 <1440405608-3995-4-git-send-email-kernel@martin.sperl.org>
Message-ID: <55DD1A13.7010705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2015 02:40 AM, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>

Patch description?

> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-aux.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-aux.txt

> +Required properties:
> +- compatible: Should be "brcm,bcm2835-aux".
> +- reg: Should contain register location and length for the
> +       enable register

As I mentioned before, why not all the aux registers (that aren't part
of a sub-device like SPI).

> +Example:
> +
> +aux_enable: aux_enable at 0x7e215004 {
> +	compatible = "bcrm,bcm2835-aux";
> +	reg = <0x7e215004 0x04>;

I'd expect that to be <0x7e215000 0x8>;
