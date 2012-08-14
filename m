From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 14 Aug 2012 13:40:59 +0200
Subject: [PATCH] ARM: mxc: ssi-fiq: Make ssi-fiq.S Thumb-2 compatible
In-Reply-To: <CAKGA1bnRA61JT8tQoHBay+6BSxDO5egiagQm1v05L7Asf+qJ+Q@mail.gmail.com>
References: <1344599604-9623-1-git-send-email-dave.martin@linaro.org>
 <20120813193517.GU1451@pengutronix.de>
 <CAKGA1bnRA61JT8tQoHBay+6BSxDO5egiagQm1v05L7Asf+qJ+Q@mail.gmail.com>
Message-ID: <20120814114059.GX1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 05:28:17PM -0500, Matt Sealey wrote:
>  IMX_PIN_REG(MX51_PAD_EIM_DA15, NO_PAD, 0x058, 0, 0x000, 0), /*
> MX51_PAD_EIM_DA15__EIM_DA15 */
> 
> 
> 
> On Mon, Aug 13, 2012 at 2:35 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Hi Dave,
> >
> > On Fri, Aug 10, 2012 at 12:53:24PM +0100, Dave Martin wrote:
> >> Because FIQ handlers get copied straight into the vectors page to
> >> the FIQ vector entry point, FIQ handlers in a Thumb-2 kernel must
> >> start in Thumb-2.  A Thumb-2 kernel enters all exception vectors in
> >> Thumb-2.
> >
> > I finally came along testing this. I have no Thumb2 capable hardware
> > to test if it works in thumb2 mode, but at least in Arm mode it works.
> > This is enough to not introduce a regression, so we can go for this.
> 
> This is the interesting dichotomy; the code is only required truly on
> devices where Thumb2 isn't available, right?

It is also used on the i.MX51 Eukrea board. I asked Eric (Cced) to test
it in thumb2 mode, no response so far. I don't know the reason why he
uses FIQ mode instead of SDMA, maybe simply historical reasons.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
