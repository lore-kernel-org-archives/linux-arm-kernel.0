From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Feb 2013 10:40:08 -0700
Subject: [PATCH 3/8] USB: EHCI: make ehci-s5p a separate driver
In-Reply-To: <5117edfb.860e440a.097c.3516@mx.google.com>
References: <y> <1360522697-22902-1-git-send-email-y>
 <5117edfb.860e440a.097c.3516@mx.google.com>
Message-ID: <51192CF8.30603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2013 11:58 AM, manjunath.goudar at linaro.org wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> Separate the s5p host controller driver from ehci-hcd host code
> into its own driver module.

> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c

> -#ifdef CONFIG_USB_EHCI_TEGRA
> -#include "ehci-tegra.c"
> -#define PLATFORM_DRIVER		tegra_ehci_driver
> -#endif

That's also still wrong.
