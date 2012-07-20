From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Jul 2012 22:10:28 +0000
Subject: [PATCHv2 2/2] ARM: vt8500: Add support for UHCI companion
 controller
In-Reply-To: <1342787373-2230-2-git-send-email-linux@prisktech.co.nz>
References: <1342787373-2230-1-git-send-email-linux@prisktech.co.nz>
 <1342787373-2230-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <201207202210.28790.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 July 2012, Tony Prisk wrote:
> Add support for a generic non-pci UHCI companion controller.
> Existing board files for arch-vt8500 updated to include UHCI
> support.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Looks almost good, but 

* please add a binding document
* cc the maintainers and usb mailing list
* the "of-uhci" string does not seem appropriate:

> +static const struct of_device_id platform_uhci_ids[] = {
> +	{ .compatible = "of-uhci", },
> +	{}
> +};

The of- part is clearly meaningless in the binding that is about of
devices. Using usb-uhci would be more appropriate I think, but maybe
someone can come up with an even better name. Which consortium
or company created uhci?

	Arnd
