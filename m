From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 21 Jan 2014 09:31:07 +0100
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
In-Reply-To: <20140121070649.GT16215@pengutronix.de>
References: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
 <20140120122840.36520f37@ipc1.ka-ro>
 <20140120123627.1147f252@ipc1.ka-ro>
 <20140121070649.GT16215@pengutronix.de>
Message-ID: <20140121093107.37737701@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer wrote:
> Hi Lothar,
> 
> On Mon, Jan 20, 2014 at 12:36:27PM +0100, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Lothar Wa?mann wrote:
> > > Hi,
> > > 
> > erroneously pressed the 'Send' button...
> > 
> > > Sascha Hauer wrote:
> > > > When a firmware cannot be found for the SDMA engine then we can
> > > > continue with the inernal ROM firmware.
> > > > 
> > > > The meaning of this message is frequently asked for, so make clear
> > > > that the driver still works with the internal ROM firmware and reduce
> > > > the loglevel from err to info.
> > > > 
> > In case user space firmware loading support (CONFIG_FW_LOADER) is
> > enabled, this message may still be inadequate, since the firmware may
> > very well be loaded lateron.
> 
> Then at least until the RAM firmware is loaded the message is still adequate,
> no? We could add an addional message when the firmware is loaded if you
> like.
> 
There is already a message printed upon successful firmware load:
|imx-sdma 63fb0000.sdma: loaded firmware 1.1

But one message saying 'firmware load failed' and another saying the
opposite is a bit confusing. There actually is also a message saying
'firmware not found' when the timeout expires without any firmware
being loaded. Thus at least in case CONFIG_FW_LOADER is enabled the
message 'Direct firmware load failed' could be omitted.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
