From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 9 Jul 2012 15:04:53 +0200
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <20474.55029.733084.749955@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Shawn Guo writes:
> The function tx28_init is basically a rewriting of tx28_add_fec0.  All
> those TX28_FEC_* gpio definitions are meant to be used as a temporary
> solution before we get a generic way to set up board specific gpio
> pins when booting from device tree.
> 
This doesn't work at least because the pins that are used for PHY
strap options need to be reconfigured for their FEC functionality
after releasing the PHY reset. But even after adding the missing
reconfiguration the ethernet PHY does not work.

Since I currently don't have time to delve deeper into this, you may
drop the TX28 board support until I get time to do the conversion to
DT myself.



Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
