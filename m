From: marex@denx.de (Marek Vasut)
Date: Mon, 20 Jul 2015 21:29:41 +0200
Subject: [PATCH 4/7] Documentation: mtd: add a DT property to set the
 latency code of Spansion memory
In-Reply-To: <55ACBE1B.6050507@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>
 <201507161944.20523.marex@denx.de> <55ACBE1B.6050507@atmel.com>
Message-ID: <201507202129.42105.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 20, 2015 at 11:23:39 AM, Cyrille Pitchen wrote:
> Hi Marek,

Hi!

> Le 16/07/2015 19:44, Marek Vasut a ?crit :
> > On Thursday, July 16, 2015 at 05:27:51 PM, Cyrille Pitchen wrote:
> > 
> > Hi!
> > 
> >> Both the SPI controller and the NOR flash memory need to agree on the
> >> number of dummy cycles to use for Fast Read commands. For Spansion
> >> memories, this number of dummy cycles is not given directly but through
> >> a so called "latency code".
> >> The latency code can be found into the memory datasheet and depends on
> >> the SPI clock frequency, the Fast Read op code and the Single/Dual Data
> >> Rate mode.
> > 
> > Shouldn't you be able to derive the latency code from the above
> > information, which you already know then ?
> 
> Yes I agree with you; this could have been done adding static tables inside
> the driver instead of creating a new DT property dedicated to Spansion
> memories.

OK, I see now. The latency code can not be calculed from "SPI clock frequency, 
the Fast Read op code and the Single/Dual Data Rate mode" easily, you need to
index into some table to obtain some ad-hoc value. Got it. Sorry for the noise!

> When I wrote this patch, I had a close look at the s25fl512s datasheet but
> only overviewed few datasheets for other Spansion QSPI flash memories. So
> I don't know whether a single latency code table could be shared among all
> Spansion memories or many tables should be added to support different
> memory models.
> 
> That's why I've chosen to add a dedicated DT property to support Spansion
> memories as it avoids to add tables to guess the proper latency code to be
> used. I thought it would be more flexible.
> 
> Maybe I will remove the support of Spansion QSPI memories from this series
> for now. Their support can still be implemented later.
> 
> Anyway, thanks for your review :)

Let's wait for more comments :)

Best regards,
Marek Vasut
