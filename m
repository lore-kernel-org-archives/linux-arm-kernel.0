From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 10 Sep 2013 14:02:43 -0600
Subject: [PATCH v9 1/3] gpio: bcm281xx: Add GPIO driver
In-Reply-To: <1378836423-12467-2-git-send-email-markus.mayer@linaro.org>
References: <1378836423-12467-1-git-send-email-markus.mayer@linaro.org>
 <1378836423-12467-2-git-send-email-markus.mayer@linaro.org>
Message-ID: <522F7AE3.6050105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2013 12:07 PM, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add the GPIO driver for the Broadcom bcm281xx family of mobile SoCs.
> These GPIO controllers may contain up to 8 banks where each bank
> includes 32 pins that can be driven high or low and act as an edge
> sensitive interrupt.

The binding,
Reviewed-by: Stephen Warren <swarren@nvidia.com>

although ...

> diff --git a/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt b/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt

> +This GPIO driver is used in the following Broadcom SoCs:
> +  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155

Given that, I would expect the documentation of the compatible property
to enumerate the compatible values for all of those different chips,
although the driver could choose to only bind to e.g. brcm,bcm11351-gpio
or brcm,kona-gpio, since they're all compatible with it.
