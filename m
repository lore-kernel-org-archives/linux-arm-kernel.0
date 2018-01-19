From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Fri, 19 Jan 2018 23:55:42 +0100
Subject: Sunxi display white flash
Message-ID: <cd353e6a-685f-904e-beb6-f56a905f0ae9@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I was wondering if it does make sense to reset TCON during sun4i_tcon_bind.
What I experience is a screen white flash,
this is because uboot already initialized display and enabled backlight.

IMHO, I would make TCON total reinit selectable via Kconfig and enabled 
by default,
even if I don't like at all not to reset peripheral before using it,
and assuming uboot did it for us before.

What do you think?
Do you have some other idea to workaround this?

Maybe checking if peripheral has already been set before,
if Yes, avoid to reinit it.
Could it make sense?

Kind regards
-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
