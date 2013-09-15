From: marex@denx.de (Marek Vasut)
Date: Sun, 15 Sep 2013 16:07:04 +0200
Subject: [PATCH v3] PWM: PXA: add device tree support to PWM driver
In-Reply-To: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com>
References: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <201309151607.04244.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mike Dunn,

> This patch adds device tree support to the PXA's PWM driver.  Only an OF
> match table is added; nothing needs to be extracted from the device tree
> node.  The existing ID table is reused for the match table data.
> 
> Tested on a Palm Treo 680 (both platform data and DT cases).
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
> Changle log:
> v3:
> - remove support for the polarity flag
> - remove per-chip pwm index cell; define custom of_xlate()
>    (now #pwm-cells = <1>)
> - "compatible" strings for all devices added to OF match table
> - various stylistic changes recommended by reviewers
> 
> v2:
> - of_match_table contains only the "pxa250-pwm" compatible string; require
> one device instance per pwm
> - add Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> - add support for polarity flag in DT and implement set_polarity() method
>   (the treo 680 inverts the signal between pwm out and backlight)
> - return -EINVAL instead of -ENODEV if platform data or DT node not found
> - output dev_info string if platform data missing
> - expanded CC list of patch
> 
>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 31 ++++++++++++
>  arch/arm/boot/dts/pxa27x.dtsi                     | 24 +++++++++
>  drivers/pwm/pwm-pxa.c                             | 62
> +++++++++++++++++++++++ 3 files changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt new file mode 100644
> index 0000000..6fcf90c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> @@ -0,0 +1,31 @@
> +Marvell PWM controller
> +
> +Required properties:
> +- compatible: should be one of:
> +  - "marvell,pxa250-pwm"
> +  - "marvell,pxa270-pwm"
> +  - "marvell,pxa168-pwm"
> +  - "marvell,pxa910-pwm"

This really is something I dont quite understand. Why should the driver list 
_every_ _single_ existing CPU that contains such PWM block? Is there any 
agreement about that? For me, it'd make much more sense to list only the CPUs 
where the IP block actually changed in some way, so that the differences can be 
discerned that way.

Best regards,
Marek Vasut
