From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 06 Jan 2015 14:36:05 +0100
Subject: [PATCH] ARM: dts: imx51-babbage: Fix ULPI PHY reset modelling
In-Reply-To: <20150106124343.GM24511@dragon>
References: <1420478348-2754-1-git-send-email-fabio.estevam@freescale.com>
 <20150106124343.GM24511@dragon>
Message-ID: <1420551365.2333.15.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 06.01.2015, 20:43 +0800 schrieb Shawn Guo:
> On Mon, Jan 05, 2015 at 03:19:08PM -0200, Fabio Estevam wrote:
> > GPIO2_5 is the reset GPIO for the USB3317 ULPI PHY. Instead of modelling it as
> > a regulator, the correct approach is to use the 'reset_gpios' property of the
> > "usb-nop-xceiv" node.
> > 
> > GPIO1_7 is the reset GPIO for the USB2517 USB hub. As we currently don't have
> > dt bindings to describe a HUB reset, let's keep using the regulator approach.
> > 
> > Rename the regulator to 'reg_hub_reset' to better describe its function and bind
> > it with the USB host1 port instead.
> > 
> > USB host support has been introduced by commit 9bf206a9d13be3 ("ARM: dts:
> > imx51-babbage: Add USB Host1 support"), which landed in 3.16 and it seems that
> > USB has only been functional due to previous bootloader initialization.
> > 
> > With this patch applied we can get USB host to work without relying on the 
> > bootloader.
> > 
> > Cc: <stable@vger.kernel.org> # 3.16+
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Applied, thanks.
> 
For the record:
I'm not happy with this patch. It still abuses the regulator API for
something completely unrelated and this may well break again in the
future. But given that it fixes an actual regression and you already
sent a pull including this I'm okay to keep it.

We still need a proper fix to handle ULPI resets to get rid of this
hackery.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
