From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 11 Dec 2015 18:13:04 +0100
Subject: [PATCH v2 2/3] ehci-platform: Add support for controllers with
 multiple reset lines
In-Reply-To: <1449848520-27379-2-git-send-email-hdegoede@redhat.com>
References: <1449848520-27379-1-git-send-email-hdegoede@redhat.com>
 <1449848520-27379-2-git-send-email-hdegoede@redhat.com>
Message-ID: <1449853984.3419.52.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 11.12.2015, 16:41 +0100 schrieb Hans de Goede:
> From: Reinder de Haan <patchesrdh@mveas.com>
> 
> At least the EHCI/OHCI found on the Allwinnner H3 SoC needs multiple
> reset lines, the controller will not initialize while the reset for
> its companion is still asserted, which means we need to de-assert
> 2 resets for the controller to work.
> 
> Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use the new reset_control_[de]assert_shared reset-controller functions
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt |  2 +-
>  drivers/usb/host/ehci-platform.c                   | 47 +++++++++++++---------
>  2 files changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index a12d601..0701812 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -18,7 +18,7 @@ Optional properties:
>   - clocks : a list of phandle + clock specifier pairs
>   - phys : phandle + phy specifier pair
>   - phy-names : "usb"
> - - resets : phandle + reset specifier pair
> + - resets : a list of phandle + reset specifier pairs

Are there documented names for these resets? Is the companion you
mention the Port Control?

regards
Philipp
