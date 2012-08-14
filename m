From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 14 Aug 2012 22:32:24 +0200
Subject: [PATCH] ARM: mxc: ssi-fiq: Make ssi-fiq.S Thumb-2 compatible
In-Reply-To: <CAKGA1bmk2TqDwxR=RT+z3y8XaSpcW+kHsaQfmdrHVqTD9Uxv5A@mail.gmail.com>
References: <1344599604-9623-1-git-send-email-dave.martin@linaro.org>
 <20120813193517.GU1451@pengutronix.de>
 <CAKGA1bnRA61JT8tQoHBay+6BSxDO5egiagQm1v05L7Asf+qJ+Q@mail.gmail.com>
 <20120814114059.GX1451@pengutronix.de>
 <CAKGA1bmk2TqDwxR=RT+z3y8XaSpcW+kHsaQfmdrHVqTD9Uxv5A@mail.gmail.com>
Message-ID: <20120814203224.GF1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 12:49:43PM -0500, Matt Sealey wrote:
> On Tue, Aug 14, 2012 at 6:40 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Mon, Aug 13, 2012 at 05:28:17PM -0500, Matt Sealey wrote:
> >>  IMX_PIN_REG(MX51_PAD_EIM_DA15, NO_PAD, 0x058, 0, 0x000, 0), /*
> >> MX51_PAD_EIM_DA15__EIM_DA15 */
> >>
> >>
> >>
> >> On Mon, Aug 13, 2012 at 2:35 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >> > Hi Dave,
> >> >
> >> > On Fri, Aug 10, 2012 at 12:53:24PM +0100, Dave Martin wrote:
> >> >> Because FIQ handlers get copied straight into the vectors page to
> >> >> the FIQ vector entry point, FIQ handlers in a Thumb-2 kernel must
> >> >> start in Thumb-2.  A Thumb-2 kernel enters all exception vectors in
> >> >> Thumb-2.
> >> >
> >> > I finally came along testing this. I have no Thumb2 capable hardware
> >> > to test if it works in thumb2 mode, but at least in Arm mode it works.
> >> > This is enough to not introduce a regression, so we can go for this.
> >>
> >> This is the interesting dichotomy; the code is only required truly on
> >> devices where Thumb2 isn't available, right?
> >
> > It is also used on the i.MX51 Eukrea board. I asked Eric (Cced) to test
> > it in thumb2 mode, no response so far. I don't know the reason why he
> > uses FIQ mode instead of SDMA, maybe simply historical reasons.
> 
> If we can lose that requirement then the only thing in the way is the
> phyCORE support, which goes away on a "pure" v7 config anyway,
> correct? I was just thinking, why not split v6_v7_defconfig into a
> v7_defconfig losing those boards anyway and enable Thumb2 by default
> while we're at it? It would mean more testing gets done and this error
> would crop up both more often, but be less surprising and won't take a
> year to revisit ;)

It took a long time until all people have realized that their code may
not only run on the SoC they are currently working on, but also on other
SoCs. Having many SoCs in a single defconfig makes this fact more
obvious and often breaks compilation if their code is not multi SoC
safe. I don't really want to lose this.

Hopefully we will soon only have a handfull of ARM defconfigs anyway.
Until this is the case I vote for not splitting up defconfigs. Then we
can have things like thumb2_defconfig, armv6_defconfig,...

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
