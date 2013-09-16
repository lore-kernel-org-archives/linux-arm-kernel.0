From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Sep 2013 13:44:49 -0600
Subject: [PATCH v3] PWM: PXA: add device tree support to PWM driver
In-Reply-To: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com>
References: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <52375FB1.5050700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 10:54 AM, Mike Dunn wrote:
> This patch adds device tree support to the PXA's PWM driver.  Only an OF match
> table is added; nothing needs to be extracted from the device tree node.  The
> existing ID table is reused for the match table data.
> 
> Tested on a Palm Treo 680 (both platform data and DT cases).

> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt

> +- compatible: should be one of:
> +  - "marvell,pxa250-pwm"
> +  - "marvell,pxa270-pwm"
> +  - "marvell,pxa168-pwm"
> +  - "marvell,pxa910-pwm"

Not just one of, but possible more than one...

> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi

> +		pwm0: pwm at 40b00000 {
> +			compatible = "marvell,pxa270-pwm";

I thought the assertion was that pax270 and pxa250 were both compatible?
If so, that should be:

		compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
