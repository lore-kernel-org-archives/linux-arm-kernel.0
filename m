From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 07 Feb 2013 11:48:52 -0700
Subject: [PATCH 09/10] USB: EHCI: make ehci-msm a separate driver
In-Reply-To: <5113e62e.c84e420a.08c3.ffffbf14@mx.google.com>
References: <yes> <1360258447-27247-1-git-send-email-yes>
 <5113e62e.c84e420a.08c3.ffffbf14@mx.google.com>
Message-ID: <5113F714.6000201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 10:34 AM, manjunath.goudar at linaro.org wrote:
> Separate the Qualcomm On-Chip host controller driver from ehci-hcd host code
> into its own driver module.

> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig

> @@ -209,7 +210,7 @@ config USB_EHCI_TEGRA
>         boolean "NVIDIA Tegra HCD support"
>         depends on USB_EHCI_HCD && ARCH_TEGRA
>         select USB_EHCI_ROOT_HUB_TT
> -       help
> +      --- help---
>           This driver enables support for the internal USB Host Controllers
>           found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.

That seems like an unrelated change. The indentation and space after
first "---" looks wrong too. It looks pretty random which of "help" and
"---help---" is used in this file; if you're going to fix that, I think
fix them all, but in a separate patch.
