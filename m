From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 29 Oct 2014 10:58:10 +0100
Subject: [PATCH RESEND V4 5/9] of: Add NVIDIA Tegra xHCI controller binding
In-Reply-To: <1414535277-15645-6-git-send-email-abrestic@chromium.org>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-6-git-send-email-abrestic@chromium.org>
Message-ID: <20141029095808.GB28356@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 03:27:52PM -0700, Andrew Bresticker wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt
[...]
> +    - pll_u_480m
> +    - clk_m
> +    - pll_e

What are these used for? I guess I'll see when I get to the driver
patch.

> +Optional properties:
> +--------------------
> + - phys: Must contain an entry for each entry in phy-names.
> +   See ../phy/phy-bindings.txt for details.
> + - phy-names: Should include an entry for each PHY used by the controller.
> +   May be a subset of the following:
> +    - utmi-{0,1,2}
> +    - hsic-{0,1}
> +    - usb3-{0,1}
> + - avddio-pex-supply: PCIe/USB3 analog logic power supply.  Must supply 1.05V.
> + - dvddio-pex-supply: PCIe/USB3 digital logic power supply.  Must supply 1.05V.
> + - avdd-usb-supply: USB controller power supply.  Must supply 3.3V.
> + - avdd-pll-utmip-supply: UTMI PLL power supply.  Must supply 1.8V.
> + - avdd-pll-erefe-supply: PLLE reference PLL power supply.  Must supply 1.05V.
> + - avdd-pex-pll-supply: PCIe/USB3 PLL power supply.  Must supply 1.05V.
> + - hvdd-pex-supply: High-voltage PCIe/USB3 power supply.  Must supply 3.3V.
> + - hvdd-pex-plle-supply: High-voltage PLLE power supply.  Must supply 3.3V.

I think the name for this in the documentation is HVDD_PEX_PLL_E, which
would translate to hvdd-pex-pll-e. At least that's how we named this
supply for PCIe.

Alternatively it seems like there are aliases for the USB 3.0 related
supplies:

	avdd-pex-pll -> avdd-usb-ss-pll
	hvdd-pex -> hvdd-usb-ss
	hvdd-pex-pll-e -> hvdd-usb-ss-pll-e

So perhaps these could be used for the XHCI driver instead? Also, should
these supplies not be mandatory?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141029/67a8622c/attachment.sig>
