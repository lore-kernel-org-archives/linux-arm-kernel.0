From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 12 Jun 2015 19:05:34 +0200
Subject: [PATCH 0/5] Add Mediatek MT8173 subsystem clocks support
In-Reply-To: <20150611235212.GI29640@codeaurora.org>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <20150608074858.GK6325@pengutronix.de>
 <20150611235212.GI29640@codeaurora.org>
Message-ID: <31179881.mpd5ayrmF7@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 11, 2015 04:52:12 PM Stephen Boyd wrote:
> On 06/08, Sascha Hauer wrote:
> > On Fri, Jun 05, 2015 at 05:59:12PM -0700, Stephen Boyd wrote:
> > > And similar things could be done for the reset driver.
> > 
> > The problem I see with this approach is that we scatter the code for a
> > otherwise simple driver over a bunch of directories. We would have
> > 
> > drivers/clk/mediatek/vencsys.c
> > drivers/reset/mediatek/vencsys.c
> > drivers/soc/mediatek/vencsys.c
> > 
> > The same must be added for vdecsys, imgsys and vencltsys. That will make
> > 12 drivers and three maintainers for 12 registers.  I think this will be
> > a pain to maintain, hence my suggestion to put the vencsys code into a
> > single file and not split this up into more subsystem specific files.
> 
> I probably don't have enough information here, but why is it a
> pain to maintain? It seems more like a pain to setup the first
> time and then little to no pain to maintain because we clearly
> split functionality based on subsystem. No merge conflicts, clear
> division of functionality, etc. But again, I don't think it
> matters much either way given that reset and clk drivers are
> combined sometimes and don't always reside in drivers/clk or
> drivers/reset either.

Actually I would prefer to have the clock and resets in drivers/clk, just as 
we already did for Mediatek up to now.
