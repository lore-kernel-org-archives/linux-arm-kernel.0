From: broonie@kernel.org (Mark Brown)
Date: Thu, 25 Jul 2013 14:15:56 +0100
Subject: How to create IRQ mappings in a GPIO driver that doesn't control
 its IRQ domain ?
In-Reply-To: <1408178.cxAUTUGJc5@avalon>
References: <1624911.6TtmtVmU1T@avalon>
 <CACRpkdazPX3EbVbLvXQZh0oRBpHoWPK+EkFO75v9zfAXSPCkHA@mail.gmail.com>
 <1408178.cxAUTUGJc5@avalon>
Message-ID: <20130725131556.GD9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 11:45:33AM +0200, Laurent Pinchart wrote:

> The two devices are independent, so there's no real parent/child relationship. 
> However, as Grant proposed, I could list all the interrupts associated with 
> GPIOs in the GPIO controller DT node. I would then just call 
> irq_of_parse_and_map() in the .to_irq() handler to magically translate the 
> GPIO number to a mapped IRQ number.

> The number of interrupts can be pretty high (up to 58 in the worst case so 
> far), so an alternative would be to specify the interrupt-parent only, and 
> call irq_create_of_mapping() directly. What solution would you prefer ?

Are the interrupts in a contiguous block in the controller so you can
just pass around the controller and a base number?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/7689d8e3/attachment.sig>
