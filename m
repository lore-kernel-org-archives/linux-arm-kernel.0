From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 16 May 2017 10:00:09 +0200
Subject: [PATCH 2/2 v2] reset: Add a Gemini reset controller
In-Reply-To: <CACRpkdbjFgCJwjZ8j8XfmOEDqQYHZdLNoswgfC83yAoTdyyz_g@mail.gmail.com>
References: <20170508200740.26194-1-linus.walleij@linaro.org>
 <1494593270.2965.5.camel@pengutronix.de>
 <CACRpkdbjFgCJwjZ8j8XfmOEDqQYHZdLNoswgfC83yAoTdyyz_g@mail.gmail.com>
Message-ID: <1494921609.2941.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-05-15 at 19:07 +0200, Linus Walleij wrote:
> On Fri, May 12, 2017 at 2:47 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > On Mon, 2017-05-08 at 22:07 +0200, Linus Walleij wrote:
> >> The Cortina Systems Gemini reset controller is a simple
> >> 32bit register with self-deasserting reset lines. It is
> >> accessed using regmap over syscon.
> >>
> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >> ---
> >> ChangeLog v1->v2:
> >> - Add an explicit GPL license statement.
> >> - Move the reset controller to be identical to the sycon
> >>   node, no need to a separate child node for this.
> >> - Drop unneeded struct device *dev pointer from state
> >>   container.
> >> - Print error code on missing regmap.
> >> - Use #define from the <dt-bindings/*> to indicate that we
> >>   always set the CPU1 reset line to 1 when writing the
> >>   resets.
> >
> > Thank you, looks good to me. I'll include this with the next pull
> > request after v4.12-rc1 is released.
> 
> I have to repost it because Rob requested that the reset
> controller and clock controller be probed directly from the
> system controller without any special reset/clock nodes.
> 
> I was planning to ask you to ACK it for merge through
> ARM SoC instead: as it uses the <dt-bindings/*> things
> and that needs to be there to work with the DTS files, we
> either need to merge this wholesome through ARM SoC,
> or we apply the binding patch into all three trees
> (either works with me).

Merging through arm-soc is fine, I've dropped the v2 patches from my
branch.

regards
Philipp
