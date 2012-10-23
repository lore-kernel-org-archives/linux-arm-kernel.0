From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Oct 2012 13:42:56 +0300
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <CACRpkdZhUwMTg0suqbZiukN7Se6fzdYP3-0Dspm9WF6qZniNVQ@mail.gmail.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
 <508664CA.7000601@ti.com>
 <CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com>
 <20121023100333.GA24418@arwen.pp.htv.fi>
 <20121023122312.56b23e1c@skate>
 <CACRpkdb+f44jw1vTYvJT0bnMOP8XQe8ztDUHiwtS2JHtPWAGXw@mail.gmail.com>
 <20121023102903.GA24820@arwen.pp.htv.fi>
 <CACRpkdZhUwMTg0suqbZiukN7Se6fzdYP3-0Dspm9WF6qZniNVQ@mail.gmail.com>
Message-ID: <20121023104256.GB24820@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 23, 2012 at 12:45:33PM +0200, Linus Walleij wrote:
> On Tue, Oct 23, 2012 at 12:29 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Tue, Oct 23, 2012 at 12:29:28PM +0200, Linus Walleij wrote:
> 
> >> So the biggest implementation of the notifier approach to resource
> >> handling is the SH clock thing:
> >> drivers/base/power/clock_ops.c
> >
> > that's different right ? It's just creating the list of clocks, device
> > drivers still have to call pm_clk_add().
> >
> > That's ok, I guess, otherwise all struct device would allocate memory
> > which hardly ever used (so far).
> 
> Hm so I have had this idea of runtime PM core helping out
> with pins, so I could add something like
> 
> pm_pins_fetch()
> pm_pins_default()
> pm_pins_idle()
> pm_pins_sleep()
> 
> So if one is using the pin states defined in <linux/pinctrl/pinctrl-state.h>
> then the PM core can help out in keeping track of the pins
> and states, and the driver will just tell the PM core what
> to do and when.
> 
> Would this fit the bill for everyone's code consolidation needs?
> It would sure work for us...
> 
> It however require that no custom states are used and that we
> keep to the state semantics I just happen to think is most
> common.

>From a quick read, it looks ok. I guess problems will only how up when
we actually end up with a silicon errata or something similar which
mandates that we change pin's state at a particular location. Not sure
if we have those yet.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/371d0eb0/attachment-0001.sig>
