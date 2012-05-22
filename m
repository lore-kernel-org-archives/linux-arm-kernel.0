From: marex@denx.de (Marek Vasut)
Date: Tue, 22 May 2012 06:20:16 +0200
Subject: [PATCH v2 07/12] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <CAAQ0ZWSiD170Yb5CQdGEZw066ULvSOr4AFcBtYFiLw3P9L-VuA@mail.gmail.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <201205220525.39660.marex@denx.de>
 <CAAQ0ZWSiD170Yb5CQdGEZw066ULvSOr4AFcBtYFiLw3P9L-VuA@mail.gmail.com>
Message-ID: <201205220620.17109.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On 22 May 2012 11:25, Marek Vasut <marex@denx.de> wrote:
> > Dear Shawn Guo,
> > 
> >> Apart from my comments below, we really need to know Rob and Grant's
> >> opinion on this.
> > 
> > Hm ... so why don't you actually write per-board driver ? :-) That'd
> > handle every single board very well, you'd configure the GPIOs there,
> > every single additional necessary thing that has to be configured would
> > sink there too etc.
> 
> I'm not completely sure about how the per-board driver looks like
> exactly.  Can you have some code demonstrating it?

Well such per-board driver would handle the board-specific init, like 
configuring the hub GPIO (as Richard has to do so on mx6q) or flick some other 
GPIOs, configure registers etc.

You can not depend on a bootloader to do such init for you, even though the 
bootloader should do it and should do it right.

> 
> Regards,
> Shawn

Best regards,
Marek Vasut
