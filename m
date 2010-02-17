From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Feb 2010 10:50:00 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <4B6FE162.6000004@warmcat.com>
References: <20100208065519.GE1290@ucw.cz>
	<1265622676.4020.19.camel@pc1117.cambridge.arm.com>
	<4B6FE162.6000004@warmcat.com>
Message-ID: <20100217095000.GA17643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2010 at 11:03:14AM +0100, Andy Green wrote:
> On 02/08/10 10:51, Somebody in the thread at some point said:
>
>> We could of course flush the caches every time we get a page fault but
>> that's far from optimal, especially since DMA-capable drivers to do not
>> pollute the D-cache and don't need this extra flushing. Note that the
>> recent ARM processors have PIPT caches but separate for I and D and it's
>> the PIO drivers that pollute the D-cache.
>
> Just noting that AFAIK iMX31 USB and MMC drivers both are PIO at the  
> moment, for lack of any platform DMA support of its unusual DMA engine.

The EHCI module has its own DMA engine and has nothing to do with the
SDMA engine.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
