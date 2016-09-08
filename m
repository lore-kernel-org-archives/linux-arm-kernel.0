From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 11:20:24 +0200
Subject: [PATCH v2 6/7] clk: sunxi-ng: Add A23 CCU
In-Reply-To: <CAGb2v64JhY7KoaxGkpeGinLZ2GoYWyDj+UjE_JwLW_4sVYd_9w@mail.gmail.com>
References: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
 <20160906121837.7517-7-maxime.ripard@free-electrons.com>
 <CAGb2v64jDTWB4faaBdCBCcFrt1WNf=PYwc16kpgsUhaMRudHnQ@mail.gmail.com>
 <20160908082939.GJ8913@lukather>
 <CAGb2v64JhY7KoaxGkpeGinLZ2GoYWyDj+UjE_JwLW_4sVYd_9w@mail.gmail.com>
Message-ID: <20160908092024.GM8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 04:32:25PM +0800, Chen-Yu Tsai wrote:
> On Thu, Sep 8, 2016 at 4:29 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Wed, Sep 07, 2016 at 03:24:11PM +0800, Chen-Yu Tsai wrote:
> >> > +               [CLK_BUS_MSGBOX]        = &bus_msgbox_clk.common.hw,
> >>
> >> A23 manual and Allwinner sources say there is a bus gate for SPINLOCK.
> >> Tested it myself, and it indeed exists.
> >
> > Yes, sorry. It was supposed to be spinlock instead of msgbox.
> >
> >> > +       [RST_BUS_SPINLOCK]      =  { 0x2c4, BIT(22) },
> >>
> >> Allwinner sources say there is a reset control for MSGBOX.
> >> Tested it myself, and it indeed exists.
> >
> > However, the msgbox is mentionned nowhere in the datasheet.
> >
> > I'd prefer to be able to test that it actually works before adding it
> > to the clock driver.
> 
> I did in fact test it. With reset asserted, writes get ignored,
> and reads produce all 0s. With the reset deasserted and clock
> enabled, reads give the default value and writes stick. Afterwards
> when I toggle the reset, the values revert to the default.

Ok.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/97a9d8d9/attachment.sig>
