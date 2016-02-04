From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Feb 2016 09:01:09 +0100
Subject: [PATCH 04/14] clk: sunxi: add ahb1 clock for A83T
In-Reply-To: <CAEzqOZuBz2jexvZvvtkvjbE8UtzUMKL9nT5JJ9JcvMPmzEKTcQ@mail.gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-5-git-send-email-vishnupatekar0510@gmail.com>
 <20160202131725.GQ4652@lukather>
 <CAEzqOZuBz2jexvZvvtkvjbE8UtzUMKL9nT5JJ9JcvMPmzEKTcQ@mail.gmail.com>
Message-ID: <20160204080109.GA4270@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 02:06:45PM +0800, Vishnu Patekar wrote:
> Hello Maxime,
> 
> 
> On Tue, Feb 2, 2016 at 9:17 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Sun, Jan 31, 2016 at 09:20:56AM +0800, Vishnu Patekar wrote:
> >> AHB1 on A83T is similar to ahb1 on A31, except parents are different.
> >> clock index 0b1x is PLL6.
> >>
> >> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> >
> > If the clock is the same but the parents are different, then we don't
> > need to duplicate all the logic. Simply add the number of parents to
> > mux_data, and you're all set.
> 
> Problem here is: parent 0b10 for A31 ahb1 is AXI, 0b11 is pll6/pre_div.
> 0b10 and 0b11 is pll6/pre_div.
> So, just adding number of parents to mux_data will not solve problem.

Is anyone using 0b11 ? Can't we just ignore it?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160204/27906fdc/attachment.sig>
