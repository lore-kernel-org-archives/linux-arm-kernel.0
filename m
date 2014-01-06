From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 6 Jan 2014 10:49:06 -0500 (EST)
Subject: [PATCH 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <1388963080-12544-1-git-send-email-hdegoede@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1401061043240.1282-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jan 2014, Hans de Goede wrote:

> Add support for ohci-platform instantiation from devicetree, including
> optionally getting clks and a phy from devicetree, and enabling / disabling
> those on power_on / off.
> 
> This should allow using ohci-platform from devicetree in various cases.
> Specifically after this commit it can be used for the ohci controller found
> on Allwinner sunxi SoCs.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/usb/platform-ohci.txt      |  25 ++++
>  drivers/usb/host/ohci-platform.c                   | 146 ++++++++++++++++++---
>  2 files changed, 151 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/platform-ohci.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/platform-ohci.txt b/Documentation/devicetree/bindings/usb/platform-ohci.txt
> new file mode 100644
> index 0000000..6846f1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/platform-ohci.txt
> @@ -0,0 +1,25 @@
> +Generic Platform OHCI controller
> +
> +Required properties:
> + - compatible: Should be "platform-ohci"
> + - reg: Address range of the ohci registers.
> + - interrupts: Should contain the ohci interrupt.
> +
> +Optional properties:
> + - clocks: array of clocks
> + - clock-names: clock names "ahb" and/or "ohci"

Where does "ahb" come from, what does it mean, and how is it relevant 
to generic platforms?

What about platforms that use 3 clocks?

Alan Stern
