From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 14 Jul 2015 17:46:39 +0800
Subject: [PATCH v3 4/5] clk: mediatek: Add USB clock support in MT8173
 APMIXEDSYS
In-Reply-To: <CAGS+omAb8t0sLP1DHoa6z1-XweWUwOJQhqydofWZ+YiyPXzxhA@mail.gmail.com>
References: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
 <1436522405-13923-5-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omBryA6f6gYje5RvF2XcJiebogYCHpyWNeN9K4B-MiHf1Q@mail.gmail.com>
 <1436841935.9416.10.camel@mtksdaap41>
 <CAGS+omAb8t0sLP1DHoa6z1-XweWUwOJQhqydofWZ+YiyPXzxhA@mail.gmail.com>
Message-ID: <1436867199.9416.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, 2015-07-14 at 11:23 +0800, Daniel Kurtz wrote:
> On Tue, Jul 14, 2015 at 10:45 AM, James Liao <jamesjj.liao@mediatek.com> wrote:
> > On Mon, 2015-07-13 at 22:46 +0800, Daniel Kurtz wrote:
> >> > +static const struct clk_ops mtk_ref2usb_tx_ops = {
> >> > +       .is_prepared    = mtk_ref2usb_tx_is_prepared,
> >> > +       .prepare        = mtk_ref2usb_tx_prepare,
> >> > +       .unprepare      = mtk_ref2usb_tx_unprepare,
> >> > +};
> >>
> >> Burying the implementation of this special "mtk_ref2usb" clock in
> >> clk-mt8173,c seems a bit awkward.
> >> Can you please move it to its own file, like mediatek/clk-usb.c?
> >
> > Do you mean clk/mediatek/clk-usb.c?
> >
> > This clock is a MT8173 specific clock, which may not be reused by other
> > SoCs. So I think it's not necessary to move it to a separated file.
> 
> Yes, this is a wrapper for a type of clock.  I think it would be
> better in its own file, rather than embedded in clk-mt8173.c, which is
> more about enumerating and initializing the clock tree.
> 
> Perhaps today it is only used for mt8173, but that may not be the case
> in the future.

OK, I'll separate it from clk-mt8173.c.

Ref2usb_tx's control register is located in APMIXEDSYS, which contains
most of PLL controlling. Is this clock suitable to implemented
mtk-pll.c? Or it's proper to be a separated file such as clk-usb.c?


Best regards,

James
