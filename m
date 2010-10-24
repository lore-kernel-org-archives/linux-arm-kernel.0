From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Sun, 24 Oct 2010 10:29:56 +0200
Subject: [PATCH] pxafb: correct the vertical back porch macro
In-Reply-To: <386708CA-2F13-4D2B-9130-1849ED47BDA1@sdgsystems.com>
References: <386708CA-2F13-4D2B-9130-1849ED47BDA1@sdgsystems.com>
Message-ID: <19651.61060.253943.962658@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Matt Reimer writes:
> Fix an off-by-one bug in the LCCR2_BegFrmDel() macro. The vertical back porch
> knob LCCR2[BFW] specifies the number of clock periods minus one, but the
> macro wasn't doing the subtraction.
>
Nope! This is true only for the ELW and BLW settings in LCCR1, but not
for the EFW and BFW settings in LCCR2! The vertical front and back
porch can actually be programmed to a length of zero lines.

Furthermore, if you introduce such a change, you should also convert
all users of the macro to use an appropriately adjusted value so that
the result will be the same as without the patch!


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
