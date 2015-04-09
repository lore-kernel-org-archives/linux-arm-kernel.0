From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Apr 2015 22:23:02 +0200
Subject: [PATCH 1/6] ARM: lpc18xx: add basic support for NXP LPC18xx/43xx
 SoCs
In-Reply-To: <551DC1DF.5030105@vanguardiasur.com.ar>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
 <CAGhQ9VxK1ytLCNWY+6dKwWUkU_BuEV8vrhVfBDgfnovffLbfpg@mail.gmail.com>
 <551DC1DF.5030105@vanguardiasur.com.ar>
Message-ID: <4720554.gd8OQ0bv0v@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 April 2015 19:25:35 Ezequiel Garcia wrote:
> On 04/02/2015 01:48 PM, Joachim Eastwood wrote:
> > On 2 April 2015 at 16:21, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Wednesday 01 April 2015 23:20:38 Joachim Eastwood wrote:
> >>> +static const char *const lpc18xx_43xx_compat[] __initconst = {
> >>> +       "ea,lpc4357-developers-kit",
> >>> +       NULL
> >>>
> >>
> >> I don't see 'ea' in Documentation/devicetree/bindings/vendor-prefixes.txt,
> >> can you add a patch for that?
> > 
> > Sure. I'll add it to the next version.
> > 
> >> It's probably better to make the string we match against the most
> >> generic one here, so we don't have to update the list for every
> >> new dts file that gets added.
> > 
> > Okey.
> > 
> > Could I just use a SoC string here (like "nxp.lpc1850")?
> > 
> 
> Yeah, that should work. Or maybe you can use "nxp,lpc18xx" and use that
> compatible as a generic compatible for all LPC18xx/LPC43xx MCUs.
> 

Sorry for the late follow-up. nxp,lpc18xx would not be appropriate here,
because compatible strings are supposed to be specific models, not wildcards.
nxp,lpc1850 is fine.

	Arnd
