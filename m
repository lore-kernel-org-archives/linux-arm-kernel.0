From: horms@verge.net.au (Simon Horman)
Date: Wed, 4 Mar 2015 16:02:59 +0900
Subject: [PATCH/RFC] ARM: shmobile: r8a7790: Fix HSUSB clock to hp_clk
 from mp_clk
In-Reply-To: <CAMuHMdUHMA+cJTGWS-0Prt6-BT5=UkGQ4OWZ+bz-g2G7DSwLzw@mail.gmail.com>
References: <1424011746-3787-2-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdX=cdHaiHCnYsJvZFc2RNv=Pk8cLXuvkezg4Ht4U4mXsg@mail.gmail.com>
 <20150216135754.GA5479@verge.net.au>
 <CAMuHMdUHMA+cJTGWS-0Prt6-BT5=UkGQ4OWZ+bz-g2G7DSwLzw@mail.gmail.com>
Message-ID: <20150304070258.GA16597@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Mon, Feb 16, 2015 at 03:04:16PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Feb 16, 2015 at 2:57 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Feb 16, 2015 at 10:20:10AM +0100, Geert Uytterhoeven wrote:
> >> Hi Kaneko-san, Mizuguchi-san,
> >>
> >> On Sun, Feb 15, 2015 at 3:49 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> >> > From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >> >
> >> > HSUSB uses hp_clk for H/W register access.
> >>
> >> That indeed seems to be true, and that's what this patch is changing.
> >>
> >> > HSUSB uses mp_clk for USB-DMAC access.
> >>
> >> However, page 64-2 doesn't mention the MP clock for USB-DMAC:
> >>    "AXI bus clock (ZS?: 260 MHz), HPB bus clock (HP?: 130 MHz).
> >>     USB local bus clock (48 MHz)"
> >> So your statement doesn't seem to be true?
> >
> > Thanks, I see that too.
> >
> >> Note that mstp3_clks in dtsi has hp_clk as the parent for both usbdmac0 and
> >> usbdmac1, so if your statement would be true, that has to changed, too?
> >>
> >> The same is true for other members of the R-Car Gen2 family, e.g. your patch
> >> for r8a7791.
> >
> > It seems to me that we could:
> >
> > 1. Apply this patch with the changelog updated and;
> > 2. Follow up on the DMAC clocks
> >
> > Does that sound reasonable to you?
> 
> Yes, that sounds fine to me.

The purpose of this email is to offer a quick status update which
I hope will bring this matter to a close.

I have submitted and queued up a patch as per 1. above.

With regards to item 2. above: I have also followed up on the "HSUSB uses
mp_clk for USB-DMAC access" comment in the original changelog (above).
Mizuguchi-san has confirmed that statement is not correct and its presence
in the changelog was an error.
