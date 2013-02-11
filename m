From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Feb 2013 10:37:01 -0700
Subject: [PATCH 6/8] USB: EHCI: make ehci-msm a separate driver
In-Reply-To: <5117ee12.860e440a.097c.3521@mx.google.com>
References: <y> <1360522697-22902-1-git-send-email-y>
 <5117ee12.860e440a.097c.3521@mx.google.com>
Message-ID: <51192C3D.5050403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2013 11:58 AM, manjunath.goudar at linaro.org wrote:
> Separate the Qualcomm On-Chip host controller driver from ehci-hcd host code

> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig

> @@ -203,7 +203,7 @@ config USB_EHCI_TEGRA
>         boolean "NVIDIA Tegra HCD support"
>         depends on USB_EHCI_HCD && ARCH_TEGRA
>         select USB_EHCI_ROOT_HUB_TT
> -       help
> +      --- help---
>           This driver enables support for the internal USB Host Controllers
>           found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.

I still don't think that's correct.
