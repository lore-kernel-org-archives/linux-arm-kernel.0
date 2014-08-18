From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 18 Aug 2014 17:26:37 +0800
Subject: [RFC] usb issue on imx27: 3 clocks are needed
In-Reply-To: <20140818090056.GA29393@peterchendt>
References: <53EF7AF6.2000405@gmail.com> <20140818090056.GA29393@peterchendt>
Message-ID: <20140818092635.GI2114@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 05:00:59PM +0800, Peter Chen wrote:
> On Sat, Aug 16, 2014 at 05:38:30PM +0200, Philippe Reynes wrote:
> > Hi all,
> > 
> > i.MX27's usb needs three clocks (usb_ipg_gate, usb_ahb_gate and usb_div)
> > but the current chipidea driver implementation, and devicetree, provides
> > only ipg and ahb. Consequently, if the bootloader don't enable the last
> > one, the kernel will crash.
> > 
> > Our approach/idea is to add a second, optionnal, clock in ci_hdrc_imx.c
> > with 'per' name in devicetree  and to add  clock name 'main_clk' for mandatory clock.
> > This approach it correct? Or an other approach seems better?
> > Thank you very much for your point of view.
> > 
> 
> It is ok for me to have ipg, ahb and per clocks at driver, but how can you maintain
> DT consistent?

Adding new clock as optional one will just maintain the DT
compatibility.

> Can you accept open ipg and per always on at clock.c?

No, usb driver should manage its clocks.

Shawn
