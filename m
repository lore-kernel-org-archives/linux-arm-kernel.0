From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Sep 2015 14:19:05 +0200
Subject: [PATCH 0/5] ARM: sunxi: Introduce CHIP support
In-Reply-To: <2353279.QTDzFUHVnF@wuerfel>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
 <2353279.QTDzFUHVnF@wuerfel>
Message-ID: <20150918121905.GO4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Sep 18, 2015 at 11:02:33AM +0200, Arnd Bergmann wrote:
> On Friday 18 September 2015 10:48:45 Maxime Ripard wrote:
> > 
> > Here is a serie introducing the support for the Allwinner R8 and the
> > Nextthing's CHIP.
> > 
> > Support is almost complete for the CHIP itself, the only missing part
> > for now is the WiFi chip that needs to be powered through two combined
> > regulators (AXP209's LDO3 and LDO4). The audio codec is also missing
> > since it's not already enabled in the DT.
> > 
> > Both these features will be addressed eventually.
> > 
> > Let me know what you think,
> 
> Very nice!
> 
> When you get to the WiFi support, please loop in Ulf and me to the Cc list.

Ack.

> IIRC there were some open questions about how we should handle SDIO wifi
> controllers with special requirements like this, both in general and
> in particular with this driver.

There's actually two issues that are pretty orthogonal:

  * the fact that the regulator to power the wifi chip needs to be
    enabled before it enumerates and the driver is probed. The MMC
    pwrseq stuff seems to fix that, even if it doesn't really fit in
    the usual DT model.

  * The fact that that regulator on this board is actually two
    regulators in parallel that needs to be controlled in parallel
    too. Here, it will probably require a new regulator driver to
    combine two regulators into one.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/a88edb14/attachment-0001.sig>
