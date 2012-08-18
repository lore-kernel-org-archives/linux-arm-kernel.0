From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 18 Aug 2012 11:53:35 -0300
Subject: [alsa-devel] Lockups reading from i.MX51 SSI registers
In-Reply-To: <20120818074216.GG2232@pengutronix.de>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
 <20120810201456.GL25520@pengutronix.de>
 <20120810210647.GG1451@pengutronix.de>
 <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
 <20120817222738.GH18871@opensource.wolfsonmicro.com>
 <20120818074216.GG2232@pengutronix.de>
Message-ID: <CAOMZO5BirGnUqmvprk-PKDfJ-PX9GYkLeULHRKETUsedbi2F2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 18, 2012 at 4:42 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> You're on i.MX35, right. I had to add
>
>         clk_register_clkdev(clk[ssi1_gate], NULL, "imx-ssi.0");

Ah, ok. This is the same we have on arch/arm/mach-imx/clk-imx31.c ,

and mx31 audio playback is functional in next, so it looks like this
will fix Mark's issue on mx35.

Uwe, would you like to send this patch for clk-imx35.c ?

Regards,

Fabio Estevam
