From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Nov 2012 17:52:07 +0000
Subject: vexpress issues in next-20121029
In-Reply-To: <1352135973.10947.23.camel@hornet>
References: <508EE610.9050703@wwwdotorg.org>
 <201211051647.19785.arnd@arndb.de> <1352135973.10947.23.camel@hornet>
Message-ID: <201211051752.08400.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 November 2012, Pawel Moll wrote:
> On Mon, 2012-11-05 at 16:47 +0000, Arnd Bergmann wrote:
> > I've just tried pulling in your branch again, but it appears unchanged:
> > The patches are still based on 807e45b328, which is a different commit
> > from bcd6f569e874 that is in Mike's tree. Please do as I asked you before
> > and rebase on top of the commit that you sent him,
> 
> Ok, I think I got the idea now. Sorry about not catching up straight
> away...
> 
> The following changes since commit bcd6f569e87471d7f104bd9497f0b516a3b12e32:
> 
>   clk: Common clocks implementation for Versatile Express (2012-10-29 11:08:03 -0700)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/pawelmoll/linux.git vexpress-clk-soc
> 
> for you to fetch changes up to 433683a66401adb0150792e725cc4f631c94de46:

Ok, thanks!

I've put it into the next/soc2 branch now, separate from the earlier next/soc
branch, since we now have a dependency on another branch.


>   ARM: vexpress: Remove motherboard dependencies in the DTS files (2012-11-05 17:09:52 +0000)
> 
> >  and make sure that this is a commit that Mike never rebases.
> 
> Uh. Mike, is your clk-next subject to rebases?

On a related note, there are other patches below this one now:

  clk: Common clocks implementation for Versatile Express
  clk: Versatile Express clock generators ("osc") driver
  CLK: clk-twl6040: Initial clock driver for OMAP4+ McPDM fclk clock
  clk: fix return value check in sirfsoc_of_clk_init()
  clk: fix return value check in of_fixed_clk_setup()
  clk: ux500: Update sdmmc clock to 100MHz for u8500
  clk: ux500: Support prcmu ape opp voltage clock
  mfd: dbx500: Export prmcu_request_ape_opp_100_voltage
  clk: Don't return negative numbers for unsigned values with !clk
  clk: Fix documentation typos
  clk: Document .is_enabled op
  clk: SPEAr: Vco-pll: Fix compilation warning

Mike, do you prefer us to wait for those to make it into v3.8-rc1 before
pushing the patches from Pawel, or can we just send the entire branch
along with the other changes?

FWIW, there is a way to avoid dependencies like this if the patches that
are required in two branches are based directly on an -rc release and
then merged into the two maintainer trees, rather than having one maintainer
tree pull in (part of) the history of another one.

	Arnd
