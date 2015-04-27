From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 27 Apr 2015 14:43:41 +0300
Subject: [PATCH 2/4] mtd: mxc_nand: limit the size of used oob
In-Reply-To: <20150427075023.GF19431@pengutronix.de>
References: <cover.1430034929.git.baruch@tkos.co.il>
 <4bd5da1f7d57aa32c5682297f7aa0c768e8c6e49.1430034929.git.baruch@tkos.co.il>
 <20150426200725.GC19431@pengutronix.de>
 <20150427043906.GR2258@tarshish>
 <20150427071238.GE19431@pengutronix.de>
 <20150427072057.GT2258@tarshish>
 <20150427075023.GF19431@pengutronix.de>
Message-ID: <20150427114341.GW2258@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, Apr 27, 2015 at 09:50:23AM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Apr 27, 2015 at 10:20:57AM +0300, Baruch Siach wrote:
> > On Mon, Apr 27, 2015 at 09:12:38AM +0200, Uwe Kleine-K?nig wrote:
> > > Hmm I rechecked the reference manual and found a register to specify the
> > > size of the spare area (I didn't notice that one before). Did you try
> > > what happens if you set this to 0x70 for 224 bytes oob?
> > 
> > Which register is that?
> Spare Area Size Register (SPAS) at offset 0x1e10 for the i.MX25 (that's
> what you're using, don't you?).

Yes, that's what I'm using.

I tried setting the SPAS register to oobsize/2 (0x70 in my case), but I see no 
change in behaviour. Moreover, it turns out the previously Barebox set this 
register (apparently wrongly) to 0x20 for spare size of 64. Current Barebox 
master still do. For v3 Barebox limits CONFIG2_SPAS to 218 bytes spare size 
since Eric B?nard's commit 632c45795065 (nand_imx: update to support onfi & 4k 
flashs, 2012-07-05). As you can see, the kernel doesn't touch this register 
for v2 NFC.

I have no idea what is the effect of the SPAS in v2 (or any other) NFC.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
