From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Aug 2014 13:36:30 -0600
Subject: [PATCH v2 6/9] usb: xhci: Add NVIDIA Tegra xHCI host-controller
 driver
In-Reply-To: <1408381705-3623-7-git-send-email-abrestic@chromium.org>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <1408381705-3623-7-git-send-email-abrestic@chromium.org>
Message-ID: <53FB903E.3050805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
> Add support for the on-chip xHCI host controller present on Tegra SoCs.
>
> The driver is currently very basic: it loads the controller with its
> firmware, starts the controller, and is able to service messages sent
> by the controller's firmware.  The hardware supports device mode as
> well as lower-power operating modes, but support for these is not yet
> implemented here.

Just one minor comment below.

I'd like an ack from a USB maintainer so that this patch can be taken 
through the Tegra tree along with the rest of the series, which has 
various dependencies.

> +MODULE_ALIAS("platform:xhci-tegra");

I don't think that's needed; MODULE_DEVICE_TABLE(of, 
tegra_xhci_of_match) should be enough upstream.
