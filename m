From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 9 Jan 2012 07:40:47 +0100
Subject: mxs: enable phy-clock in the driver?
In-Reply-To: <20120109013404.GD1835@S2101-09.ap.freescale.net>
References: <20120108144558.GB2544@pengutronix.de>
 <20120109013404.GD1835@S2101-09.ap.freescale.net>
Message-ID: <20234.35823.411762.856482@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Sun, Jan 08, 2012 at 03:45:58PM +0100, Wolfram Sang wrote:
> > Hi Shawn,
> > 
> > I recently noticed that my tx28 board did not have net when booting from NAND
> > (before that, barebox was setting up the network). Adding lines like these from
> > mx28evk helped:
> > 
> > 228         /* Enable fec phy clock */
> > 229         clk = clk_get_sys("pll2", NULL);
> > 230         if (!IS_ERR(clk))
> > 231                 clk_enable(clk);
> > 
> > So, if every board seems to need this, I'd think this should rather be in the
> > driver? Am I correct or is there something I have overlooked?
> > 
> Hmm, as far as I know, at least m28evk from denx does not need this.
> Different from that imx28 supplies clock to phy on mx28evk board,
> m28evk has phy supply clock to imx28. 
> 
The TX28 derives its PHY clock from the ENET_CLK pin of the
processor. Thus the CLK_ENET_TIME should be enabled by the driver as
mentioned in <20120108033238.GA19721@S2101-09.ap.freescale.net>


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
