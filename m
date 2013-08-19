From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Aug 2013 16:50:17 -0600
Subject: [PATCH v4 1/3] ARM: bcm281xx: Add GPIO driver
In-Reply-To: <1376938761-13657-2-git-send-email-markus.mayer@linaro.org>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <1376938761-13657-2-git-send-email-markus.mayer@linaro.org>
Message-ID: <5212A129.6080601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 12:59 PM, Markus Mayer wrote:
> This patch adds the GPIO driver for the bcm281xx family of chips.

> diff --git a/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt b/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt

The simple way to avoid the discussion re: the name of the file might
have been to name it exactly matching the compatible value it documents,
i.e. brcm,kona-gpio.txt. That's what I personally prefer, but it's not
mandatory in any way at all.

> +Broadcom Kona Family GPIO
> +-------------------------
> +
> +This GPIO driver is used in the following Broadcom SoCs:
> +  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> +
> +The GPIO controller only supports edge, not level, triggering of interrupts.
> +
> +- compatible: "brcm,kona-gpio"

Per recent discussions, all the supported compatible values should be
spelled out here, which I assume are:

brcm,kona-gpio
brcm,bcm11130
brcm,bcm11140
brcm,bcm11351
brcm,bcm28145
brcm,bcm28155

Documenting all of them allows drivers to implement quirks/workarounds
based on individual SoCs if ever needed.

Aside from that, the binding seems reasonable, so the binding,
Acked-by: Stephen Warren <swarren@nvidia.com>
