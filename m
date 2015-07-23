From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Jul 2015 09:36:35 -0500
Subject: [PATCH v3 42/46] usb: gadget: move ep_matches() from epautoconf
 to udc-core
In-Reply-To: <55B07048.3000609@tul.cz>
References: <55B07048.3000609@tul.cz>
Message-ID: <20150723143635.GB21984@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 23, 2015 at 06:40:40AM +0200, Petr Cvek wrote:
> Hello,
> 
> Is this:
> 
> 	case USB_ENDPOINT_XFER_INT:
> 		/* Bulk endpoints handle interrupt transfers,
> 		 * except the toggle-quirky iso-synch kind
> 		 */
> 		if (!ep->caps.type_int && !ep->caps.type_bulk)
> 			return 0;
> 
> ... or original:
> 
> 			switch (type) {
> 			case USB_ENDPOINT_XFER_INT:
> 				/* bulk endpoints handle interrupt transfers,
> 				 * except the toggle-quirky iso-synch kind
> 				 */
> 				if ('s' == tmp[2])	{// == "-iso"
> 					return 0;
> 
> code still valid? 
> 
> It seems that it allows using a BULK endpoint for requested INT
> endpoint. For my PXA27x machine the original code returns BULK EP even
> with valid INT endpoint definition (because BULK EPs are defined
> earlier than INT EPs).
> 
> This part of the code is from pre git era
> 
> 	1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
> 
> before pxa27x driver was written and only few chips was supported.
> Does anyone know if the INT endpoints works now?

it's very difficult to read your reply when you remove all context.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150723/b205a82f/attachment.sig>
