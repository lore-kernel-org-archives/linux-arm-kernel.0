From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 13 Sep 2014 12:59:14 +0200
Subject: [PATCHv5] mtd: nand: atmel_nand: retrieve NFC clock
In-Reply-To: <CAAEAJfD_Kujcf7m9RAbRrjA82A08N81rVwy6sXY_PORdrH0VkA@mail.gmail.com>
References: <1410564239-8411-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CAAEAJfD_Kujcf7m9RAbRrjA82A08N81rVwy6sXY_PORdrH0VkA@mail.gmail.com>
Message-ID: <20140913105914.GD26281@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13/09/2014 at 10:26:18 +0100, Ezequiel Garcia wrote :
> > +       nfc->clk = devm_clk_get(&pdev->dev, NULL);
> > +       if (!IS_ERR(nfc->clk)) {
> > +               ret = clk_prepare_enable(nfc->clk);
> > +               if (ret)
> > +                       return ret;
> > +       } else {
> > +               dev_warn(&pdev->dev, "NFC clock missing, update your Device Tree");
> 
> Looks much better now thanks. If the clock is not really optional, you
> can consider this a firmware bug. We've used FW_BUG messages for these
> cases
> (see vim drivers/watchdog/orion_wdt.c), so you could write something like:
> 
> dev_warn(..., FW_BUG "devicetree clock missing");
> 

Yeah, I've considered using FW_WARN like Thomas suggested but I'm not
sure it really relates to device tree. Apart from x86, FW_WARN and
FW_BUG are only used on mvebu stuff ;)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
