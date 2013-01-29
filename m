From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 29 Jan 2013 15:55:00 +0100
Subject: [PATCH,RFC] usb: add devicetree helpers for determining
 dr_mode and phy_type
In-Reply-To: <20130129143302.GF2046@arwen.pp.htv.fi>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <5107D253.5030400@ti.com> <20130129135336.GA3323@pengutronix.de>
 <5107D84F.80401@ti.com> <20130129143302.GF2046@arwen.pp.htv.fi>
Message-ID: <20130129145500.GB3323@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I prefer u32 here, because we have the matching enum. Otherwise we end
> up with:
> 
> of_property_read_string(...,&type);
> 
> if (!strcmp(type, "ulpi"))
> 	foo();
> else if (!strcmp(type, "utmi"))
> 	bar();
> else if (!strcmp(type, "pipe3"))
> 	baz();
> else
> 	BUG();
> 
> and I don't like that, it's ugly and error prone.

Error prone? I guess my mileage varies. Especially compared to the
probability devicetree creators pick the wrong number.

It also removes the (probably implicit) rule that the enum mustn't be
modified since it is exported to users.

Also, you could map the strings to the enum first and then switch-case
over it to make the code nicer.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/62825868/attachment.sig>
