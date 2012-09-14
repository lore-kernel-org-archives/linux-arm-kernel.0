From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 16:00:54 -0600
Subject: [PATCH v3 2/5] Documentation: add description of DT binding for
 the gpio-mvebu driver
In-Reply-To: <1347551658-24449-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347551658-24449-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1347551658-24449-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5053A916.9050708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 09:54 AM, Thomas Petazzoni wrote:

> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt

> +- #interrupt-cells: specifies the number of celles needed to encode an
> +   interrupt source

s/celles/cells/

What value should this property contain for this driver, and what do
those cells mean?

This property is missing from the example below.

> +		gpio0: gpio at d0018100 {
> +			compatible = "marvell,armadaxp-gpio";
> +			reg = <0xd0018100 0x40>,
> +			    <0xd0018800 0x30>;
> +			ngpios = <32>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			interrupts = <16>, <17>, <18>, <19>;
> +		};
