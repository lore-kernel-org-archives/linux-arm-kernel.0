From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 30 Aug 2014 14:15:58 -0700
Subject: [PATCH v2 6/9] usb: xhci: Add NVIDIA Tegra xHCI host-controller
 driver
In-Reply-To: <1408381705-3623-7-git-send-email-abrestic@chromium.org>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <1408381705-3623-7-git-send-email-abrestic@chromium.org>
Message-ID: <20140830211558.GA13814@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:08:22AM -0700, Andrew Bresticker wrote:
> Add support for the on-chip xHCI host controller present on Tegra SoCs.
> 
> The driver is currently very basic: it loads the controller with its
> firmware, starts the controller, and is able to service messages sent
> by the controller's firmware.  The hardware supports device mode as
> well as lower-power operating modes, but support for these is not yet
> implemented here.

So you are saying the device doesn't really work?  Can it handle USB
transactions properly?

I have a jetson board here, is this the controller for that hardware?
Can I test this series on that platform, or is it for something else?

> +static const struct tegra_xhci_soc_config tegra124_soc_config = {
> +	.firmware_file = "nvidia/tegra124/xusb.bin",
> +};
> +MODULE_FIRMWARE("nvidia/tegra124/xusb.bin");

Has this file been submitted to the linux-firmware tree?

thanks,

greg k-h
