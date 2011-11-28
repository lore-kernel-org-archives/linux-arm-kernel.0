From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 28 Nov 2011 11:07:55 +0100
Subject: 2.6.38 port not booting on i.MX53 SoM
In-Reply-To: <CAN=k24ncTxDMXZzO1ef_+ETFiiqJZxtYSEOAKz3DiwCO8UKwcw@mail.gmail.com>
References: <CAN=k24ncTxDMXZzO1ef_+ETFiiqJZxtYSEOAKz3DiwCO8UKwcw@mail.gmail.com>
Message-ID: <20111128100755.GI17668@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 28, 2011 at 09:38:00AM +0000, Wayne Tams wrote:
> I have a feeling that this might be a very common question and with
> multiple answers, but I am running out of options, so here it goes.
> 
> I have been working with i.MX53 SoM with a 2.6.35 BSP, I am trying to
> dump the SoMs BSP in  favour for Freescale's latest kernel 2.6.38
> (http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=summary).
Better use mainline, that's way less ugly. (And note that the Freescale
kernel is out of scope for this mailing list.)
 
> Using the 2.6.35 kernel as reference I have been trying to configure
> the 2.6.38 kernel to match as well as modifying and adding board and
> platform information.
> 
> The kernel compiles fine but when I come to load the image the kernel
> gets stuck at "Uncompressing Linux... done, booting the kernel."
> 
> Are there any obvious causes for this freeze?
An exception before console output is setup, or a wrong setup.

Enable DEBUG_LL, EARLY_PRINTK and add "earlyprintk" to the commandline.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
