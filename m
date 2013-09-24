From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Sep 2013 11:54:18 -0400
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <5241AC52.7000808@keymile.com>
References: <504DFBBF.5010202@free-electrons.com>
 <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
 <20120927082955.GR17667@game.jcrosoft.org>
 <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
 <52416F97.802@keymile.com>
 <20130924120152.GI11119@titan.lakedaemon.net>
 <5241AC52.7000808@keymile.com>
Message-ID: <20130924155418.GJ11119@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 05:14:26PM +0200, Gerlando Falauto wrote:
> On 09/24/2013 02:01 PM, Jason Cooper wrote:
> >We are strongly encouraging all vendors to upgrade their bootloaders to
> >support field upgradeable dtbs.  eg having the dtb on a separate
> >partition of the flash (or whereever the bootloader environment is)
> 
> This will most definitely be the case for future boards, but we sort
> of follow the unspoken guideline of not upgrading u-boot on
> field-deployed units. Arguable at least, but that's the way it is.

Understandable.

> >Have you tried kwboot over serial?  It can be found in barebox and u-boot source repositories.
> 
> Uhm, yes, I've used it a few times... but what are you suggesting?
> That u-boot can be upgraded? Yes, I believe that... ;-)

I'm suggesting that I primarily talk to hobbyists and tinkerers, and
occasionally forget there are people that have jtag access :-P

> >The above is the long-term goal, in the short term, please take a look
> >at:
> >
> >https://github.com/zonque/pxa-impedance-matcher
> >
> >You can use this to boot a modern fdt kernel on a legacy bootloader,
> >with one or more dtb's linked in.  I tested it on the dreamplug, so it's
> >mostly there for you.
> >
> >The big outstanding TODO I have on it is to parse the atags and modify
> >the selected dtb before passing off to the kernel.  Patches welcome! :)
> 
> Thank you, I had a quick look at the README and it sounds great!
> But CONFIG_APPENDED_DTB already does the job of filling this gap for me...

Right, it's intended as a replacement for APPENDED_DTB since it can
handle multiple dtbs (so you can do one multiplatform zImage), and you
can hack around custom vendor atags.  eg ethernet mac addresses, Thomas'
CP15 register base address hack, etc.  All that goodness without
polluting the kernel source.  :)

thx,

Jason.
