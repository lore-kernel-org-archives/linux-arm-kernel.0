From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Tue, 24 Jan 2017 18:24:55 +0100 (CET)
Subject: [PATCH 00/22] Conversion of ARMv4 Gemini to DT and multiplatform
In-Reply-To: <CACRpkdbdsNU6pOcewyZw_jpXzXvm_aj0FURY7Ty5FkT227iZ=Q@mail.gmail.com>
References: <20170122121506.9995-1-linus.walleij@linaro.org>
 <8e705d3a-ff99-23b2-c4c9-2edccf134cac@gmail.com>
 <CACRpkdbdsNU6pOcewyZw_jpXzXvm_aj0FURY7Ty5FkT227iZ=Q@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1701241734140.2736@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

thanks for the work converting Gemini to DT.

On Sun, 22 Jan 2017, Linus Walleij wrote:

> On Sun, Jan 22, 2017 at 7:42 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > On 01/22/2017 04:15 AM, Linus Walleij wrote:
> >> I got a Gemini platform from Florian Fainelli over at OpenWRT
> >> some time back. I finally got around to "future-proofing" the
> >> platform, which was the idea when he paintakingly sent the box
> >> over to me.
> >
> > I would have happily tested that series ;) thanks a lot for making it
> > happen!
> 
> There is a git branch here:
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-nomadik.git/log/?h=gemini
> 
> I collect info and instructions to get it running here:
> https://dflund.se/~triad/krad/gemini/
> 
> >> The OpenWRT tree still have a whole bunch of significant out-of
> >> tree drivers:
> >>
> >> - Watchdog
> >> - GMAC (ethernet)
> >
> > Been wondering about the GMAC driver a little bit, and it does not
> > appear to be neither a Synopsys/Designware core (although not 100%
> > sure), nor the ftgmac100 either.
> >
> > This submission does appear to be in a good shape:
> > https://lwn.net/Articles/437889/
> 

AFAICR
This is a dual GMAC !

They are two different base address for each GMAC and one shared
base address for both of them.
This is all in one address space which remaps the driver.

And to make it worse two interrupt lines, one of them is also shared.

Any ideas to "convert" this into DT ??
Because I think it's impossible to split both GMAC interfaces ??

Greetings
Hans Ulli Kroll
