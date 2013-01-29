From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 29 Jan 2013 16:05:44 +0100
Subject: [PATCH,RFC] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130129145500.GB3323@pengutronix.de>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <5107D253.5030400@ti.com> <20130129135336.GA3323@pengutronix.de>
 <5107D84F.80401@ti.com> <20130129143302.GF2046@arwen.pp.htv.fi>
 <20130129145500.GB3323@pengutronix.de>
Message-ID: <5107E548.4080402@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 03:55 PM, Wolfram Sang wrote:
> 
>> I prefer u32 here, because we have the matching enum. Otherwise we end
>> up with:
>>
>> of_property_read_string(...,&type);
>>
>> if (!strcmp(type, "ulpi"))
>> 	foo();
>> else if (!strcmp(type, "utmi"))
>> 	bar();
>> else if (!strcmp(type, "pipe3"))
>> 	baz();
>> else
>> 	BUG();
>>
>> and I don't like that, it's ugly and error prone.
> 
> Error prone? I guess my mileage varies. Especially compared to the
> probability devicetree creators pick the wrong number.
> 
> It also removes the (probably implicit) rule that the enum mustn't be
> modified since it is exported to users.
> 
> Also, you could map the strings to the enum first and then switch-case
> over it to make the code nicer.

That's what the code already does.

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/f33d6864/attachment.sig>
