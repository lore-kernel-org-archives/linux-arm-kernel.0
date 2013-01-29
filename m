From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 29 Jan 2013 14:53:36 +0100
Subject: [PATCH,RFC] usb: add devicetree helpers for determining
 dr_mode and phy_type
In-Reply-To: <5107D253.5030400@ti.com>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <5107D253.5030400@ti.com>
Message-ID: <20130129135336.GA3323@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >+	err = of_property_read_string(np, "phy_type", &phy_type);
> >+	if (err < 0)
> >+		return USBPHY_INTERFACE_MODE_NA;
> 
> Why don't we use a u32 property type for the *phy-type*? IMHO we
> should use string property only when the property should be
> absolutely unambiguous (e.g., compatible property should be string).

If we would use u32-numbers in the compatible entry, this would also be
unambiguous, no? 0xd00dfeed would be the at24-driver. Pretty specific.

I don't mind having readable devicetrees. And we have it for ethernet
phys already with strings, so it would be consistent.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/0b5575ea/attachment.sig>
