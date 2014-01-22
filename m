From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 22 Jan 2014 23:46:11 +0300
Subject: [PATCH v8 3/4] ohci-platform: Add support for controllers with
 big-endian regs / descriptors
In-Reply-To: <1390419177-6481-4-git-send-email-hdegoede@redhat.com>
References: <1390419177-6481-1-git-send-email-hdegoede@redhat.com>
 <1390419177-6481-4-git-send-email-hdegoede@redhat.com>
Message-ID: <52E02E13.9070206@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/22/2014 10:32 PM, Hans de Goede wrote:

> Note this commit uses the same devicetree booleans for this as the ones
> already existing in the usb-ehci bindings, see:
> Documentation/devicetree/bindings/usb/usb-ehci.txt

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
[...]

> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index b2d0e1e..71e9d8e 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
[...]
> @@ -164,8 +165,34 @@ static int ohci_platform_probe(struct platform_device *dev)
[...]
> +#ifndef CONFIG_USB_OHCI_BIG_ENDIAN_MMIO
> +		if (ohci->flags & OHCI_QUIRK_BE_MMIO) {
> +			dev_err(&dev->dev,
> +				"Error big-endian-regs not compiled in\n");
> +			err = -EINVAL;
> +			goto err_put_hcd;
> +		}
> +#endif
> +#ifndef CONFIG_USB_OHCI_BIG_ENDIAN_DESC
> +		if (ohci->flags & OHCI_QUIRK_BE_DESC) {
> +			dev_err(&dev->dev,
> +				"Error big-endian-desc not compiled in\n");

    Small grammar nits (sorry): some punctuation like comma or semicolon 
wouldn't hurt after "Error" word here and above. The same for ehci-platfrom.c. 
Also, "support" word wouldn't hurt after the property names in the same message.

WBR, Sergei
